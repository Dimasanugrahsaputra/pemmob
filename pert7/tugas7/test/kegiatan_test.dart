import 'package:flutter_test/flutter_test.dart';
import 'package:tugas7/models/kegiatan.dart';

void main() {
  group('Model Kegiatan', () {
    test('Konversi kegiatan menjadi Map', () {
      const kegiatan = Kegiatan(
        id: 1,
        judul: 'Belajar Flutter',
        tanggal: '2026-10-26',
        selesai: true,
        tipe: Tipe.tanpa,
        nominal: 0,
        kategori: '-',
      );

      final hasil = kegiatan.toMap();

      expect(hasil['id'], 1);
      expect(hasil['judul'], 'Belajar Flutter');
      expect(hasil['selesai'], 1);
      expect(hasil['tipe'], 'tanpa');
      expect(hasil['nominal'], 0);
    });

    test('Konversi Map menjadi kegiatan', () {
      final kegiatan = Kegiatan.fromMap({
        'id': 2,
        'judul': 'Makan Siang',
        'tanggal': '2026-10-26',
        'selesai': 0,
        'tipe': 'pengeluaran',
        'nominal': 15000,
        'kategori': 'Makan',
      });

      expect(kegiatan.id, 2);
      expect(kegiatan.selesai, false);
      expect(kegiatan.tipe, Tipe.pengeluaran);
      expect(kegiatan.nominal, 15000);
      expect(kegiatan.kategori, 'Makan');
    });
  });

  group('Perhitungan Keuangan', () {
    test('Tabungan harian positif', () {
      const ringkasan = Ringkasan(
        jumlahKegiatan: 4,
        selesai: 2,
        pemasukan: 50000,
        pengeluaran: 25000,
      );

      expect(ringkasan.tabungan, 25000);
      expect(ringkasan.selesai, 2);
      expect(ringkasan.jumlahKegiatan, 4);
    });

    test('Tabungan harian negatif', () {
      const ringkasan = Ringkasan(
        jumlahKegiatan: 2,
        selesai: 1,
        pemasukan: 10000,
        pengeluaran: 15000,
      );

      expect(ringkasan.tabungan, -5000);
    });
  });
}
