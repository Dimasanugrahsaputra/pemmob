import 'dart:async';

import 'package:flutter/material.dart';

import '../data/db_helper.dart';
import '../models/kegiatan.dart';
import '../state/pengaturan.dart';
import '../utils/format.dart';
import '../widgets/kegiatan_tile.dart';
import '../widgets/ringkasan_card.dart';
import 'form_kegiatan_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key, required this.pengaturan});

  final Pengaturan pengaturan;

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _DataHari {
  const _DataHari(this.kegiatan, this.ringkasan);

  final List<Kegiatan> kegiatan;
  final Ringkasan ringkasan;
}

class _BerandaPageState extends State<BerandaPage> {
  final TextEditingController _pencarian = TextEditingController();
  final Set<int> _idSedangDiproses = <int>{};

  Timer? _debounce;
  Tipe? _filter;
  _DataHari? _data;
  Object? _galat;
  bool _sedangMemuat = true;
  int _nomorPermintaan = 0;

  @override
  void initState() {
    super.initState();
    versiData.addListener(_muat);
    unawaited(_muatData(++_nomorPermintaan));
  }

  Future<_DataHari> _ambil() async {
    final tanggal = formatTanggalDatabase(DateTime.now());
    final hasil = await Future.wait<Object>([
      DbHelper.cariPada(tanggal, pencarian: _pencarian.text, tipe: _filter),
      DbHelper.ringkasan(tanggal),
    ]);

    return _DataHari(hasil[0] as List<Kegiatan>, hasil[1] as Ringkasan);
  }

  Future<void> _muatData(int nomorPermintaan) async {
    try {
      final hasil = await _ambil();
      if (!mounted || nomorPermintaan != _nomorPermintaan) return;

      setState(() {
        _data = hasil;
        _galat = null;
        _sedangMemuat = false;
      });
    } catch (error) {
      if (!mounted || nomorPermintaan != _nomorPermintaan) return;

      setState(() {
        _galat = error;
        _sedangMemuat = false;
      });
    }
  }

  void _muat() {
    final nomorPermintaan = ++_nomorPermintaan;
    setState(() {
      _sedangMemuat = true;
      _galat = null;
    });
    unawaited(_muatData(nomorPermintaan));
  }

  void _cari(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), _muat);
  }

  Future<void> _ubahSelesai(Kegiatan kegiatan, bool selesai) async {
    final id = kegiatan.id;
    final dataSaatIni = _data;

    if (id == null ||
        dataSaatIni == null ||
        kegiatan.selesai == selesai ||
        _idSedangDiproses.contains(id)) {
      return;
    }

    // Tampilkan perubahan segera; jangan menunggu query SQLite selesai.
    // Abaikan hasil query lama agar tidak menimpa status baru di layar.
    _nomorPermintaan++;
    final ringkasanLama = dataSaatIni.ringkasan;
    final perubahanSelesai = selesai ? 1 : -1;
    final jumlahSelesai = (ringkasanLama.selesai + perubahanSelesai)
        .clamp(0, ringkasanLama.jumlahKegiatan)
        .toInt();

    setState(() {
      _idSedangDiproses.add(id);
      _sedangMemuat = false;
      _galat = null;
      _data = _DataHari(
        [
          for (final item in dataSaatIni.kegiatan)
            if (item.id == id) item.copyWith(selesai: selesai) else item,
        ],
        Ringkasan(
          jumlahKegiatan: ringkasanLama.jumlahKegiatan,
          selesai: jumlahSelesai,
          pemasukan: ringkasanLama.pemasukan,
          pengeluaran: ringkasanLama.pengeluaran,
        ),
      );
    });

    try {
      // DbHelper otomatis memperbarui versiData setelah SQLite sukses.
      // Listener _muat kemudian menyelaraskan tampilan dengan database.
      await DbHelper.ubahSelesai(id, selesai);
    } catch (error) {
      if (!mounted) return;
      _muat();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengubah status kegiatan: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _idSedangDiproses.remove(id));
      }
    }
  }

  Future<void> _form([Kegiatan? kegiatan]) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => FormKegiatanPage(kegiatan: kegiatan)),
    );
  }

  Future<void> _hapus(Kegiatan kegiatan) async {
    final setuju = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus kegiatan?'),
        content: Text('"${kegiatan.judul}" akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (setuju == true && kegiatan.id != null) {
      try {
        await DbHelper.hapus(kegiatan.id!);
      } catch (error) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus kegiatan: $error')),
        );
      }
    }
  }

  @override
  void dispose() {
    versiData.removeListener(_muat);
    _debounce?.cancel();
    _pencarian.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = _data;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TabungKu — Hari Ini'),
        actions: [
          IconButton(
            onPressed: _muat,
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _form(),
        icon: const Icon(Icons.add),
        label: const Text('Kegiatan'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        children: [
          Text(formatTanggalPanjang(DateTime.now())),
          const SizedBox(height: 14),
          TextField(
            controller: _pencarian,
            onChanged: _cari,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              labelText: 'Cari kegiatan / kategori',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                tooltip: 'Hapus pencarian',
                onPressed: () {
                  _debounce?.cancel();
                  _pencarian.clear();
                  _muat();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<Tipe?>(
            initialValue: _filter,
            decoration: const InputDecoration(
              labelText: 'Filter jenis',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem<Tipe?>(value: null, child: Text('Semua jenis')),
              DropdownMenuItem<Tipe?>(
                value: Tipe.tanpa,
                child: Text('Tanpa uang'),
              ),
              DropdownMenuItem<Tipe?>(
                value: Tipe.pemasukan,
                child: Text('Pemasukan'),
              ),
              DropdownMenuItem<Tipe?>(
                value: Tipe.pengeluaran,
                child: Text('Pengeluaran'),
              ),
            ],
            onChanged: (tipe) {
              setState(() => _filter = tipe);
              _muat();
            },
          ),
          const SizedBox(height: 12),
          if (_sedangMemuat) const LinearProgressIndicator(),
          if (data == null && _sedangMemuat)
            const Center(child: CircularProgressIndicator()),
          if (data == null && _galat != null)
            Center(child: Text('Gagal memuat data: $_galat')),
          if (data != null) ...[
            if (_galat != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('Gagal memperbarui data: $_galat'),
              ),
            RingkasanCard(
              ringkasan: data.ringkasan,
              target: widget.pengaturan.target,
            ),
            const SizedBox(height: 16),
            Text(
              'Daftar Kegiatan (${data.kegiatan.length})',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (data.kegiatan.isEmpty)
              const Padding(
                padding: EdgeInsets.all(30),
                child: Center(child: Text('Belum ada kegiatan yang cocok.')),
              ),
            for (final kegiatan in data.kegiatan)
              KegiatanTile(
                key: ValueKey(kegiatan.id),
                kegiatan: kegiatan,
                onSelesai: (selesai) => _ubahSelesai(kegiatan, selesai),
                onUbah: () => _form(kegiatan),
                onHapus: () => _hapus(kegiatan),
              ),
          ],
        ],
      ),
    );
  }
}
