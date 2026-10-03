# Dokumentasi Praktikum Flutter Fundamental - Pertemuan 2

## Identitas

| Keterangan | Data |
|---|---|
| Mata Kuliah | Pemrograman Mobile |
| Praktikum | Flutter Fundamental |
| Pertemuan | 2 |
| Nama | Dimas Anugrah Saputra |
| NIM | 20240801064 |
| Prodi | Teknik Informatika |

---

## 1. Gambaran Praktikum

Pada praktikum pertemuan kedua ini, saya melanjutkan pembelajaran Flutter dengan materi yang lebih berfokus pada penyusunan tampilan, pengolahan data dalam bentuk list, dan perpindahan halaman.

Pada tahap awal saya mempelajari penggunaan beberapa widget layout seperti `Container`, `Padding`, `Row`, `Column`, dan `Expanded`. Setelah itu materi dikembangkan dengan membuat daftar data menggunakan `ListView.builder`, kemudian dilanjutkan dengan navigasi ke halaman detail.

Seluruh materi tersebut kemudian diterapkan pada latihan dan tugas akhir berupa aplikasi **Daftar Kontak**.

---

## 2. Target Pembelajaran

Beberapa hal yang dipelajari pada praktikum ini adalah:

- Membuat layout menggunakan `Container`, `Padding`, `Row`, dan `Column`.
- Mengatur ruang menggunakan `Expanded`.
- Membuat daftar dengan `ListView.builder`.
- Menggunakan `Card` dan `ListTile`.
- Membuat class sederhana sebagai model data.
- Mengirim data dari satu halaman ke halaman lain.
- Menggunakan `Navigator.push()` untuk membuka halaman.
- Menggunakan `Navigator.pop()` untuk kembali.

---

## 3. Menyiapkan Project

Project dibuat menggunakan Flutter dengan perintah:

```bash
flutter create praktikum_2
```

File yang digunakan untuk pengerjaan utama adalah:

```text
lib/main.dart
```

Project dapat dijalankan menggunakan:

```bash
flutter run
```

Pengerjaan dilakukan secara bertahap mulai dari contoh layout, daftar menu, halaman detail, latihan, kemudian tugas daftar kontak.

---

# 4. Tahap Awal: Membuat Profil

Pada tahap pertama saya membuat halaman profil sederhana untuk memahami cara menyusun beberapa widget Flutter.

Widget yang digunakan antara lain:

- `Padding`
- `Container`
- `Row`
- `CircleAvatar`
- `Expanded`
- `Column`
- `Text`

Bagian utama menggunakan `Row` untuk menempatkan avatar dan informasi pengguna secara berdampingan.

```dart
Row(
  children: [
    const CircleAvatar(
      radius: 32,
      child: Icon(
        Icons.person,
        size: 32,
      ),
    ),
    const SizedBox(width: 16),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Dimas Anugrah Saputra',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('20240801064'),
        ],
      ),
    ),
  ],
)
```

Saya menggunakan `Column` karena nama dan NIM ingin ditampilkan secara vertikal. Sementara itu `Expanded` digunakan agar bagian informasi dapat menyesuaikan ruang yang tersedia.

---

# 5. Membuat Model Data Makanan

Setelah memahami layout, praktikum dilanjutkan dengan membuat data makanan menggunakan class.

```dart
class Makanan {
  final String nama;
  final int harga;

  const Makanan(this.nama, this.harga);
}
```

Kemudian dibuat beberapa object makanan:

```dart
const daftarMenu = [
  Makanan('Nasi Goreng', 15000),
  Makanan('Mie Ayam', 12000),
  Makanan('Es Teh', 4000),
  Makanan('Ayam Bakar', 20000),
];
```

Menurut pemahaman saya, penggunaan class membuat data menjadi lebih teratur karena setiap object memiliki struktur yang sama.

---

# 6. Menampilkan Menu

Data makanan ditampilkan menggunakan `ListView.builder`.

```dart
ListView.builder(
  itemCount: daftarMenu.length,
  itemBuilder: (context, index) {
    final item = daftarMenu[index];

    return Card(
      child: ListTile(
        leading: const Icon(Icons.restaurant),
        title: Text(item.nama),
        subtitle: Text('Rp ${item.harga}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  },
)
```

`itemCount` mengambil jumlah data dari:

```dart
daftarMenu.length
```

Sedangkan data pada posisi tertentu diambil menggunakan:

```dart
final item = daftarMenu[index];
```

Dengan cara ini satu pola tampilan dapat digunakan untuk seluruh data yang ada di dalam list.

---

# 7. Menggunakan Card dan ListTile

Setiap menu ditampilkan menggunakan `Card` dan `ListTile`.

Struktur tampilannya secara sederhana:

```text
Card
└── ListTile
    ├── leading
    ├── title
    ├── subtitle
    └── trailing
```

`leading` digunakan untuk ikon restoran, `title` untuk nama makanan, `subtitle` untuk harga, dan `trailing` untuk ikon panah.

Penggunaan struktur tersebut membuat tampilan daftar menjadi lebih rapi dan mudah dibaca.

---

# 8. Membuat Halaman Detail

Setelah daftar menu selesai, setiap item dibuat agar dapat ditekan dan membuka halaman detail.

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => DetailPage(
      makanan: item,
    ),
  ),
);
```

Object makanan dikirim ke halaman detail melalui constructor.

```dart
class DetailPage extends StatelessWidget {
  final Makanan makanan;

  const DetailPage({
    super.key,
    required this.makanan,
  });
```

Dengan demikian data yang dipilih dapat digunakan kembali pada halaman detail melalui:

```dart
makanan.nama
```

dan:

```dart
makanan.harga
```

Untuk kembali ke halaman sebelumnya digunakan:

```dart
Navigator.pop(context)
```

---

# 9. Latihan 1 — Menambahkan Menu

Pada latihan pertama saya menambahkan tiga menu baru:

```text
Bakso
Bebek Goreng
Es Teler
```

Kode tambahan:

```dart
Makanan('Bakso', 13000),
Makanan('Soto Ayam', 14000),
Makanan('Es Jeruk', 5000),
```

Dengan tambahan tersebut jumlah menu menjadi tujuh.

Karena menggunakan `ListView.builder`, menu baru langsung dapat ditampilkan tanpa perlu membuat widget secara manual satu per satu.

---

# 10. Latihan 2 — Menambahkan Deskripsi

Pada latihan kedua, model `Makanan` ditambahkan properti `deskripsi`.

```dart
class Makanan {
  final String nama;
  final int harga;
  final String deskripsi;

  const Makanan(
    this.nama,
    this.harga,
    this.deskripsi,
  );
}
```

Contoh data:

```dart
Makanan(
  'Nasi Goreng',
  15000,
  'Nasi goreng dengan bumbu racikan.',
),
```

Deskripsi kemudian ditampilkan pada halaman detail:

```dart
Text(makanan.deskripsi)
```

Dengan penambahan ini informasi yang ditampilkan pada halaman detail menjadi lebih lengkap.

---

# 11. Latihan 3 — Mengganti Card dengan Container

Pada latihan ketiga, `Card` diganti menggunakan `Container`.

```dart
Container(
  margin: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 6,
  ),
  decoration: BoxDecoration(
    color: Colors.brown.shade50,
    borderRadius: BorderRadius.circular(12),
  ),
  child: ListTile(
    leading: const Icon(Icons.restaurant),
    title: Text(item.nama),
    subtitle: Text('Rp ${item.harga}'),
    trailing: const Icon(Icons.chevron_right),
  ),
)
```

Dengan `BoxDecoration`, warna latar belakang dan sudut container dapat diatur.

Pada tahap ini warna tema juga diubah menggunakan:

```dart
colorSchemeSeed: Colors.brown,
```

---

# 12. Latihan 4 — Membuat Format Harga

Pada latihan terakhir, harga dibuat menggunakan format ribuan agar lebih mudah dibaca.

Contohnya:

```text
15000
```

diubah menjadi:

```text
15.000
```

Fungsi yang digunakan:

```dart
String formatHarga(int harga) {
  String angka = harga.toString();
  String hasil = '';

  int hitung = 0;

  for (int i = angka.length - 1; i >= 0; i--) {
    hasil = angka[i] + hasil;
    hitung++;

    if (hitung == 3 && i != 0) {
      hasil = '.$hasil';
      hitung = 0;
    }
  }

  return hasil;
}
```

Kemudian digunakan pada daftar:

```dart
subtitle: Text('Rp ${formatHarga(item.harga)}'),
```

dan halaman detail:

```dart
Text('Rp ${formatHarga(makanan.harga)}')
```

Contoh hasil:

```text
15000  -> 15.000
12000  -> 12.000
4000   -> 4.000
13000  -> 13.000
14000  -> 14.000
5000   -> 5.000
```

---

# 13. Tugas Akhir — Daftar Kontak

Setelah menyelesaikan latihan, saya membuat aplikasi **Daftar Kontak**.

Aplikasi memiliki tiga informasi utama:

- Nama
- Nomor telepon
- Email

Untuk menyimpan data dibuat class `Kontak`.

```dart
class Kontak {
  final String nama;
  final String telepon;
  final String email;

  const Kontak(
    this.nama,
    this.telepon,
    this.email,
  );
}
```

---

# 14. Data Kontak

Terdapat enam kontak yang digunakan pada aplikasi:

```dart
const daftarKontak = [
  Kontak(
    'Nolan',
    '081234567890',
    'Nolan@gmail.com',
  ),
  Kontak(
    'Lukas',
    '081234567891',
    'Lukas@gmail.com',
  ),
  Kontak(
    'Ling',
    '081234567892',
    'Ling@gmail.com',
  ),
  Kontak(
    'Atlas',
    '081234567893',
    'Atlas@gmail.com',
  ),
  Kontak(
    'Suyou',
    '081234567894',
    'Suyou@gmail.com',
  ),
  Kontak(
    'Zilong',
    '081234567895',
    'Zilong@gmail.com',
  ),
];
```

Data tersebut disimpan dalam list sehingga dapat diproses oleh `ListView.builder`.

---

# 15. Halaman Daftar Kontak

Pada halaman utama, setiap kontak ditampilkan menggunakan `ListTile`.

```dart
ListView.builder(
  itemCount: daftarKontak.length,
  itemBuilder: (context, index) {
    final kontak = daftarKontak[index];

    return ListTile(
      leading: CircleAvatar(
        child: Text(kontak.nama[0]),
      ),
      title: Text(kontak.nama),
      subtitle: Text(kontak.telepon),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailKontakPage(
              kontak: kontak,
            ),
          ),
        );
      },
    );
  },
)
```

Avatar mengambil huruf pertama dari nama menggunakan:

```dart
kontak.nama[0]
```

Sehingga setiap kontak mempunyai identitas visual sederhana berdasarkan huruf awal namanya.

---

# 16. Halaman Detail Kontak

Ketika kontak dipilih, aplikasi membuka halaman detail.

```dart
class DetailKontakPage extends StatelessWidget {
  final Kontak kontak;

  const DetailKontakPage({
    super.key,
    required this.kontak,
  });
```

Data kontak kemudian ditampilkan:

```dart
Text(
  kontak.nama,
  style: const TextStyle(
    fontSize: 24,
  ),
),
const SizedBox(height: 8),
Text(kontak.telepon),
const SizedBox(height: 8),
Text(kontak.email),
```

Tombol kembali:

```dart
ElevatedButton(
  onPressed: () => Navigator.pop(context),
  child: const Text('Kembali'),
)
```

---

# 17. Alur Program

Cara kerja aplikasi secara keseluruhan dapat digambarkan sebagai berikut:

```text
                 Aplikasi
                    |
                    v
           Daftar Kontak
                    |
             Pilih Kontak
                    |
                    v
           Detail Kontak
                    |
               Kembali
                    |
                    v
           Daftar Kontak
```

Data yang ditampilkan pada halaman detail berasal dari object `Kontak` yang dipilih pada halaman utama.

---

# 18. Hubungan Data dan Tampilan

Salah satu hal yang saya pahami dari praktikum ini adalah hubungan antara model data dan widget tampilan.

Alurnya:

```text
Class Kontak
      |
      v
Object Kontak
      |
      v
List daftarKontak
      |
      v
ListView.builder
      |
      v
ListTile
      |
      v
DetailKontakPage
```

Class digunakan sebagai bentuk data. Object kemudian disimpan di dalam list. List dibaca oleh `ListView.builder` dan ditampilkan sebagai widget.

Ketika item dipilih, object yang sama dikirim ke halaman detail.

---

# 19. Pemahaman Teknis

### Container dan Padding

`Container` digunakan untuk mengatur area dan dekorasi widget, sedangkan `Padding` digunakan untuk memberikan jarak.

### Row dan Column

`Row` menyusun widget secara horizontal dan `Column` menyusun widget secara vertikal.

### Expanded

`Expanded` membantu widget menggunakan ruang yang tersedia di dalam `Row` atau `Column`.

### ListView.builder

Digunakan untuk membuat daftar berdasarkan jumlah data yang terdapat pada list.

### Navigator

`Navigator.push()` digunakan ketika ingin berpindah ke halaman baru.

`Navigator.pop()` digunakan untuk kembali ke halaman sebelumnya.

### Constructor

Constructor digunakan untuk menerima data yang dikirim dari halaman sebelumnya.

---

# 20. Hasil yang Dicapai

Setelah semua tahapan selesai, saya berhasil membuat beberapa hasil:

**Profil**
- Menampilkan nama dan NIM.
- Menggunakan layout dasar Flutter.

**Daftar Menu**
- Menggunakan model `Makanan`.
- Menampilkan data menggunakan `ListView.builder`.
- Menggunakan `Card` dan `ListTile`.

**Detail Menu**
- Menampilkan informasi menu yang dipilih.
- Menggunakan navigasi antar halaman.

**Latihan**
- Menambahkan menu.
- Menambahkan deskripsi.
- Mengubah `Card` menjadi `Container`.
- Membuat format harga.

**Daftar Kontak**
- Memiliki enam data kontak.
- Menampilkan nama dan nomor telepon.
- Menggunakan avatar huruf pertama.
- Membuka halaman detail.
- Menampilkan nama, nomor telepon, dan email.
- Memiliki tombol kembali.

---

# 21. Kesimpulan

Praktikum Pertemuan 2 memberikan pemahaman lebih lanjut mengenai cara mengembangkan aplikasi Flutter yang tidak hanya memiliki tampilan, tetapi juga mulai menggunakan data dan navigasi.

Pada bagian awal saya belajar menyusun layout dengan beberapa widget dasar. Setelah itu saya menggunakan class untuk membuat model data dan list untuk menyimpan beberapa object.

Data yang tersimpan kemudian ditampilkan menggunakan `ListView.builder`. Setelah tampilan daftar selesai, saya menerapkan navigasi agar setiap item dapat membuka halaman detail.

Konsep tersebut kemudian digunakan kembali pada tugas Daftar Kontak. Dari tugas ini saya memahami bahwa satu object data dapat ditampilkan pada halaman utama dan dikirim ke halaman lain tanpa harus membuat ulang datanya.

Secara keseluruhan, praktikum ini membantu saya memahami dasar hubungan antara **model data, list, widget, dan navigasi** dalam aplikasi Flutter.

---

# 22. Referensi

Materi yang digunakan dalam pengerjaan berasal dari:

**Modul Praktikum Flutter Fundamental — Pertemuan 2**  
**Topik: Layout, ListView, dan Navigasi Antar Halaman**

Konsep yang dipraktikkan meliputi:

- Container
- Padding
- Row
- Column
- Expanded
- ListView.builder
- Card
- ListTile
- Class dan object Dart
- Navigator
- Passing data antar halaman

---

> Dokumentasi ini dibuat sebagai catatan proses pengerjaan praktikum, mulai dari persiapan project, memahami materi, mengerjakan contoh, menyelesaikan latihan, sampai membuat aplikasi Daftar Kontak.
