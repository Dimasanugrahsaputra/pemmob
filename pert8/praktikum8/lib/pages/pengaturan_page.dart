import 'package:flutter/material.dart';

import '../config/api_config.dart';
import '../state/pengaturan.dart';
import '../utils/format.dart';
import 'status_server_page.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key, required this.pengaturan});
  final Pengaturan pengaturan;

  Future<void> _ubahAlamat(BuildContext context) async {
    final controller = TextEditingController(text: apiUrl.value);
    final formKey = GlobalKey<FormState>();
    final hasil = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Alamat API'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(labelText: 'Base URL'),
            validator: (nilai) => validasiApiUrl(nilai ?? ''),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(dialogContext, controller.text.trim());
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    if (hasil == null || !context.mounted) {
      controller.dispose();
      return;
    }
    try {
      await simpanAlamatApi(hasil);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Alamat API disimpan')));
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Alamat tidak valid: $error')));
      }
    } finally {
      // Controller hanya digunakan di dalam dialog.
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pengaturan,
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: const Text('Pengaturan')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile.adaptive(
              title: const Text('Mode Gelap'),
              value: pengaturan.modeGelap,
              onChanged: pengaturan.aturModeGelap,
            ),
            const Divider(),
            Text('Warna tema', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8,
              children: Pengaturan.pilihanWarna.map((warna) {
                return ChoiceChip(
                  label: Text(warna),
                  selected: pengaturan.warna == warna,
                  onSelected: (aktif) {
                    if (aktif) pengaturan.aturWarna(warna);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text('Target menabung: ${formatRupiah(pengaturan.target)}'),
            Slider(
              min: 5000,
              max: 100000,
              divisions: 19,
              value: pengaturan.target.clamp(5000, 100000).toDouble(),
              onChanged: (nilai) => pengaturan.aturTarget(nilai.round()),
            ),
            const Divider(),
            ValueListenableBuilder<String>(
              valueListenable: apiUrl,
              builder: (context, url, _) => ListTile(
                leading: const Icon(Icons.link),
                title: const Text('Alamat API'),
                subtitle: Text(url),
                trailing: const Icon(Icons.edit),
                onTap: () => _ubahAlamat(context),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dns),
              title: const Text('Status Server'),
              subtitle: const Text('Memeriksa endpoint /health'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const StatusServerPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
