import 'package:flutter/material.dart';
import '../theme/theme.dart';

class MateriMaternitas extends StatefulWidget {
  const MateriMaternitas({super.key});

  @override
  State<MateriMaternitas> createState() => _MateriMaternitasState();
}

class _MateriMaternitasState extends State<MateriMaternitas> {
  final TextEditingController _searchController = TextEditingController();
  final List<_SectionData> _allSections = [
    _SectionData(
      title: 'Keperawatan Maternitas Secara Teoritis',
      items: [
        _InfoItem('Definisi', 'Ilmu dan praktik keperawatan yang berfokus pada perempuan (sebelum hamil, hamil, melahirkan, setelah melahirkan), bayi baru lahir, dan keluarga sebagai pendukung utama.'),
        _InfoItem('Prinsip Keperawatan', 'Holistik, family-centered care, humanistik, promotif dan preventif, serta evidence-based.'),
        _InfoItem('Sosok Perawat Maternitas', 'Kombinasi ahli medis, pendidik, pelindung hak ibu & bayi, pendukung emosional, dan problem solver dengan nilai empati dan keibuan.'),
        _InfoItem('Tujuan Utama', 'Menurunkan angka kematian ibu & bayi, menjamin kesehatan fisik dan mental ibu, memastikan bayi tumbuh optimal, dan membantu keluarga mandiri dalam merawat.'),
      ],
    ),
    _SectionData(
      title: 'Kesehatan Ibu Hamil',
      items: [
        _InfoItem('Pemeriksaan Rutin', 'Lakukan kontrol kehamilan secara teratur untuk memantau perkembangan janin dan mendeteksi dini masalah kesehatan.'),
        _InfoItem('Nutrisi Penting', 'Konsumsi makanan bergizi seimbang dengan asam folat, zat besi, kalsium, dan protein. Hindari makanan mentah, alkohol, dan batasi kafein.'),
        _InfoItem('Aktivitas & Olahraga', 'Lakukan olahraga ringan seperti jalan kaki, senam hamil, atau yoga. Hindari aktivitas berat dan istirahat yang cukup.'),
      ],
    ),
    _SectionData(
      title: 'Persiapan Menjelang Persalinan',
      items: [
        _InfoItem('Tanda-Tanda Persalinan', 'Kontraksi teratur, pecah ketuban, dan pembukaan serviks. Segera hubungi dokter atau bidan ketika mengalami tanda-tanda ini.'),
        _InfoItem('Pilihan Persalinan', 'Persalinan normal, caesar, atau water birth. Diskusikan dengan dokter tentang metode terbaik sesuai kondisi kesehatan.'),
        _InfoItem('Persiapan Menjelang Persalinan', 'Siapkan tas berisi kebutuhan ibu dan bayi, dokumen penting, serta rencanakan transportasi ke rumah sakit.'),
      ],
    ),
    _SectionData(
      title: 'Perawatan Bayi Baru Lahir',
      items: [
        _InfoItem('Menyusui', 'Berikan ASI eksklusif 6 bulan. Pastikan pelekatan yang benar dan susui setiap 2-3 jam atau sesuai kebutuhan bayi.'),
        _InfoItem('Perawatan Tali Pusat', 'Jaga kebersihan area tali pusat, keringkan setelah mandi, dan hindari penggunaan bedak atau alkohol berlebihan.'),
        _InfoItem('Perawatan Kulit', 'Gunakan produk bayi yang hypoallergenic, mandikan dengan air hangat, dan jaga kulit tetap kering untuk mencegah ruam.'),
        _InfoItem('Imunisasi', 'Lengkapi imunisasi sesuai jadwal untuk melindungi bayi dari berbagai penyakit berbahaya.'),
      ],
    ),
    _SectionData(
      title: 'Pemulihan dan Perawatan Pasca Melahirkan',
      items: [
        _InfoItem('Pemulihan Pasca Melahirkan', 'Lakukan perawatan pasca persalinan, konsumsi makanan bergizi, dan lakukan olahraga ringan setelah mendapat izin dokter.'),
        _InfoItem('Kesehatan Mental Ibu', 'Jaga kesehatan mental dengan istirahat cukup, dukungan keluarga, dan jangan ragu berkonsultasi dengan tenaga kesehatan jika mengalami baby blues.'),
      ],
    ),
    _SectionData(
      title: 'Masalah yang Sering Dihadapi',
      items: [
        _InfoItem('Pada Ibu Hamil', 'Anemia, hipertensi, diabetes, stres selama kehamilan'),
        _InfoItem('Pada Ibu Melahirkan', 'Persalinan lama, perdarahan, nyeri hebat'),
        _InfoItem('Pada Ibu Nifas', 'Infeksi, kesulitan menyusui, depresi pasca persalinan'),
        _InfoItem('Pada Bayi', 'Lahir prematur, BBLR (berat badan lahir rendah), infeksi, kuning'),
      ],
    ),
  ];

  List<_SectionData> _filteredSections = [];

  @override
  void initState() {
    super.initState();
    _filteredSections = _allSections;
    _searchController.addListener(_filterSections);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSections() {
    final query = _searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        _filteredSections = _allSections;
      });
      return;
    }

    final filtered = _allSections.map((section) {
      final filteredItems = section.items.where((item) {
        return item.title.toLowerCase().contains(query) ||
            item.content.toLowerCase().contains(query) ||
            section.title.toLowerCase().contains(query);
      }).toList();

      return filteredItems.isNotEmpty
          ? _SectionData(title: section.title, items: filteredItems)
          : null;
    }).where((section) => section != null).cast<_SectionData>().toList();

    setState(() {
      _filteredSections = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Materi Maternitas",
          style: whiteTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha:0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari materi maternitas...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                      : null,
                ),
              ),
            ),
          ),

          // Hasil pencarian atau "tidak ditemukan"
          if (_filteredSections.isEmpty && _searchController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tidak ditemukan hasil untuk "${_searchController.text}"',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header dengan gambar (hanya ditampilkan jika tidak sedang mencari)
                    if (_searchController.text.isEmpty) ...[
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage('assets/matern.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withValues(alpha:0.4),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const Center(
                            child: Text(
                              'Panduan Lengkap Ibu Hamil & Perawatan Bayi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Data sections yang sudah difilter
                    ..._buildFilteredSections(),

                    const SizedBox(height: 24),

                    // Penutup (hanya ditampilkan jika tidak sedang mencari)
                    if (_searchController.text.isEmpty) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Selalu konsultasikan dengan tenaga kesehatan profesional untuk perawatan yang tepat sesuai kondisi individu.',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.pink,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildFilteredSections() {
    return _filteredSections.map((section) => _buildSection(section)).toList();
  }

  Widget _buildSection(_SectionData section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(section.title),
        const SizedBox(height: 12),
        ...section.items.map((item) => Column(
          children: [
            _buildInfoCard(item.title, item.content, _searchController.text),
            if (item != section.items.last) const SizedBox(height: 8),
          ],
        )),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return _buildHighlightedText(
      title,
      _searchController.text,
      primaryTextStyle.copyWith(
        fontSize: 18,
        fontWeight: bold
      )
    );
  }

  Widget _buildInfoCard(String title, String content, String searchQuery) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: kPrimaryColor.withValues(alpha:1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title dengan style bold dan warna hitam
            _buildHighlightedText(
              title,
              searchQuery,
              primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold
              )
            ),
            const SizedBox(height: 8),
            // Content dengan style normal dan warna hitam
            _buildHighlightedText(
              content,
              searchQuery,
              const TextStyle(
                fontSize: 14,
                color: Colors.black, // Warna hitam untuk konten
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(String text, String query, TextStyle baseStyle) {
    if (query.isEmpty) {
      return Text(text, style: baseStyle);
    }

    final textLower = text.toLowerCase();
    final queryLower = query.toLowerCase();

    final matches = <_TextMatch>[];
    int start = 0;

    while (start < textLower.length) {
      final index = textLower.indexOf(queryLower, start);
      if (index == -1) break;

      matches.add(_TextMatch(start: index, end: index + query.length));
      start = index + query.length;
    }

    if (matches.isEmpty) {
      return Text(text, style: baseStyle);
    }

    final textSpans = <TextSpan>[];
    int currentIndex = 0;

    for (final match in matches) {
      // Teks sebelum match
      if (match.start > currentIndex) {
        textSpans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
          style: baseStyle,
        ));
      }

      // Teks yang match (highlight)
      textSpans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: baseStyle.copyWith(
          color: kPrimaryColor, // Hanya warna teks yang berubah
          fontWeight: FontWeight.bold,
          backgroundColor: kPrimaryColor.withValues(alpha:0.1), // Background highlight
        ),
      ));

      currentIndex = match.end;
    }

    // Teks setelah match terakhir
    if (currentIndex < text.length) {
      textSpans.add(TextSpan(
        text: text.substring(currentIndex),
        style: baseStyle,
      ));
    }

    return RichText(
      text: TextSpan(children: textSpans),
    );
  }
}

class _TextMatch {
  final int start;
  final int end;

  _TextMatch({required this.start, required this.end});
}

class _SectionData {
  final String title;
  final List<_InfoItem> items;

  _SectionData({required this.title, required this.items});
}

class _InfoItem {
  final String title;
  final String content;

  _InfoItem(this.title, this.content);
}