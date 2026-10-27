import 'package:flutter/material.dart';

import '../state/pengaturan.dart';
import '../utils/format.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({
    super.key,
    required this.pengaturan,
  });

  final Pengaturan pengaturan;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pengaturan,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Pengaturan'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Preferensi aplikasi',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    title: const Text('Mode gelap'),
                    subtitle: const Text(
                      'Gunakan tampilan '
                          'dengan latar gelap',
                    ),
                    secondary: const Icon(
                      Icons.dark_mode_outlined,
                    ),
                    value: pengaturan.modeGelap,
                    onChanged: (nilai) =>
                        pengaturan.aturModeGelap(nilai),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      18,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Warna tema',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                          Pengaturan.pilihanWarna.map(
                                (warna) {
                              return ChoiceChip(
                                label: Text(warna),
                                selected:
                                pengaturan.warna ==
                                    warna,
                                onSelected: (_) =>
                                    pengaturan.aturWarna(
                                      warna,
                                    ),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Target menabung',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  20,
                  16,
                  12,
                ),
                child: Column(
                  children: [
                    Text(
                      formatRupiah(
                        pengaturan.target,
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Target tabungan per hari',
                    ),
                    Slider(
                      min: 5000,
                      max: 100000,
                      divisions: 19,
                      label: formatRupiah(
                        pengaturan.target,
                      ),
                      value: pengaturan.target
                          .clamp(5000, 100000)
                          .toDouble(),
                      onChanged: (nilai) =>
                          pengaturan.aturTarget(
                            nilai.round(),
                          ),
                    ),
                    const Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Rp 5.000'),
                        Text('Rp 100.000'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Target, tema, dan mode gelap '
                          'tersimpan meskipun aplikasi ditutup.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
