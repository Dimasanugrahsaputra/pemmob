import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class StatusServer {
  const StatusServer({
    required this.status,
    required this.waktuServer,
    required this.latensi,
  });

  final String status;
  final String waktuServer;
  final Duration latensi;
}

Future<StatusServer> cekServer({http.Client? client}) async {
  final koneksi = client ?? http.Client();
  final stopwatch = Stopwatch()..start();

  try {
    final response = await koneksi
        .get(Uri.parse('${apiUrl.value}/health'))
        .timeout(batasWaktu);

    if (response.statusCode != 200) {
      throw Exception('Server membalas kode ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return StatusServer(
      status: json['status'] as String,
      waktuServer: json['waktu_server'] as String,
      latensi: stopwatch.elapsed,
    );
  } finally {
    stopwatch.stop();
    if (client == null) koneksi.close();
  }
}
