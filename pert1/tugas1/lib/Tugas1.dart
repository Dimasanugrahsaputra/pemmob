import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 1',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Kartu Perkenalan',
            style: TextStyle(fontSize: 22),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.person, size: 80),
              SizedBox(height: 16),
              Text('Nama: Dimas Anugrah Saputra',
                  style: TextStyle(fontSize: 20)),
              Text('NIM: 20240801064',
                  style: TextStyle(fontSize: 18)),
              Text('Jurusan: Teknik Informatika',
                  style: TextStyle(fontSize: 18)),
              Text('Hobi: Futsal',
                  style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}