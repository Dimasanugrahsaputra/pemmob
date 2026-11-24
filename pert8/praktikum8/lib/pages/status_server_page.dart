import 'package:flutter/material.dart';

import '../config/api_config.dart';
import '../services/health_service.dart';

class StatusServerPage extends StatefulWidget {
  const StatusServerPage({super.key});

  @override
  State<StatusServerPage> createState() => _StatusServerPageState();
}

class _StatusServerPageState extends State<StatusServerPage> {
  late Future<StatusServer> _future;

  @override
  void initState() {
    super.initState();
    _future = cekServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Server')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Alamat API: ${apiUrl.value}'),
          const SizedBox(height: 16),
          FutureBuilder<StatusServer>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Server tidak dapat dihubungi: ${snapshot.error}');
              }
              final data = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Server terhubung',
                    style: TextStyle(color: Colors.green),
                  ),
                  Text('Status: ${data.status}'),
                  Text('Waktu server: ${data.waktuServer}'),
                  Text('Latensi: ${data.latensi.inMilliseconds} ms'),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => setState(() => _future = cekServer()),
            icon: const Icon(Icons.refresh),
            label: const Text('Periksa lagi'),
          ),
        ],
      ),
    );
  }
}
