import 'package:flutter/material.dart';

import '../state/pengaturan.dart';
import 'beranda_page.dart';
import 'laporan_page.dart';
import 'pengaturan_page.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key, required this.pengaturan});
  final Pengaturan pengaturan;

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: [
          BerandaPage(pengaturan: widget.pengaturan),
          const LaporanPage(),
          PengaturanPage(pengaturan: widget.pengaturan),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (nilai) => setState(() => _tab = nilai),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.today), label: 'Hari Ini'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Laporan'),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
