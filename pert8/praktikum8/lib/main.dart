import 'package:flutter/material.dart';

import 'config/api_config.dart';
import 'pages/shell_page.dart';
import 'state/pengaturan.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pengaturan = Pengaturan();
  await Future.wait<void>([pengaturan.muat(), muatAlamatApi()]);
  runApp(TabungKuApp(pengaturan: pengaturan));
}

class TabungKuApp extends StatelessWidget {
  const TabungKuApp({super.key, required this.pengaturan});
  final Pengaturan pengaturan;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pengaturan,
      builder: (context, _) => MaterialApp(
        title: 'TabungKu — Praktikum 8',
        debugShowCheckedModeBanner: false,
        themeMode: pengaturan.modeGelap ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: pengaturan.warnaUtama),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: pengaturan.warnaUtama,
            brightness: Brightness.dark,
          ),
        ),
        home: ShellPage(pengaturan: pengaturan),
      ),
    );
  }
}
