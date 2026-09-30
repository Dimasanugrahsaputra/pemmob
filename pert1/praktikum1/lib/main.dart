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
      debugShowCheckedModeBanner: false, // menghilangkan banner debug
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 0) _count--;
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Counter Saya',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nilai Counter:',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              '$_count',
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove),
                  label: const Text('Kurang'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        backgroundColor: Colors.deepPurple,
        tooltip: 'Tambah',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}