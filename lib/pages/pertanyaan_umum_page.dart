import 'package:flutter/material.dart';
import '../components/info_container_custom.dart';
import '../theme/theme.dart';

class PertanyaanUmumPage extends StatefulWidget {
  const PertanyaanUmumPage({super.key});

  @override
  State<PertanyaanUmumPage> createState() => _PertanyaanUmumPageState();
}

class _PertanyaanUmumPageState extends State<PertanyaanUmumPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final Map<String, List<Map<String, String>>> _categorizedQuestions = {
    'Kalkulasi & Perencanaan': [
      {
        'title': 'Bagaimana HPL Dikalkulasikan?',
        'desc':
        'HPL dikalkulasikan berdasarkan panjang siklus 28 hari teratur, dengan menghitung 40 minggu (280 hari) dari hari pertama haid terakhir menstruasi, namun, bunda harus tau bahwa setiap kehamilan itu berbeda dan HPL hanyalah perkiraan – apalagi jika sebelumnya haid tidak teratur',
      },
      {
        'title': 'Kapan saya harus cuti kerja?',
        'desc':
        'Cuti kerja saat hamil biasanya mengikuti aturan undang-undang ketenagakerjaan. Di Indonesia, bunda berhak mendapatkan cuti melahirkan 3 bulan. Umumnya diambil 1,5 bulan sebelum perkiraan lahir dan 1,5 bulan setelah melahirkan.'
            '\n\nNamun, waktu mulai cuti bisa berbeda-beda. Kalau kehamilan bunda sehat dan tenaga kesehatan yang menyatakan aman, bunda bisa tetap bekerja lebih lama dan mulai cuti mendekati hari perkiraan lahir. Sebaliknya, kalau ada keluhan atau kehamilan berisiko, cuti bisa dimulai lebih awal sesuai anjuran tenaga kesehatan.'
            '\n\nJadi, kapan bunda harus cuti kerja sangat bergantung pada kondisi kehamilan dan aturan tempat kerja, tapi umumnya sekitar 1,5 bulan sebelum melahirkan.',
      },
    ],
    'Kesehatan & Nutrisi': [
      {
        'title': 'Bakal senaik apa berat badan saya selama kehamilan?',
        'desc':
        'Selama kehamilan, kenaikan berat badan bunda dipengaruhi oleh status gizi sebelum hamil. Menurut teori, bunda dengan berat badan normal dianjurkan mengalami kenaikan total sekitar 11,5–16 kg. Pada trimester pertama umumnya hanya bertambah 0,5–2 kg, kemudian pada trimester kedua dan ketiga kenaikan berlangsung lebih cepat, sekitar 0,4–0,5 kg setiap minggu. Jika sebelum hamil berat badan kurang, kenaikan dianjurkan lebih banyak, sedangkan bila berlebih atau obesitas, kenaikan sebaiknya lebih sedikit. Kenaikan berat badan yang sesuai teori ini penting untuk mendukung kesehatan bunda dan tumbuh kembang janin.',
      },
      {
        'title': 'Apa saja nutrisi penting selama kehamilan?',
        'desc':
        'Nutrisi penting selama kehamilan meliputi asam folat untuk perkembangan saraf bayi, zat besi untuk mencegah anemia, kalsium untuk pembentukan tulang dan gigi, protein untuk pertumbuhan sel-sel janin, serta DHA untuk perkembangan otak dan mata. Pastikan untuk mengonsumsi makanan bergizi seimbang dan mengikuti anjuran dokter mengenai suplemen yang diperlukan.',
      },
      {
        'title': 'Apakah aman mandi dengan air panas dan sauna?',
        'desc':
        'Mandi dengan air yang terlalu panas atau menggunakan sauna saat hamil sebaiknya dihindari. '
            'Suhu tubuh bunda yang meningkat terlalu tinggi bisa berdampak kurang baik bagi janin, '
            'terutama pada awal kehamilan. Air hangat yang nyaman untuk relaksasi masih aman, '
            'tetapi jangan sampai air terlalu panas hingga membuat tubuh terasa pusing atau berkeringat berlebihan. '
            'Sauna juga tidak dianjurkan karena dapat menyebabkan dehidrasi dan menurunkan tekanan darah. '
            'Untuk relaksasi yang aman, bunda bisa mandi dengan air hangat suam-suam kuku',
      },
      {
        'title': 'Apakah aman kedokter gigi?',
        'desc':
        'Pergi ke dokter gigi saat hamil umumnya aman, bahkan dianjurkan untuk '
            'menjaga kesehatan mulut dan gigi. Pembersihan karang gigi, penambalan, '
            'atau pemeriksaan rutin boleh dilakukan. Sebaiknya beri tahu dokter gigi '
            'bahwa bunda sedang hamil, agar obat atau tindakan yang diberikan disesuaikan '
            'dengan kondisi kehamilan. Pemeriksaan gigi justru penting karena infeksi gigi '
            'dan gusi bisa memengaruhi kesehatan bunda dan janin.',
      },
    ],
    'Gejala & Perubahan Tubuh': [
      {
        'title': 'Bercak saat hamil, apa perlu saya khawatirkan?',
        'desc':
        'Bercak atau flek saat hamil bisa terjadi dan tidak selalu berbahaya. Pada awal kehamilan, bercak ringan kadang normal, misalnya karena proses menempelkan janin di dinding rahim. Namun bunda tetap perlu waspada. Bila bercak berwarna merah segar, keluar banyak, disertai nyeri perut, pusing, atau keluar gumpalan darah, sebaiknya segera periksa ke tenaga kesehatan. Bercak seperti ini bisa menjadi tanda masalah pada kehamilan. Jadi, jangan panik dulu, tapi tetap perhatikan jumlah, warna, dan keluhan lain yang menyertai. Untuk memastikan kondisi bunda dan janin aman, periksakan diri',
      },
      {
        'title': 'Kapan masa ngidam dimulai dan berakhir?',
        'desc':
        'Ngidam biasanya mulai dirasakan pada trimester pertama, sekitar usia kehamilan minggu ke-4 sampai ke-8. Pada masa ini, bunda bisa sangat ingin makanan tertentu atau justru tidak suka makanan yang biasanya disukai.'
            '\n\nNgidam biasanya akan berkurang atau hilang setelah masuk trimester kedua, sekitar usia minggu ke-14 sampai ke-16. Namun, pada beberapa bunda, ngidam bisa tetap muncul sampai akhir kehamilan, meski biasanya tidak sekuat di awal.'
            'Intinya, ngidam itu normal selama kehamilan. Yang penting, bunda tetap menjaga pola makan seimbang dan tidak berlebihan.',
      },
      {
        'title': 'Kapan saya merasakan bayi mulai bergerak?',
        'desc':
        'Bunda biasanya mulai merasakan gerakan bayi pertama kali pada usia '
            'kehamilan sekitar 18–20 minggu. Pada bunda yang sudah pernah hamil '
            'sebelumnya, gerakan bisa terasa lebih awal, sekitar 16 minggu. '
            'Awalnya gerakan terasa halus seperti gelembung atau kedutan kecil, '
            'kemudian semakin jelas seiring bertambahnya usia kehamilan. '
            'Jika sampai usia 24 minggu bunda belum merasakan gerakan bayi, '
            'sebaiknya periksa ke fasilitas Kesehatan',
      },
    ],
    'Aktivitas & Gaya Hidup': [
      {
        'title': 'Apa saja olahraga yang aman selama kehamilan?',
        'desc':
        'Olahraga yang aman selama kehamilan antara lain jalan kaki, berenang, yoga prenatal, dan senam hamil. Hindari olahraga dengan risiko jatuh atau benturan. Selalu konsultasikan dengan dokter sebelum memulai program olahraga baru, terutama jika memiliki kondisi kesehatan tertentu. Dengarkan tubuh Anda dan berhenti jika merasa lelah atau tidak nyaman.',
      },
      {
        'title': 'Apakah perjalanan udara aman?',
        'desc':
        'Perjalanan udara umumnya aman untuk bunda hamil bila kondisi sehat dan tidak ada masalah pada kehamilan. Maskapai biasanya memperbolehkan sampai usia kehamilan 36 minggu, namun setelah 28 minggu sering diminta surat keterangan dari dokter. Saat bepergian, bunda disarankan banyak minum air putih, sesekali bergerak agar aliran darah lancar, serta memilih kursi yang nyaman. Jika ada keluhan atau kehamilan berisiko, sebaiknya konsultasi dulu sebelum melakukan perjalanan udara.',
      },
    ],
    'Kesehatan & Komplikasi': [
      {
        'title': 'Kapan harus menghubungi dokter selama kehamilan?',
        'desc':
        'Segera hubungi dokter jika mengalami: perdarahan vagina, nyeri perut yang hebat atau terus-menerus, sakit kepala parah yang tidak kunjung hilang, penglihatan kabur, pembengkakan tiba-tiba di tangan atau wajah, demam tinggi, muntah terus-menerus, atau jika merasa pergerakan bayi berkurang drastis setelah minggu ke-28.',
      },
      {
        'title': 'Apa yang harus saya lakukan untuk bayi dalam posisi sungsang?',
        'desc':
        'Bayi dalam posisi sungsang artinya kepala bayi berada di atas, bukan di bawah. '
            'Kondisi ini cukup sering ditemukan pada usia kehamilan muda dan biasanya masih bisa berubah dengan sendirinya. '
            'Jika mendekati persalinan bayi tetap sungsang, bunda sebaiknya rutin kontrol ke dokter spesialis kandungan '
            'dan ginekologi. Tenaga kesehatan akan memantau posisi bayi, '
            'memberikan latihan atau posisi tertentu agar bayi berputar, '
            'dan menentukan cara persalinan yang paling aman. Jangan panik, '
            'tetap jaga kesehatan dan ikuti anjuran pemeriksaan teratur.',
      },
    ],
  };

  final Map<String, bool> _categoryExpansionState = {};

  @override
  void initState() {
    super.initState();
    // Initialize all categories as expanded
    for (var category in _categorizedQuestions.keys) {
      _categoryExpansionState[category] = true;
    }
  }

  List<Map<String, String>> _filterQuestions(List<Map<String, String>> questions) {
    if (_searchQuery.isEmpty) return questions;

    return questions.where((question) {
      return question['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          question['desc']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pertanyaan Umum Kehamilan",
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
                    color: Colors.black.withValues(alpha:0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari pertanyaan...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                      });
                    },
                  )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Show all questions if searching, otherwise show categorized
                  _searchQuery.isNotEmpty
                      ? Column(
                    children: _getAllQuestions()
                        .map(
                          (pertanyaan) => Column(
                        children: [
                          InfoContainerCustom(
                            title: pertanyaan['title']!,
                            desc: pertanyaan['desc']!,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    )
                        .toList(),
                  )
                      : Column(
                    children: _categorizedQuestions.entries.map((entry) {
                      final category = entry.key;
                      final questions = _filterQuestions(entry.value);

                      if (questions.isEmpty) return const SizedBox.shrink();

                      return Column(
                        children: [
                          // Category Header
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _categoryExpansionState[category] =
                                !_categoryExpansionState[category]!;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: kPrimaryColor.withValues(alpha:0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    category,
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    _categoryExpansionState[category]!
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Questions in this category
                          if (_categoryExpansionState[category]!)
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Column(
                                children: questions
                                    .map(
                                      (pertanyaan) => Column(
                                    children: [
                                      InfoContainerCustom(
                                        title: pertanyaan['title']!,
                                        desc: pertanyaan['desc']!,
                                      ),
                                      const SizedBox(height: 12),
                                    ],
                                  ),
                                )
                                    .toList(),
                              ),
                            ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getAllQuestions() {
    List<Map<String, String>> allQuestions = [];
    _categorizedQuestions.forEach((key, value) {
      allQuestions.addAll(value);
    });
    return _filterQuestions(allQuestions);
  }
}