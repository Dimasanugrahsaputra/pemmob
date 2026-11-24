enum Tipe { tanpa, pemasukan, pengeluaran }

class Kegiatan {
  const Kegiatan({
    this.id,
    required this.judul,
    required this.tanggal,
    this.selesai = false,
    this.tipe = Tipe.tanpa,
    this.nominal = 0,
    this.kategori = '-',
  });

  final int? id;
  final String judul;
  final String tanggal;
  final bool selesai;
  final Tipe tipe;
  final int nominal;
  final String kategori;

  Kegiatan copyWith({
    int? id,
    String? judul,
    String? tanggal,
    bool? selesai,
    Tipe? tipe,
    int? nominal,
    String? kategori,
  }) {
    return Kegiatan(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      tanggal: tanggal ?? this.tanggal,
      selesai: selesai ?? this.selesai,
      tipe: tipe ?? this.tipe,
      nominal: nominal ?? this.nominal,
      kategori: kategori ?? this.kategori,
    );
  }

  // Representasi SQLite: boolean menjadi INTEGER 0/1.
  Map<String, Object?> toMap() => {
    if (id != null) 'id': id,
    'judul': judul,
    'tanggal': tanggal,
    'selesai': selesai ? 1 : 0,
    'tipe': tipe.name,
    'nominal': nominal,
    'kategori': kategori,
  };

  factory Kegiatan.fromMap(Map<String, Object?> map) {
    return Kegiatan(
      id: map['id'] as int?,
      judul: map['judul'] as String,
      tanggal: map['tanggal'] as String,
      selesai: (map['selesai'] as int) == 1,
      tipe: Tipe.values.byName(map['tipe'] as String),
      nominal: map['nominal'] as int,
      kategori: map['kategori'] as String,
    );
  }

  // Representasi API: boolean asli dan id tidak ikut dalam POST/PUT.
  Map<String, Object?> toJson() => {
    'judul': judul,
    'tanggal': tanggal,
    'selesai': selesai,
    'tipe': tipe.name,
    'nominal': nominal,
    'kategori': kategori,
  };

  factory Kegiatan.fromJson(Map<String, dynamic> json) {
    return Kegiatan(
      id: json['id'] as int,
      judul: json['judul'] as String,
      tanggal: json['tanggal'] as String,
      selesai: json['selesai'] as bool,
      tipe: Tipe.values.byName(json['tipe'] as String),
      nominal: json['nominal'] as int,
      kategori: json['kategori'] as String,
    );
  }
}

class Ringkasan {
  const Ringkasan({
    required this.jumlahKegiatan,
    required this.selesai,
    required this.pemasukan,
    required this.pengeluaran,
  });

  final int jumlahKegiatan;
  final int selesai;
  final int pemasukan;
  final int pengeluaran;
  int get tabungan => pemasukan - pengeluaran;

  factory Ringkasan.fromMap(Map<String, Object?> map) => Ringkasan(
    jumlahKegiatan: (map['jumlah_kegiatan'] as num?)?.toInt() ?? 0,
    selesai: (map['selesai'] as num?)?.toInt() ?? 0,
    pemasukan: (map['pemasukan'] as num?)?.toInt() ?? 0,
    pengeluaran: (map['pengeluaran'] as num?)?.toInt() ?? 0,
  );

  // Digunakan kembali oleh Tugas 9 untuk respons laporan server.
  factory Ringkasan.fromJson(Map<String, dynamic> json) => Ringkasan(
    jumlahKegiatan: json['jumlah_kegiatan'] as int,
    selesai: json['selesai'] as int,
    pemasukan: json['pemasukan'] as int,
    pengeluaran: json['pengeluaran'] as int,
  );
}
