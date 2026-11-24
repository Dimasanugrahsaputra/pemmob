import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/kegiatan.dart';

final ValueNotifier<int> versiData = ValueNotifier<int>(0);

class DbHelper {
  DbHelper._();

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    final lokasi = join(await getDatabasesPath(), 'tabungku_pert8.db');
    _database = await openDatabase(
      lokasi,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE kegiatan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            judul TEXT NOT NULL,
            tanggal TEXT NOT NULL,
            selesai INTEGER NOT NULL DEFAULT 0,
            tipe TEXT NOT NULL DEFAULT 'tanpa',
            nominal INTEGER NOT NULL DEFAULT 0,
            kategori TEXT NOT NULL DEFAULT '-'
          )
        ''');
        await db.execute(
          'CREATE INDEX ix_kegiatan_tanggal ON kegiatan (tanggal)',
        );
      },
    );
    return _database!;
  }

  static Future<List<Kegiatan>> cariPada(
    String tanggal, {
    String pencarian = '',
    Tipe? tipe,
  }) async {
    final db = await database;
    final where = <String>['tanggal = ?'];
    final args = <Object?>[tanggal];
    if (pencarian.trim().isNotEmpty) {
      where.add('(judul LIKE ? OR kategori LIKE ?)');
      final pola = '%${pencarian.trim()}%';
      args.addAll([pola, pola]);
    }
    if (tipe != null) {
      where.add('tipe = ?');
      args.add(tipe.name);
    }
    final rows = await db.query(
      'kegiatan',
      where: where.join(' AND '),
      whereArgs: args,
      orderBy: 'selesai ASC, id DESC',
    );
    return rows.map(Kegiatan.fromMap).toList();
  }

  static Future<Ringkasan> ringkasan(String tanggal) async {
    final db = await database;
    final rows = await db.rawQuery(
      '''
      SELECT
        COUNT(*) AS jumlah_kegiatan,
        COALESCE(SUM(CASE WHEN selesai = 1 THEN 1 ELSE 0 END), 0) AS selesai,
        COALESCE(SUM(CASE WHEN tipe = 'pemasukan' THEN nominal ELSE 0 END), 0) AS pemasukan,
        COALESCE(SUM(CASE WHEN tipe = 'pengeluaran' THEN nominal ELSE 0 END), 0) AS pengeluaran
      FROM kegiatan WHERE tanggal = ?
    ''',
      [tanggal],
    );
    return Ringkasan.fromMap(rows.single);
  }

  static Future<Map<String, int>> pengeluaranPerKategori(String tanggal) async {
    final db = await database;
    final rows = await db.rawQuery(
      '''
      SELECT kategori, SUM(nominal) AS total
      FROM kegiatan WHERE tanggal = ? AND tipe = 'pengeluaran'
      GROUP BY kategori ORDER BY total DESC, kategori ASC
    ''',
      [tanggal],
    );
    return {
      for (final row in rows)
        row['kategori'] as String: (row['total'] as num).toInt(),
    };
  }

  static Future<int> tambah(Kegiatan kegiatan) async {
    final db = await database;
    final id = await db.insert('kegiatan', kegiatan.toMap());
    versiData.value++;
    return id;
  }

  static Future<void> ubah(Kegiatan kegiatan) async {
    if (kegiatan.id == null) throw ArgumentError('ID kegiatan wajib ada');
    final db = await database;
    await db.update(
      'kegiatan',
      kegiatan.toMap(),
      where: 'id = ?',
      whereArgs: [kegiatan.id],
    );
    versiData.value++;
  }

  static Future<void> ubahSelesai(int id, bool selesai) async {
    final db = await database;
    await db.update(
      'kegiatan',
      {'selesai': selesai ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    versiData.value++;
  }

  static Future<void> hapus(int id) async {
    final db = await database;
    await db.delete('kegiatan', where: 'id = ?', whereArgs: [id]);
    versiData.value++;
  }
}
