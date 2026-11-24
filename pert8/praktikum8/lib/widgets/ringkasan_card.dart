import 'package:flutter/material.dart';

import '../models/kegiatan.dart';
import '../utils/format.dart';

class RingkasanCard extends StatelessWidget {
  const RingkasanCard({
    super.key,
    required this.ringkasan,
    required this.target,
  });

  final Ringkasan ringkasan;
  final int target;

  @override
  Widget build(BuildContext context) {
    final progress = target <= 0
        ? 0.0
        : (ringkasan.tabungan / target).clamp(0.0, 1.0).toDouble();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ringkasan hari ini',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Kegiatan selesai ${ringkasan.selesai}/${ringkasan.jumlahKegiatan}',
            ),
            const SizedBox(height: 8),
            Text('Pemasukan: ${formatRupiah(ringkasan.pemasukan)}'),
            Text('Pengeluaran: ${formatRupiah(ringkasan.pengeluaran)}'),
            const SizedBox(height: 8),
            Text(
              'Tabungan: ${formatRupiah(ringkasan.tabungan)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 6),
            Text('Target harian: ${formatRupiah(target)}'),
            if (ringkasan.tabungan < 0)
              const Text(
                'Tabungan negatif: periksa pengeluaran.',
                style: TextStyle(color: Colors.red),
              ),
            if (target > 0 && ringkasan.tabungan >= target)
              const Text('Target tabungan tercapai!'),
          ],
        ),
      ),
    );
  }
}
