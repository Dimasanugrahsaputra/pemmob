import 'package:flutter/material.dart';

// Perpustakaan — porting UI/UX Stitch menjadi Flutter.
// Semua data, login, status peminjaman, dan aksi di sini adalah SIMULASI LOKAL.
// Integrasi Laravel REST API belum disediakan oleh arsip Stitch.

void main() => runApp(const PerpustakaanApp());

class AppColors {
  static const navy = Color(0xFF17324D);
  static const deepNavy = Color(0xFF001D36);
  static const teal = Color(0xFF00796F);
  static const background = Color(0xFFF7F9FC);
  static const paleBlue = Color(0xFFE7EFFF);
  static const text = Color(0xFF162438);
  static const muted = Color(0xFF64748B);
  static const gold = Color(0xFFF2B84B);
  static const red = Color(0xFFDC2626);
}

class LibraryBook {
  const LibraryBook({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.rack,
    required this.stock,
    required this.code,
    required this.isbn,
    required this.image,
    required this.publisher,
    this.description = '',
  });
  final int id;
  final String title, author, category, rack, code, isbn, image, publisher;
  final int stock;
  final String description;
}

const libraryBooks = <LibraryBook>[
  LibraryBook(id: 0, title: 'Clean Architecture & Flutter', author: 'Robert C. & Tim', category: 'Informatika', rack: 'IF-03', stock: 4, code: 'BK-IF-2024-001', isbn: '978-602-01-2831', image: 'assets/books/clean_architecture.jpg', publisher: 'Informatika Bandung', description: 'Mengenal konsep clean architecture dalam pengembangan aplikasi Flutter yang modular, terstruktur, dan mudah dirawat.'),
  LibraryBook(id: 1, title: 'Analisis Laporan Keuangan Perbankan', author: 'Dr. Sri Mulyani', category: 'Ekonomi', rack: 'EK-01', stock: 1, code: 'BK-EK-2024-012', isbn: '978-602-05-9921', image: 'assets/books/banking_analysis.jpg', publisher: 'Pustaka Ekonomi', description: 'Pengantar membaca dan menganalisis laporan keuangan pada sektor perbankan.'),
  LibraryBook(id: 2, title: 'Kecerdasan Buatan & ML', author: 'Budi Raharjo, M.T.', category: 'Informatika', rack: 'IF-05', stock: 0, code: 'BK-IF-2024-017', isbn: '978-602-08-4102', image: 'assets/books/artificial_intelligence.jpg', publisher: 'Teknologi Nusantara', description: 'Dasar kecerdasan buatan, machine learning, dan jaringan neural.'),
  LibraryBook(id: 3, title: 'Hukum Tata Negara Indonesia Modern', author: 'Prof. Jimly A.', category: 'Hukum', rack: 'HK-02', stock: 3, code: 'BK-HK-2024-013', isbn: '978-602-02-1133', image: 'assets/books/hukum_indonesia.jpg', publisher: 'Hukum Indonesia', description: 'Kajian konstitusi dan tata negara Indonesia kontemporer.'),
  LibraryBook(id: 4, title: 'Statistika Terapan untuk Penelitian', author: 'Dr. Sugiyono', category: 'Sains', rack: 'SN-04', stock: 6, code: 'BK-SN-2024-025', isbn: '978-602-04-7744', image: 'assets/books/statistik_penelitian.jpg', publisher: 'Penerbit Akademik', description: 'Metode statistik terapan dan pendekatan penelitian ilmiah.'),
  LibraryBook(id: 5, title: 'Algoritma dan Struktur Data', author: 'R. Nugroho', category: 'Informatika', rack: 'A-02', stock: 5, code: 'BK-IF-2024-008', isbn: '978-602-07-1010', image: 'assets/books/algoritma.jpg', publisher: 'Pustaka Akademik', description: 'Konsep dasar algoritma, struktur data, dan implementasi pemrograman.'),
  LibraryBook(id: 6, title: 'Manajemen Basis Data Relasional', author: 'Dr. Haryanto', category: 'Informatika', rack: 'A-04', stock: 1, code: 'BK-IF-2024-021', isbn: '978-602-07-1021', image: 'assets/books/database.jpg', publisher: 'Pustaka Akademik', description: 'Perancangan dan pengelolaan basis data relasional.'),
  LibraryBook(id: 7, title: 'Dasar-Dasar Rekayasa Perangkat Lunak', author: 'I. Prasetyo', category: 'Informatika', rack: 'B-01', stock: 3, code: 'BK-IF-2024-030', isbn: '978-602-07-1030', image: 'assets/books/software_engineering.jpg', publisher: 'Pustaka Akademik', description: 'Pengantar rekayasa perangkat lunak dan siklus hidup pengembangan sistem.'),
];

class LoanRecord {
  const LoanRecord({required this.code, required this.items, required this.pickupDate, required this.notes, required this.status, required this.createdAt});
  final String code, notes, status;
  final DateTime pickupDate, createdAt;
  final Map<int, int> items;
}

String dateId(DateTime date) {
  const names = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
  return '${date.day} ${names[date.month - 1]} ${date.year}';
}

LibraryBook findBook(int id) => libraryBooks.firstWhere((item) => item.id == id);

class PerpustakaanApp extends StatelessWidget {
  const PerpustakaanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.navy, surface: AppColors.background),
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.background, foregroundColor: AppColors.text, elevation: 0),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFEAF1FF),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: BorderSide.none),
        ),
      ),
      home: const LibraryShell(),
    );
  }
}

class LibraryShell extends StatefulWidget {
  const LibraryShell({super.key});
  @override
  State<LibraryShell> createState() => _LibraryShellState();
}

class _LibraryShellState extends State<LibraryShell> {
  int selectedTab = 0;
  bool loggedIn = false;
  // Dua buku dipilih secara default agar form sesuai contoh Stitch dan dapat didemokan.
  final Map<int, int> cart = {0: 1, 1: 1};
  final List<LoanRecord> loans = [];

  Future<void> openLogin() async {
    await Navigator.push<void>(context, MaterialPageRoute(builder: (_) => DemoLoginPage(
      onLoggedIn: () => setState(() => loggedIn = true),
    )));
  }

  void showDetail(LibraryBook book) {
    Navigator.push<void>(context, MaterialPageRoute(builder: (_) => BookDetailPage(
      book: book,
      onAdd: () {
        if (book.stock > 0) {
          setState(() => cart[book.id] = (cart[book.id] ?? 0) + 1 > book.stock ? book.stock : (cart[book.id] ?? 0) + 1);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${book.title} ditambahkan ke pilihan.')));
        }
      },
      onForm: openForm,
    )));
  }

  Future<void> openForm() async {
    if (!loggedIn) {
      await openLogin();
      if (!mounted || !loggedIn) return;
    }
    if (cart.isEmpty) {
      setState(() => selectedTab = 1);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih buku dari katalog terlebih dahulu.')));
      return;
    }
    await Navigator.push<void>(context, MaterialPageRoute(builder: (_) => BorrowFormPage(
      selectedItems: Map<int, int>.from(cart),
      onConfirm: (items, pickup, notes) {
        setState(() {
          loans.insert(0, LoanRecord(
            code: 'PJB-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
            items: Map<int, int>.from(items),
            pickupDate: pickup,
            notes: notes,
            status: 'Diajukan',
            createdAt: DateTime.now(),
          ));
          cart.clear();
          selectedTab = 2;
        });
      },
    )));
  }

  Future<void> onTab(int value) async {
    if ((value == 2 || value == 3) && !loggedIn) {
      await openLogin();
      if (!mounted || !loggedIn) return;
    }
    setState(() => selectedTab = value);
  }

  Widget buildBody() {
    if (selectedTab == 0) {
      return loggedIn
          ? MemberHome(onCatalog: () => setState(() => selectedTab = 1), onForm: openForm, onHistory: () => setState(() => selectedTab = 2), onDetail: showDetail)
          : GuestHome(onLogin: openLogin, onCatalog: () => setState(() => selectedTab = 1), onDetail: showDetail);
    }
    if (selectedTab == 1) return CatalogScreen(onDetail: showDetail, onAdd: (book) {
      if (book.stock > 0) setState(() => cart[book.id] = ((cart[book.id] ?? 0) + 1).clamp(0, book.stock).toInt());
    }, selected: cart, onForm: openForm);
    if (selectedTab == 2) return HistoryScreen(loans: loans, onBrowse: () => setState(() => selectedTab = 1));
    return ProfileScreen(
      onLogout: () => setState(() { loggedIn = false; selectedTab = 0; }),
      onHistory: () => setState(() => selectedTab = 2),
      onAdmin: () => Navigator.push<void>(context, MaterialPageRoute(builder: (_) => const AdminPrototypePage())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 17,
        title: Row(children: [
          Container(width: 29, height: 29, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(7)), child: const Icon(Icons.auto_stories, color: AppColors.teal, size: 20)),
          const SizedBox(width: 9),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('PERPUSTAKAAN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1, color: AppColors.teal)),
            Text(['Beranda', 'Katalog', 'Peminjaman', 'Profil'][selectedTab], style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: AppColors.text, height: 1.05)),
          ]),
        ]),
        actions: [
          InkWell(onTap: () => loggedIn ? setState(() => selectedTab = 3) : openLogin(), child: const Padding(padding: EdgeInsets.only(right: 17), child: CircleAvatar(radius: 18, backgroundColor: Color(0xFFDCE9F7), child: Icon(Icons.person, color: AppColors.navy)))),
        ],
      ),
      body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 520), child: buildBody())),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF7F9FF),
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedTab,
        selectedItemColor: AppColors.teal,
        unselectedItemColor: AppColors.text,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: onTab,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Beranda'),
          const BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), activeIcon: Icon(Icons.menu_book), label: 'Katalog'),
          BottomNavigationBarItem(icon: Badge(isLabelVisible: cart.isNotEmpty, label: Text('${cart.length}'), child: const Icon(Icons.assignment_outlined)), activeIcon: const Icon(Icons.assignment), label: 'Peminjaman'),
          const BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), activeIcon: Icon(Icons.account_circle), label: 'Profil'),
        ],
      ),
    );
  }
}

Widget panel({required Widget child, EdgeInsets padding = const EdgeInsets.all(16), Color color = Colors.white}) => Container(
  padding: padding,
  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(17), boxShadow: const [BoxShadow(color: Color(0x06091F34), blurRadius: 10, offset: Offset(0, 2))]),
  child: child,
);

Widget primaryButton(String label, VoidCallback onPressed, {IconData? icon, bool teal = false}) => SizedBox(
  height: 46,
  child: FilledButton(
    style: FilledButton.styleFrom(backgroundColor: teal ? AppColors.teal : AppColors.deepNavy, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    onPressed: onPressed,
    child: Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [Text(label, style: const TextStyle(fontWeight: FontWeight.w700)), if (icon != null) ...[const SizedBox(width: 8), Icon(icon, size: 18)]]),
  ),
);

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.label, required this.color, this.icon});
  final String label;
  final Color color;
  final IconData? icon;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(color: color.withOpacity(.12), borderRadius: BorderRadius.circular(30)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [if (icon != null) ...[Icon(icon, size: 13, color: color), const SizedBox(width: 4)], Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700))]),
  );
}

class GuestHome extends StatelessWidget {
  const GuestHome({super.key, required this.onLogin, required this.onCatalog, required this.onDetail});
  final VoidCallback onLogin, onCatalog;
  final void Function(LibraryBook) onDetail;
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(17), children: [
    Row(children: [const Expanded(child: StatusPill(label: 'MODE TAMU / PENGUNJUNG', color: AppColors.teal, icon: Icons.badge_outlined)), const SizedBox(width: 8), const Text('● Buka 08:00–17:00', style: TextStyle(fontSize: 10, color: AppColors.muted))]),
    const SizedBox(height: 13),
    const Text('Selamat Datang di\nPerpustakaan', style: TextStyle(fontSize: 27, height: 1.18, fontWeight: FontWeight.w800, color: AppColors.deepNavy)),
    const SizedBox(height: 5),
    const Text('Sistem Peminjaman Buku Akademik', style: TextStyle(color: AppColors.muted)),
    const SizedBox(height: 18),
    InkWell(onTap: onCatalog, child: panel(child: const Row(children: [Icon(Icons.search, color: AppColors.teal), SizedBox(width: 11), Text('Cari buku yang kamu butuhkan...', style: TextStyle(color: AppColors.muted, fontSize: 13)), Spacer(), Icon(Icons.tune, size: 20)]))),
    const SizedBox(height: 15),
    panel(color: AppColors.navy, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [Icon(Icons.lock_outline, color: Colors.white, size: 26), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Akses Tamu Terbatas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)), SizedBox(height: 4), Text('Masuk sebagai Anggota untuk mengajukan peminjaman buku fisik perpustakaan.', style: TextStyle(color: Colors.white, fontSize: 12))]))]),
      const SizedBox(height: 16),
      Row(children: [Expanded(child: primaryButton('Masuk Akun', onLogin, teal: true)), const SizedBox(width: 9), Expanded(child: OutlinedButton(style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white38)), onPressed: onLogin, child: const Text('Daftar')))]),
    ])),
    const SizedBox(height: 22),
    const SectionHeading('Kategori Akademik'),
    const SizedBox(height: 9),
    const Wrap(spacing: 8, runSpacing: 7, children: [StatusPill(label: 'Semua', color: AppColors.navy), StatusPill(label: 'Informatika', color: AppColors.teal), StatusPill(label: 'Sains & Teknologi', color: AppColors.teal), StatusPill(label: 'Ekonomi', color: AppColors.teal)]),
    const SizedBox(height: 22),
    SectionHeading('Koleksi Buku Populer', trailing: TextButton(onPressed: onCatalog, child: const Text('Lihat Semua'))),
    const SizedBox(height: 6),
    for (final book in libraryBooks.skip(5).take(3)) ...[BookRow(book: book, onTap: () => onDetail(book)), const SizedBox(height: 9)],
    const SizedBox(height: 10),
    panel(color: const Color(0xFFDCE8FF), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('◇ RUJUKAN RISET & SKRIPSI', style: TextStyle(color: AppColors.teal, fontWeight: FontWeight.w700, fontSize: 12)),
      const SizedBox(height: 9),
      const Text('Butuh Referensi Skripsi atau Tugas Akhir?', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: AppColors.deepNavy)),
      const SizedBox(height: 7),
      const Text('Akses koleksi akademik melalui katalog perpustakaan.', style: TextStyle(fontSize: 12)),
      const SizedBox(height: 11),
      Align(alignment: Alignment.centerLeft, child: primaryButton('Jelajahi Katalog', onCatalog, icon: Icons.arrow_forward)),
    ])),
    const SizedBox(height: 22),
    const Center(child: Text('Perpustakaan • Prototipe Mobile', style: TextStyle(color: AppColors.muted, fontSize: 11))),
  ]);
}

class SectionHeading extends StatelessWidget {
  const SectionHeading(this.title, {super.key, this.trailing});
  final String title;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Row(children: [Expanded(child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.text))), if (trailing != null) trailing!]);
}

class BookRow extends StatelessWidget {
  const BookRow({super.key, required this.book, required this.onTap});
  final LibraryBook book;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16), child: panel(child: Row(children: [
    ClipRRect(borderRadius: BorderRadius.circular(9), child: Image.asset(book.image, height: 105, width: 75, fit: BoxFit.cover)),
    const SizedBox(width: 12),
    Expanded(child: SizedBox(height: 105, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      StatusPill(label: book.category, color: AppColors.teal),
      const SizedBox(height: 5),
      Text(book.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
      Text(book.author, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
      const Spacer(),
      Row(children: [Text('Stok: ${book.stock} eks', style: const TextStyle(fontSize: 11, color: AppColors.muted)), const Spacer(), const Icon(Icons.visibility_outlined, size: 17, color: AppColors.teal)]),
    ]))),
  ])));
}

class MemberHome extends StatelessWidget {
  const MemberHome({super.key, required this.onCatalog, required this.onForm, required this.onHistory, required this.onDetail});
  final VoidCallback onCatalog, onForm, onHistory;
  final void Function(LibraryBook) onDetail;
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(17), children: [
    panel(child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Selamat Datang Kembali', style: TextStyle(fontSize: 12, color: AppColors.muted)),
      const SizedBox(height: 4),
      const Text('Halo, Farhan Ramadhan', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.deepNavy)),
      const SizedBox(height: 8),
      const Text('AGT-2024-0089 • Fakultas Ilmu Komputer', style: TextStyle(fontSize: 11, color: AppColors.muted)),
    ])), const SizedBox(width: 8), const StatusPill(label: 'Anggota Aktif', color: AppColors.teal, icon: Icons.circle)])),
    const SizedBox(height: 13),
    InkWell(onTap: onCatalog, child: panel(child: const Row(children: [Icon(Icons.search, color: AppColors.teal), SizedBox(width: 12), Expanded(child: Text('Cari koleksi buku, pengarang, ISBN...', style: TextStyle(color: AppColors.muted, fontSize: 12)))]))),
    const SizedBox(height: 13),
    Row(children: [Expanded(child: _ActionTile(label: 'Ajukan Pinjam', subtitle: 'Katalog sirkulasi', icon: Icons.add_box_outlined, onTap: onForm, prominent: true)), const SizedBox(width: 10), Expanded(child: _ActionTile(label: 'Katalog Buku', subtitle: 'Eksplorasi koleksi', icon: Icons.menu_book_outlined, onTap: onCatalog))]),
    const SizedBox(height: 9),
    Row(children: [Expanded(child: _ActionTile(label: 'Peminjaman Saya', subtitle: '2 buku aktif', icon: Icons.assignment_outlined, onTap: onHistory)), const SizedBox(width: 10), Expanded(child: _ActionTile(label: 'Riwayat Selesai', subtitle: 'Lihat transaksi', icon: Icons.history, onTap: onHistory))]),
    const SizedBox(height: 12),
    panel(color: const Color(0xFFFFECD4), child: const Row(children: [Icon(Icons.notifications_active_outlined, color: Color(0xFFB97800)), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Perhatian Jatuh Tempo', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFFB97800))), SizedBox(height: 4), Text('Buku yang sedang dipinjam perlu dikembalikan sesuai tanggal jatuh tempo.', style: TextStyle(fontSize: 11))]))])),
    const SizedBox(height: 18),
    const SectionHeading('Ringkasan Sirkulasi'),
    const SizedBox(height: 10),
    Row(children: [Expanded(child: _StatTile('Diajukan', '1', Icons.pending_actions_outlined, const Color(0xFFD97706))), const SizedBox(width: 9), Expanded(child: _StatTile('Dipinjam', '2', Icons.book_outlined, AppColors.navy))]),
    const SizedBox(height: 9),
    Row(children: [Expanded(child: _StatTile('Ditolak', '0', Icons.cancel_outlined, AppColors.red)), const SizedBox(width: 9), Expanded(child: _StatTile('Dikembalikan', '12', Icons.check_circle_outline, AppColors.teal))]),
    const SizedBox(height: 17),
    const SectionHeading('Sedang Dipinjam'),
    const SizedBox(height: 7),
    BookRow(book: libraryBooks[0], onTap: () => onDetail(libraryBooks[0])),
    const SizedBox(height: 16),
    const SectionHeading('Koleksi Populer'),
    const SizedBox(height: 7),
    BookRow(book: libraryBooks[3], onTap: () => onDetail(libraryBooks[3])),
    const SizedBox(height: 16),
    primaryButton('Lihat Semua Peminjaman', onHistory, icon: Icons.arrow_forward),
    const SizedBox(height: 12),
    const Text('Data ringkasan adalah contoh UI, bukan data server.', style: TextStyle(fontSize: 10, color: AppColors.muted), textAlign: TextAlign.center),
  ]);
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.label, required this.subtitle, required this.icon, required this.onTap, this.prominent = false});
  final String label, subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool prominent;
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(14), child: Container(height: 80, padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: prominent ? AppColors.navy : Colors.white, borderRadius: BorderRadius.circular(14)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Icon(icon, size: 23, color: prominent ? Colors.white : AppColors.teal), Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: prominent ? Colors.white : AppColors.text)), Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, color: prominent ? Colors.white70 : AppColors.muted))])));
}

class _StatTile extends StatelessWidget {
  const _StatTile(this.label, this.count, this.icon, this.color);
  final String label, count;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) => panel(child: Row(children: [Icon(icon, color: color), const SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(count, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: color)), Text(label, style: const TextStyle(fontSize: 11, color: AppColors.muted))]))]));
}

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, required this.onDetail, required this.onAdd, required this.selected, required this.onForm});
  final void Function(LibraryBook) onDetail, onAdd;
  final Map<int, int> selected;
  final VoidCallback onForm;
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String category = 'Semua';
  String search = '';
  @override
  Widget build(BuildContext context) {
    final books = libraryBooks.where((b) {
      final matchesCategory = category == 'Semua' || b.category == category;
      final query = '${b.title} ${b.author} ${b.isbn} ${b.code} ${b.category}'.toLowerCase();
      return matchesCategory && query.contains(search.toLowerCase());
    }).toList();

    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
        child: TextField(
          onChanged: (s) => setState(() => search = s),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Cari berdasarkan judul, penulis, ISBN...',
            hintStyle: TextStyle(fontSize: 12),
            suffixIcon: Icon(Icons.tune),
          ),
        ),
      ),
      SizedBox(
        height: 41,
        child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 14), children: [
          for (final c in ['Semua', 'Informatika', 'Ekonomi', 'Hukum', 'Sains'])
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(c, style: const TextStyle(fontSize: 12)),
                selected: category == c,
                selectedColor: AppColors.navy,
                labelStyle: TextStyle(color: category == c ? Colors.white : AppColors.text),
                onSelected: (_) => setState(() => category = c),
              ),
            ),
        ]),
      ),
      const SizedBox(height: 8),
      Expanded(
        child: Stack(children: [
          CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 11),
                child: panel(
                  color: const Color(0xFFE7EEFF),
                  child: const Row(children: [
                    Icon(Icons.auto_stories, color: AppColors.teal),
                    SizedBox(width: 10),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Koleksi Akademik Terbuka', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                      Text('Buku referensi perpustakaan', style: TextStyle(fontSize: 11, color: AppColors.muted)),
                    ])),
                  ]),
                ),
              ),
            ),
            if (books.isEmpty)
              const SliverFillRemaining(child: Center(child: Text('Buku Tidak Ditemukan', style: TextStyle(color: AppColors.muted))))
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(14, 2, 14, 102),
                sliver: SliverLayoutBuilder(builder: (context, constraints) {
                  final width = constraints.crossAxisExtent;
                  final columns = width > 440 ? 3 : 2;
                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => _CatalogCard(
                        book: books[i],
                        onDetail: () => widget.onDetail(books[i]),
                        onAdd: () => widget.onAdd(books[i]),
                        selected: widget.selected.containsKey(books[i].id),
                      ),
                      childCount: books.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 9,
                      childAspectRatio: columns == 3 ? .48 : .50,
                    ),
                  );
                }),
              ),
          ]),
          if (widget.selected.isNotEmpty)
            Positioned(
              left: 15,
              right: 15,
              bottom: 15,
              child: panel(
                color: AppColors.navy,
                child: Row(children: [
                  const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Siap Dipinjam (${widget.selected.length})', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
                    const Text('Buku terpilih', style: TextStyle(color: Colors.white70, fontSize: 10)),
                  ])),
                  primaryButton('Lanjutkan', widget.onForm, teal: true, icon: Icons.arrow_forward),
                ]),
              ),
            ),
        ]),
      ),
    ]);
  }
}

class _CatalogCard extends StatelessWidget {
  const _CatalogCard({required this.book, required this.onDetail, required this.onAdd, required this.selected});
  final LibraryBook book;
  final VoidCallback onDetail, onAdd;
  final bool selected;
  @override
  Widget build(BuildContext context) => panel(padding: const EdgeInsets.all(9), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Expanded(child: Stack(children: [
      ClipRRect(borderRadius: BorderRadius.circular(8), child: SizedBox(width: double.infinity, height: double.infinity, child: Image.asset(book.image, fit: BoxFit.cover))),
      Positioned(left: 4, top: 5, child: StatusPill(label: book.stock == 0 ? 'Habis (0)' : book.stock == 1 ? 'Terbatas (1)' : 'Tersedia (${book.stock})', color: book.stock == 0 ? AppColors.red : book.stock == 1 ? const Color(0xFFCA7A00) : AppColors.teal)),
      Positioned(right: 5, bottom: 5, child: InkWell(onTap: book.stock > 0 ? onAdd : null, child: CircleAvatar(radius: 17, backgroundColor: selected ? AppColors.teal : const Color(0xFFF1F7FF), child: Icon(book.stock == 0 ? Icons.lock_outline : selected ? Icons.check : Icons.add, color: selected ? Colors.white : AppColors.teal, size: 20)))),
    ])),
    const SizedBox(height: 7),
    Text(book.category.toUpperCase(), style: const TextStyle(fontSize: 9, letterSpacing: .4, color: AppColors.teal)),
    const SizedBox(height: 4),
    Text(book.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, height: 1.25, fontWeight: FontWeight.w800, color: AppColors.text)),
    const SizedBox(height: 4),
    Text(book.author, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: AppColors.muted)),
    const SizedBox(height: 2),
    Text('Rak ${book.rack}  •  Stok ${book.stock}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 9, color: AppColors.muted)),
    const SizedBox(height: 7),
    SizedBox(height: 33, width: double.infinity, child: TextButton(onPressed: onDetail, style: TextButton.styleFrom(backgroundColor: const Color(0xFFE6EEFF), foregroundColor: AppColors.text, padding: EdgeInsets.zero), child: const Text('◉ Detail', style: TextStyle(fontSize: 11)))),
  ]));
}

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key, required this.book, required this.onAdd, required this.onForm});
  final LibraryBook book;
  final VoidCallback onAdd, onForm;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Detail Buku', style: TextStyle(fontWeight: FontWeight.w700))),
    body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 520), child: ListView(padding: const EdgeInsets.all(16), children: [
      Center(child: ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset(book.image, height: 260, width: 190, fit: BoxFit.cover))),
      const SizedBox(height: 13),
      Center(child: StatusPill(label: book.stock == 0 ? 'Stok Habis' : 'Tersedia ${book.stock} dari ${book.stock} Eks', color: book.stock == 0 ? AppColors.red : AppColors.teal, icon: Icons.circle)),
      const SizedBox(height: 11),
      Text(book.title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 23, color: AppColors.deepNavy)),
      const SizedBox(height: 6),
      Text(book.author, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted)),
      const SizedBox(height: 19),
      const SectionHeading('Spesifikasi Inventaris'),
      const SizedBox(height: 10),
      Row(children: [Expanded(child: _InfoTile('Kode Buku', book.code, Icons.tag)), const SizedBox(width: 9), Expanded(child: _InfoTile('ISBN', book.isbn, Icons.qr_code_2))]),
      const SizedBox(height: 9),
      _InfoTile('Kategori', book.category, Icons.category_outlined),
      const SizedBox(height: 9),
      Row(children: [Expanded(child: _InfoTile('Penerbit', book.publisher, Icons.business)), const SizedBox(width: 9), Expanded(child: _InfoTile('Lokasi Rak', book.rack, Icons.inventory_2_outlined))]),
      const SizedBox(height: 17),
      panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Sinopsis & Bahasan', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)), const SizedBox(height: 9), Text(book.description, style: const TextStyle(fontSize: 13, height: 1.55))])),
      const SizedBox(height: 13),
      panel(color: const Color(0xFFE5EEFF), child: const Text('Ketentuan Peminjaman: Pengajuan tidak langsung mengurangi stok. Stok dicadangkan setelah disetujui Admin. Buku diambil secara langsung di perpustakaan.', style: TextStyle(fontSize: 12, height: 1.5))),
      const SizedBox(height: 18),
    ]))),
    bottomNavigationBar: SafeArea(child: Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 10), child: Row(children: [Expanded(child: Text('● ${book.stock} Eks Tersedia', style: const TextStyle(color: AppColors.teal, fontSize: 12, fontWeight: FontWeight.w700))), Expanded(flex: 2, child: primaryButton(book.stock == 0 ? 'Stok Habis' : 'Pilih untuk Dipinjam', () { if (book.stock > 0) { onAdd(); Navigator.of(context).pop(); onForm(); } }, icon: Icons.menu_book_outlined))]))),
  );
}

class _InfoTile extends StatelessWidget {
  const _InfoTile(this.label, this.value, this.icon);
  final String label, value;
  final IconData icon;
  @override
  Widget build(BuildContext context) => panel(color: Colors.white, padding: const EdgeInsets.all(13), child: Row(children: [Icon(icon, color: AppColors.teal, size: 19), const SizedBox(width: 9), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 10)), const SizedBox(height: 3), Text(value, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700))]))]));
}

class BorrowFormPage extends StatefulWidget {
  const BorrowFormPage({super.key, required this.selectedItems, required this.onConfirm});
  final Map<int, int> selectedItems;
  final void Function(Map<int, int>, DateTime, String) onConfirm;
  @override
  State<BorrowFormPage> createState() => _BorrowFormPageState();
}

class _BorrowFormPageState extends State<BorrowFormPage> {
  late Map<int, int> items;
  final notes = TextEditingController();
  DateTime? pickupDate;
  @override
  void initState() { super.initState(); items = Map.from(widget.selectedItems); }
  @override
  void dispose() { notes.dispose(); super.dispose(); }

  Future<void> chooseDate() async {
    final now = DateTime.now();
    final result = await showDatePicker(context: context, firstDate: DateTime(now.year, now.month, now.day), lastDate: now.add(const Duration(days: 90)), initialDate: pickupDate ?? now.add(const Duration(days: 1)), helpText: 'Tanggal Rencana Pengambilan');
    if (result != null) setState(() => pickupDate = result);
  }

  void submit() {
    if (items.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih setidaknya satu buku.'))); return; }
    if (pickupDate == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih tanggal pengambilan terlebih dahulu.'))); return; }
    showDialog<void>(context: context, builder: (dialogContext) => AlertDialog(
      title: const Text('Konfirmasi Pengajuan'),
      content: Text('Ajukan ${items.length} judul (${items.values.fold<int>(0, (a, b) => a + b)} eksemplar) untuk diambil ${dateId(pickupDate!)}?\n\nStatus awal: Diajukan. Stok belum dicadangkan.'),
      actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Kembali Edit')), FilledButton(onPressed: () {
        Navigator.pop(dialogContext);
        final messenger = ScaffoldMessenger.of(context);
        widget.onConfirm(Map<int, int>.from(items), pickupDate!, notes.text.trim());
        Navigator.pop(context);
        messenger.showSnackBar(const SnackBar(content: Text('Pengajuan berhasil disimpan (simulasi). Status: Diajukan.')));
      }, child: const Text('Konfirmasi Pengajuan'))],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final count = items.values.fold<int>(0, (x, y) => x + y);
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Peminjaman', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18))),
      body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 520), child: ListView(padding: const EdgeInsets.all(16), children: [
        panel(child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [CircleAvatar(child: Icon(Icons.person_outline)), SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Farhan Ramadhan', style: TextStyle(fontWeight: FontWeight.w800)), Text('AGT-2024-0089', style: TextStyle(fontSize: 12))])), StatusPill(label: 'Anggota Aktif', color: AppColors.teal)]),
          SizedBox(height: 12), Text('✉ farhan.ramadhan@student.ac.id', style: TextStyle(fontSize: 12)),
        ])),
        const SizedBox(height: 20),
        SectionHeading('Daftar Buku yang Dipilih', trailing: StatusPill(label: '${items.length} Judul', color: AppColors.teal)),
        const SizedBox(height: 9),
        for (final entry in items.entries.toList()) ...[
          panel(child: Column(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(borderRadius: BorderRadius.circular(7), child: Image.asset(findBook(entry.key).image, width: 75, height: 105, fit: BoxFit.cover)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(findBook(entry.key).title, maxLines: 2, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                const SizedBox(height: 6),
                Text('${findBook(entry.key).code} • Rak ${findBook(entry.key).rack}', style: const TextStyle(fontSize: 10, color: AppColors.muted)),
                const SizedBox(height: 8),
                Text('Sisa Stok: ${findBook(entry.key).stock} eks', style: const TextStyle(color: AppColors.teal, fontSize: 11, fontWeight: FontWeight.w700)),
              ])),
              IconButton(onPressed: () => setState(() => items.remove(entry.key)), icon: const Icon(Icons.delete_outline, color: AppColors.red, size: 20)),
            ]),
            const SizedBox(height: 12),
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(9)), child: Row(children: [
              const Expanded(child: Text('Jumlah eksemplar:', style: TextStyle(fontSize: 12))),
              IconButton.filledTonal(onPressed: entry.value > 1 ? () => setState(() => items[entry.key] = entry.value - 1) : null, icon: const Icon(Icons.remove)),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 13), child: Text('${entry.value}')),
              IconButton.filledTonal(onPressed: entry.value < findBook(entry.key).stock ? () => setState(() => items[entry.key] = entry.value + 1) : null, icon: const Icon(Icons.add)),
            ])),
          ])),
          const SizedBox(height: 9),
        ],
        const SizedBox(height: 10),
        panel(color: const Color(0xFFEAF1FF), child: const Text('⊕ Tambahkan buku melalui tab Katalog setelah kembali ke beranda.', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.teal, fontSize: 12))),
        const SizedBox(height: 17),
        panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Detail Pengambilan', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
          const SizedBox(height: 17),
          const Text('Rencana Tanggal Pengambilan Buku *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          InkWell(onTap: chooseDate, child: Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFFEAF1FF), borderRadius: BorderRadius.circular(12)), child: Row(children: [Expanded(child: Text(pickupDate == null ? 'Pilih tanggal pengambilan' : dateId(pickupDate!), style: const TextStyle(fontSize: 12))), const Icon(Icons.calendar_month, color: AppColors.teal)]))),
          const SizedBox(height: 8),
          const Text('ⓘ Pilih tanggal Anda datang langsung ke meja sirkulasi perpustakaan.', style: TextStyle(fontSize: 11, color: AppColors.muted)),
          const SizedBox(height: 15),
          const Text('Catatan Pengajuan (Opsional)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 7),
          TextField(controller: notes, minLines: 3, maxLines: 4, decoration: const InputDecoration(hintText: 'Contoh: Diambil setelah jam perkuliahan selesai...', hintStyle: TextStyle(fontSize: 12))),
        ])),
        const SizedBox(height: 14),
        panel(color: const Color(0xFFE6EEFF), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('♢  Ketentuan Sirkulasi Fisik', style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.w800)),
          SizedBox(height: 9),
          Text('1. Pengajuan tidak langsung memotong stok; stok dicadangkan setelah Admin menyetujui.\n2. Harap tunjukkan identitas anggota saat pengambilan buku fisik.\n3. Keterlambatan dikenakan denda menurut kebijakan perpustakaan.', style: TextStyle(fontSize: 12, height: 1.6)),
        ])),
        const SizedBox(height: 22),
      ]))),
      bottomNavigationBar: SafeArea(child: Container(color: Colors.white, padding: const EdgeInsets.fromLTRB(13, 9, 13, 9), child: Row(children: [Expanded(child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Ringkasan Ajuan', style: TextStyle(fontSize: 11, color: AppColors.muted)), Text('Total: ${items.length} Buku ($count Eks)', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12))])), Expanded(flex: 2, child: primaryButton('Lanjutkan ke Konfirmasi', submit, icon: Icons.arrow_forward))]))),
    );
  }
}

class DemoLoginPage extends StatefulWidget {
  const DemoLoginPage({super.key, required this.onLoggedIn});
  final VoidCallback onLoggedIn;
  @override
  State<DemoLoginPage> createState() => _DemoLoginPageState();
}

class _DemoLoginPageState extends State<DemoLoginPage> {
  final email = TextEditingController(text: 'farhan.ramadhan@student.ac.id');
  final password = TextEditingController(text: 'demo12345');
  bool hidden = true;
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  void login() {
    if (email.text.trim().isEmpty || password.text.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Masukkan email dan kata sandi.'))); return; }
    widget.onLoggedIn();
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Masuk Anggota')), body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 450), child: ListView(padding: const EdgeInsets.all(20), children: [
    const SizedBox(height: 20),
    const Icon(Icons.auto_stories, size: 55, color: AppColors.teal),
    const SizedBox(height: 14),
    const Text('Selamat Datang Kembali', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23)),
    const SizedBox(height: 8),
    const Text('Masuk ke akun anggota Perpustakaan', textAlign: TextAlign.center, style: TextStyle(color: AppColors.muted)),
    const SizedBox(height: 23),
    panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Email', style: TextStyle(fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(hintText: 'Email anggota')),
      const SizedBox(height: 16),
      const Text('Kata Sandi', style: TextStyle(fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      TextField(controller: password, obscureText: hidden, decoration: InputDecoration(hintText: 'Kata sandi', suffixIcon: IconButton(onPressed: () => setState(() => hidden = !hidden), icon: Icon(hidden ? Icons.visibility : Icons.visibility_off)))),
      const SizedBox(height: 20),
      SizedBox(width: double.infinity, child: primaryButton('Masuk (Demo)', login)),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage())), child: const Text('Lupa Kata Sandi?')),
        TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())), child: const Text('Daftar Akun')),
      ]),
      const SizedBox(height: 6),
      const Text('Mode demo lokal: email dan kata sandi tidak diperiksa oleh server. Integrasi autentikasi Laravel belum tersedia.', style: TextStyle(color: AppColors.muted, fontSize: 11)),
    ])),
  ]))));
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.loans, required this.onBrowse});
  final List<LoanRecord> loans;
  final VoidCallback onBrowse;
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(17), children: [
    const Text('Peminjaman Saya', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
    const SizedBox(height: 4),
    const Text('Riwayat transaksi lokal untuk pratinjau UI.', style: TextStyle(fontSize: 12, color: AppColors.muted)),
    const SizedBox(height: 17),
    if (loans.isEmpty) panel(child: Column(children: [
      const SizedBox(height: 26),
      const Icon(Icons.assignment_outlined, color: AppColors.teal, size: 49),
      const SizedBox(height: 12),
      const Text('Belum Ada Pengajuan', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
      const SizedBox(height: 6),
      const Text('Pilih buku dari katalog dan ajukan peminjaman.', style: TextStyle(color: AppColors.muted, fontSize: 12), textAlign: TextAlign.center),
      const SizedBox(height: 18),
      primaryButton('Jelajahi Katalog', onBrowse),
      const SizedBox(height: 16),
    ])),
    for (final loan in loans) ...[panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Expanded(child: Text('#${loan.code}', style: const TextStyle(fontWeight: FontWeight.w800))), const StatusPill(label: 'Diajukan', color: Color(0xFFD97706))]),
      const SizedBox(height: 7),
      Text('${loan.items.length} judul • ${loan.items.values.fold<int>(0, (a, b) => a + b)} eksemplar', style: const TextStyle(fontSize: 12)),
      const SizedBox(height: 6),
      Text('Pengajuan: ${dateId(loan.createdAt)}', style: const TextStyle(fontSize: 11, color: AppColors.muted)),
      Text('Rencana ambil: ${dateId(loan.pickupDate)}', style: const TextStyle(fontSize: 11, color: AppColors.muted)),
      const Divider(height: 22),
      for (final entry in loan.items.entries) Text('• ${findBook(entry.key).title} × ${entry.value}', style: const TextStyle(fontSize: 12)),
      const SizedBox(height: 12),
      const Text('Menunggu pemeriksaan Admin. Stok belum dicadangkan.', style: TextStyle(color: AppColors.teal, fontSize: 11)),
    ])), const SizedBox(height: 10)],
  ]);
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.onLogout, required this.onHistory, required this.onAdmin});
  final VoidCallback onLogout, onHistory, onAdmin;
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    panel(child: const Column(children: [
      CircleAvatar(radius: 30, backgroundColor: Color(0xFFDCE8FF), child: Icon(Icons.person, size: 33, color: AppColors.navy)),
      SizedBox(height: 12),
      Text('Farhan Ramadhan', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
      SizedBox(height: 5),
      Text('farhan.ramadhan@student.ac.id', style: TextStyle(fontSize: 12, color: AppColors.muted)),
      SizedBox(height: 10),
      StatusPill(label: 'Anggota Aktif', color: AppColors.teal),
    ])),
    const SizedBox(height: 14),
    panel(child: Column(children: [
      ListTile(leading: const Icon(Icons.badge_outlined), title: const Text('Nomor Anggota'), subtitle: const Text('AGT-2024-0089')),
      const Divider(),
      ListTile(leading: const Icon(Icons.history), title: const Text('Peminjaman Saya'), trailing: const Icon(Icons.chevron_right), onTap: onHistory),
      const Divider(),
      ListTile(leading: const Icon(Icons.admin_panel_settings_outlined), title: const Text('Simulasi Admin BRD'), subtitle: const Text('Persetujuan, penyerahan, pengembalian, denda, dan bukti email.'), trailing: const Icon(Icons.chevron_right), onTap: onAdmin),
      const Divider(),
      ListTile(leading: const Icon(Icons.info_outline), title: const Text('Tentang Prototipe'), subtitle: const Text('Flutter demo sesuai BRD; seluruh data masih lokal dan belum terhubung backend.')),
    ])),
    const SizedBox(height: 19),
    primaryButton('Keluar Akun Demo', onLogout, icon: Icons.logout),
  ]);
}


class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Registrasi Anggota')),
    body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480), child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Daftar sebagai Anggota', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        const Text('Prototype lokal sesuai kebutuhan akun Anggota pada BRD.', style: TextStyle(color: AppColors.muted)),
        const SizedBox(height: 18),
        for (final data in const [
          ('Nama Lengkap', 'Farhan Ramadhan', false),
          ('Email', 'farhan.ramadhan@student.ac.id', false),
          ('Kode / Identitas Keanggotaan', 'AGT-2024-0089', false),
          ('Kata Sandi', '********', true),
          ('Konfirmasi Kata Sandi', '********', true),
        ]) ...[
          Text(data.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 7),
          TextField(obscureText: data.$3, decoration: InputDecoration(hintText: data.$2)),
          const SizedBox(height: 14),
        ],
        primaryButton('Daftar Akun (Demo)', () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registrasi berhasil (simulasi lokal).')));
          Navigator.pop(context);
        }, teal: true),
      ],
    ))),
  );
}

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Lupa Kata Sandi')),
    body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 460), child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Icon(Icons.lock_reset, size: 60, color: AppColors.teal),
        const SizedBox(height: 12),
        const Text('Reset Kata Sandi', textAlign: TextAlign.center, style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        const Text('Masukkan email Anggota. Pada implementasi backend, tautan reset dikirim melalui layanan surel.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.muted)),
        const SizedBox(height: 22),
        const TextField(decoration: InputDecoration(labelText: 'Email Anggota', hintText: 'email@contoh.com')),
        const SizedBox(height: 16),
        primaryButton('Kirim Tautan Reset (Demo)', () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tautan reset terkirim (simulasi).')))),
      ],
    ))),
  );
}

class AdminPrototypePage extends StatefulWidget {
  const AdminPrototypePage({super.key});
  @override
  State<AdminPrototypePage> createState() => _AdminPrototypePageState();
}

class _AdminPrototypePageState extends State<AdminPrototypePage> {
  int tab = 0;
  String status = 'Diajukan';
  int stock = 5;
  bool emailSent = false;
  int fine = 0;
  bool finePaid = false;

  Color statusColor() {
    switch (status) {
      case 'Disetujui': return AppColors.teal;
      case 'Ditolak': return AppColors.red;
      case 'Dipinjam': return const Color(0xFF2563EB);
      case 'Dikembalikan': return const Color(0xFF16A34A);
      default: return const Color(0xFFD97706);
    }
  }

  void approve() {
    if (status != 'Diajukan') return;
    setState(() { status = 'Disetujui'; stock = (stock - 1).clamp(0, 99).toInt(); });
  }
  void reject() {
    if (status != 'Diajukan') return;
    setState(() => status = 'Ditolak');
  }
  void handover() {
    if (status != 'Disetujui') return;
    setState(() { status = 'Dipinjam'; emailSent = true; });
  }
  void returnBook() {
    if (status != 'Dipinjam') return;
    setState(() { status = 'Dikembalikan'; stock += 1; fine = 15000; });
  }

  @override
  Widget build(BuildContext context) {
    const labels = ['Dashboard', 'Pengajuan', 'Penyerahan', 'Pengembalian', 'Denda', 'Email'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulasi Admin BRD', style: TextStyle(fontWeight: FontWeight.w800)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SizedBox(height: 48, child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            scrollDirection: Axis.horizontal,
            itemCount: labels.length,
            separatorBuilder: (_, __) => const SizedBox(width: 7),
            itemBuilder: (_, i) => ChoiceChip(label: Text(labels[i]), selected: tab == i, onSelected: (_) => setState(() => tab = i)),
          )),
        ),
      ),
      body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 760), child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          panel(child: Row(children: [
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('PMJ-2026-1043', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
              SizedBox(height: 3),
              Text('Farhan Ramadhan • Clean Architecture & Flutter', style: TextStyle(fontSize: 12, color: AppColors.muted)),
            ])),
            StatusPill(label: status, color: statusColor()),
          ])),
          const SizedBox(height: 12),
          if (tab == 0) _dashboard(),
          if (tab == 1) _request(),
          if (tab == 2) _handover(),
          if (tab == 3) _return(),
          if (tab == 4) _fine(),
          if (tab == 5) _email(),
          const SizedBox(height: 14),
          panel(color: const Color(0xFFFFF4DB), child: const Text(
            'Catatan: panel ini hanya simulasi UI/UX agar seluruh alur BRD dapat didemonstrasikan di Android Studio. BRD menetapkan Admin sebagai panel web Laravel Filament pada implementasi nyata.',
            style: TextStyle(fontSize: 12, height: 1.5),
          )),
        ],
      ))),
    );
  }

  Widget _dashboard() => Column(children: [
    Row(children: [
      Expanded(child: panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Stok Tersedia', style: TextStyle(color: AppColors.muted)), Text('$stock', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900))]))),
      const SizedBox(width: 10),
      Expanded(child: panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Status', style: TextStyle(color: AppColors.muted)), Text(status, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: statusColor()))]))),
    ]),
    const SizedBox(height: 10),
    panel(child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Aturan Utama BRD', style: TextStyle(fontWeight: FontWeight.w900)),
      SizedBox(height: 9),
      Text('• Diajukan: stok belum dicadangkan.\n• Disetujui: stok dicadangkan satu kali.\n• Dipinjam: buku fisik diserahkan dan bukti email diproses.\n• Dikembalikan: stok dipulihkan dan denda dapat dicatat.\n• Ditolak: stok tidak berubah.', style: TextStyle(height: 1.6)),
    ])),
  ]);

  Widget _request() => panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Detail Pengajuan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
    const SizedBox(height: 12),
    const ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.person_outline), title: Text('Farhan Ramadhan'), subtitle: Text('Anggota Aktif • AGT-2024-0089')),
    const ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.menu_book_outlined), title: Text('Clean Architecture & Flutter'), subtitle: Text('1 eksemplar • Rencana ambil: 3 November 2026')),
    const SizedBox(height: 10),
    if (status == 'Diajukan') Row(children: [
      Expanded(child: primaryButton('Setujui', approve, teal: true)),
      const SizedBox(width: 10),
      Expanded(child: OutlinedButton.icon(onPressed: reject, icon: const Icon(Icons.close), label: const Text('Tolak'))),
    ]) else Text('Keputusan sudah diproses: $status', style: const TextStyle(fontWeight: FontWeight.w700)),
  ]));

  Widget _handover() => panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Penyerahan Buku Fisik', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
    const SizedBox(height: 8),
    Text(status == 'Disetujui' ? 'Pengajuan sudah disetujui. Verifikasi identitas lalu serahkan buku.' : 'Penyerahan hanya dapat dilakukan saat status Disetujui.'),
    const SizedBox(height: 14),
    const TextField(decoration: InputDecoration(labelText: 'Tanggal Jatuh Tempo', hintText: 'Ditentukan Admin sesuai kebijakan')),
    const SizedBox(height: 12),
    primaryButton('Konfirmasi Penyerahan', handover, teal: true),
  ]));

  Widget _return() => panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Pengembalian Buku', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
    const SizedBox(height: 8),
    Text(status == 'Dipinjam' ? 'Catat pengembalian fisik. Stok akan dipulihkan.' : 'Pengembalian hanya tersedia saat status Dipinjam.'),
    const SizedBox(height: 14),
    primaryButton('Proses Pengembalian', returnBook),
  ]));

  Widget _fine() => panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Denda Luring', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
    const SizedBox(height: 10),
    Text('Nominal tercatat: Rp ${fine == 0 ? '0' : '15.000'}'),
    const SizedBox(height: 8),
    StatusPill(label: finePaid ? 'Sudah Lunas' : 'Belum Lunas', color: finePaid ? const Color(0xFF16A34A) : const Color(0xFFD97706)),
    const SizedBox(height: 14),
    FilledButton.icon(onPressed: fine > 0 && !finePaid ? () => setState(() => finePaid = true) : null, icon: const Icon(Icons.payments_outlined), label: const Text('Catat Pembayaran Luring')),
  ]));

  Widget _email() => panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Bukti Peminjaman via Email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
    const SizedBox(height: 8),
    Text(emailSent ? 'Status: Terkirim (simulasi)' : 'Status: Belum dikirim'),
    const SizedBox(height: 10),
    const Text('Bukti peminjaman baru dikirim setelah transaksi berstatus Dipinjam. Kegagalan email tidak membatalkan transaksi yang sah.', style: TextStyle(color: AppColors.muted, height: 1.5)),
    const SizedBox(height: 14),
    FilledButton.icon(onPressed: status == 'Dipinjam' || status == 'Dikembalikan' ? () => setState(() => emailSent = true) : null, icon: const Icon(Icons.send_outlined), label: const Text('Kirim Ulang (Demo)')),
  ]));
}
