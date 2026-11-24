import 'package:flutter/material.dart';

import '../data/db_helper.dart';
import '../models/kegiatan.dart';
import '../utils/format.dart';

class FormKegiatanPage extends StatefulWidget {
  const FormKegiatanPage({super.key, this.kegiatan});

  final Kegiatan? kegiatan;

  @override
  State<FormKegiatanPage> createState() => _FormKegiatanPageState();
}

class _FormKegiatanPageState extends State<FormKegiatanPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judul;
  late final TextEditingController _nominal;
  late DateTime _tanggal;
  late Tipe _tipe;
  late bool _selesai;
  late String _kategori;
  bool _menyimpan = false;
  static const _kategoriValid = [
    'Makan',
    'Transport',
    'Belajar',
    'Hiburan',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    final kegiatan = widget.kegiatan;
    _judul = TextEditingController(text: kegiatan?.judul ?? '');
    _nominal = TextEditingController(text: '${kegiatan?.nominal ?? 0}');
    _tanggal = kegiatan == null
        ? DateTime.now()
        : DateTime.parse(kegiatan.tanggal);
    _tipe = kegiatan?.tipe ?? Tipe.tanpa;
    _selesai = kegiatan?.selesai ?? false;
    _kategori = _kategoriValid.contains(kegiatan?.kategori)
        ? kegiatan!.kategori
        : _kategoriValid.first;
  }

  @override
  void dispose() {
    _judul.dispose();
    _nominal.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (tanggal != null) setState(() => _tanggal = tanggal);
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate() || _menyimpan) return;
    final nominal = _tipe == Tipe.tanpa ? 0 : int.parse(_nominal.text.trim());
    final kegiatan = Kegiatan(
      id: widget.kegiatan?.id,
      judul: _judul.text.trim(),
      tanggal: formatTanggalDatabase(_tanggal),
      tipe: _tipe,
      selesai: _selesai,
      nominal: nominal,
      kategori: _tipe == Tipe.pengeluaran ? _kategori : '-',
    );
    setState(() => _menyimpan = true);
    try {
      if (kegiatan.id == null) {
        await DbHelper.tambah(kegiatan);
      } else {
        await DbHelper.ubah(kegiatan);
      }
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal menyimpan: $error')));
    } finally {
      if (mounted) setState(() => _menyimpan = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.kegiatan == null ? 'Tambah Kegiatan' : 'Ubah Kegiatan',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _judul,
              maxLength: 100,
              decoration: const InputDecoration(
                labelText: 'Judul kegiatan',
                border: OutlineInputBorder(),
              ),
              validator: (teks) =>
                  (teks ?? '').trim().isEmpty ? 'Judul wajib diisi' : null,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pilihTanggal,
              icon: const Icon(Icons.calendar_today),
              label: Text('Tanggal: ${formatTanggalPanjang(_tanggal)}'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<Tipe>(
              initialValue: _tipe,
              decoration: const InputDecoration(
                labelText: 'Jenis kegiatan',
                border: OutlineInputBorder(),
              ),
              items: Tipe.values
                  .map(
                    (tipe) =>
                        DropdownMenuItem(value: tipe, child: Text(tipe.name)),
                  )
                  .toList(),
              onChanged: (nilai) {
                if (nilai != null) setState(() => _tipe = nilai);
              },
            ),
            if (_tipe != Tipe.tanpa) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _nominal,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nominal (Rp)',
                  border: OutlineInputBorder(),
                ),
                validator: (teks) {
                  final angka = int.tryParse((teks ?? '').trim());
                  return angka == null || angka <= 0
                      ? 'Nominal wajib lebih dari 0'
                      : null;
                },
              ),
            ],
            if (_tipe == Tipe.pengeluaran) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _kategori,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items: _kategoriValid
                    .map(
                      (kategori) => DropdownMenuItem(
                        value: kategori,
                        child: Text(kategori),
                      ),
                    )
                    .toList(),
                onChanged: (nilai) {
                  if (nilai != null) setState(() => _kategori = nilai);
                },
              ),
            ],
            SwitchListTile(
              title: const Text('Sudah selesai'),
              value: _selesai,
              onChanged: (nilai) => setState(() => _selesai = nilai),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _menyimpan ? null : _simpan,
              icon: const Icon(Icons.save),
              label: Text(_menyimpan ? 'Menyimpan...' : 'Simpan Kegiatan'),
            ),
          ],
        ),
      ),
    );
  }
}
