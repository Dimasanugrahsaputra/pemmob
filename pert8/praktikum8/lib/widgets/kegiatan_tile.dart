import 'package:flutter/material.dart';

import '../models/kegiatan.dart';
import '../utils/format.dart';

class KegiatanTile extends StatelessWidget {
  const KegiatanTile({
    super.key,
    required this.kegiatan,
    required this.onSelesai,
    required this.onUbah,
    required this.onHapus,
  });

  final Kegiatan kegiatan;
  final ValueChanged<bool> onSelesai;
  final VoidCallback onUbah;
  final VoidCallback onHapus;

  @override
  Widget build(BuildContext context) {
    final nominal = kegiatan.tipe == Tipe.tanpa
        ? 'Tanpa uang'
        : '${kegiatan.tipe.name} · ${formatRupiah(kegiatan.nominal)}';

    return Card(
      child: ListTile(
        leading: Checkbox(
          value: kegiatan.selesai,
          onChanged: (nilai) => onSelesai(nilai ?? false),
        ),
        title: Text(
          kegiatan.judul,
          style: TextStyle(
            decoration: kegiatan.selesai ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text('$nominal · ${kegiatan.kategori}'),
        trailing: PopupMenuButton<String>(
          onSelected: (aksi) {
            if (aksi == 'edit') onUbah();
            if (aksi == 'hapus') onHapus();
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'edit', child: Text('Ubah')),
            PopupMenuItem(value: 'hapus', child: Text('Hapus')),
          ],
        ),
      ),
    );
  }
}
