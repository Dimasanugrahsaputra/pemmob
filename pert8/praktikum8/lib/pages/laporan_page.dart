import 'package:flutter/material.dart';

import '../data/db_helper.dart';
import '../models/kegiatan.dart';
import '../utils/format.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanData {
  const _LaporanData(this.ringkasan, this.kategori);
  final Ringkasan ringkasan;
  final Map<String, int> kategori;
}

class _LaporanPageState extends State<LaporanPage> {
  DateTime _tanggal = DateTime.now();
  late Future<_LaporanData> _future;

  @override
  void initState() {
    super.initState();
    _future = _ambil();
    versiData.addListener(_muat);
  }

  Future<_LaporanData> _ambil() async {
    final tanggal = formatTanggalDatabase(_tanggal);
    final hasil = await Future.wait<Object>([
      DbHelper.ringkasan(tanggal),
      DbHelper.pengeluaranPerKategori(tanggal),
    ]);
    return _LaporanData(hasil[0] as Ringkasan, hasil[1] as Map<String, int>);
  }

  void _muat() {
    if (mounted) {
      setState(() => _future = _ambil());
    }
  }

  @override
  void dispose() {
    versiData.removeListener(_muat);
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (tanggal != null) {
      setState(() {
        _tanggal = tanggal;
        _future = _ambil();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Lokal (SQLite)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          OutlinedButton.icon(
            onPressed: _pilihTanggal,
            icon: const Icon(Icons.calendar_month),
            label: Text('Tanggal: ${formatTanggalPanjang(_tanggal)}'),
          ),
          const SizedBox(height: 16),
          FutureBuilder<_LaporanData>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Gagal memuat laporan: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final ringkasan = snapshot.data!.ringkasan;
              final kategori = snapshot.data!.kategori;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Jumlah kegiatan: ${ringkasan.jumlahKegiatan}'),
                  Text('Selesai: ${ringkasan.selesai}'),
                  const SizedBox(height: 8),
                  Text('Pemasukan: ${formatRupiah(ringkasan.pemasukan)}'),
                  Text('Pengeluaran: ${formatRupiah(ringkasan.pengeluaran)}'),
                  Text(
                    'Tabungan: ${formatRupiah(ringkasan.tabungan)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Pengeluaran per kategori',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (kategori.isEmpty) const Text('Belum ada pengeluaran.'),
                  ...kategori.entries.map(
                    (e) => ListTile(
                      title: Text(e.key),
                      trailing: Text(formatRupiah(e.value)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Data layar ini tetap menggunakan SQLite. API server diuji lewat Swagger dan MockClient sesuai Modul 8.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
