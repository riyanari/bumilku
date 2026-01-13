import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/info_container_custom.dart';
import '../cubit/locale_cubit.dart';
import '../theme/theme.dart';

class PertanyaanUmumPage extends StatefulWidget {
  const PertanyaanUmumPage({super.key});

  @override
  State<PertanyaanUmumPage> createState() => _PertanyaanUmumPageState();
}

class _PertanyaanUmumPageState extends State<PertanyaanUmumPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // ===== DATA INDONESIA (punyamu) =====
  late final Map<String, List<Map<String, String>>> _categorizedQuestionsId = {
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
        'title': 'Bagaimana bisa tahu kalau saya hamil?',
        'desc':
        'Tanda Tidak Pasti (Presumtif): haid terlambat, mual muntah, payudara nyeri/membesar, sering buang air kecil, cepat lelah/pusing/mengantuk, perubahan nafsu makan. Tanda ini belum pasti karena bisa disebabkan faktor lain.'
            '\n\nTanda Kemungkinan (Probabel): rahim membesar, perubahan pada leher rahim, tes kehamilan positif. Mengarah ke hamil tapi masih bisa salah.'
            '\n\nTanda Pasti (Positif): terlihat janin dengan USG, terdengar detak jantung janin, teraba bagian tubuh janin. Inilah tanda yang memastikan hamil.',
      },
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
      {
        'title': 'Apakah aman hamil setelah usia 35 tahun?',
        'desc':
        'Hamil setelah usia 35 tahun masih bisa aman, banyak bunda yang sehat dan melahirkan normal di usia ini. '
            'Namun, memang ada risiko yang sedikit lebih tinggi dibanding hamil di usia lebih muda, seperti tekanan darah tinggi, '
            'diabetes saat hamil, keguguran, atau bayi lahir dengan kelainan kromosom. '
            'Selain itu, kemungkinan persalinan dengan operasi caesar juga lebih besar.'
            '\n\nWalaupun begitu, risiko ini bisa dikurangi dengan perencanaan kehamilan yang baik, rutin kontrol ke fasilitas kesehatan, '
            'makan bergizi, istirahat cukup, dan menjaga gaya hidup sehat. Dengan pengawasan medis yang tepat, '
            'hamil setelah usia 35 tahun tetap bisa berlangsung dengan aman bagi bunda maupun bayi.',
      },
    ],
  };

  // ===== DATA ENGLISH (lengkap) =====
  late final Map<String, List<Map<String, String>>> _categorizedQuestionsEn = {
    'Calculation & Planning': [
      {
        'title': 'How is the due date (EDD) calculated?',
        'desc':
        'The estimated due date (EDD) is often calculated assuming a regular 28-day cycle by counting 40 weeks (280 days) from the first day of the last menstrual period (LMP). '
            'However, every pregnancy is different and the due date is only an estimate—especially if your menstrual cycle is irregular.',
      },
      {
        'title': 'When should I take maternity leave?',
        'desc':
        'Maternity leave during pregnancy usually follows workplace policy and labor regulations. In Indonesia, maternity leave is commonly 3 months, often taken as 1.5 months before the estimated delivery date and 1.5 months after birth.'
            '\n\nThat said, the best time to start leave can vary. If the pregnancy is healthy and your healthcare provider says it is safe, you may continue working longer and start leave closer to the due date. '
            'On the other hand, if you have complaints or a high-risk pregnancy, you may need to start leave earlier based on medical advice.'
            '\n\nIn short, when to take maternity leave depends on your pregnancy condition and your workplace rules, but many people start around 1.5 months before delivery.',
      },
    ],
    'Health & Nutrition': [
      {
        'title': 'How much weight will I gain during pregnancy?',
        'desc':
        'Pregnancy weight gain depends on your nutritional status (BMI) before pregnancy. Generally, a person with a normal pre-pregnancy weight is recommended to gain about 11.5–16 kg in total. '
            'In the first trimester, weight gain is often only 0.5–2 kg. In the second and third trimesters, weight gain tends to be faster—about 0.4–0.5 kg per week.'
            '\n\nIf you were underweight before pregnancy, the recommended gain is higher; if you were overweight or obese, the recommended gain is lower. '
            'Appropriate weight gain supports both maternal health and fetal growth.',
      },
      {
        'title': 'What nutrients are important during pregnancy?',
        'desc':
        'Important pregnancy nutrients include folic acid for the baby’s neural development, iron to prevent anemia, calcium for bones and teeth, protein for fetal cell growth, and DHA for brain and eye development. '
            'Try to eat a balanced diet and follow your doctor’s advice regarding any needed supplements.',
      },
      {
        'title': 'Is it safe to take hot baths or use a sauna?',
        'desc':
        'Very hot baths and saunas are best avoided during pregnancy. A significant rise in body temperature may not be good for the baby, especially early in pregnancy. '
            'Warm baths for relaxation are usually fine, but avoid water that is so hot it causes dizziness, heavy sweating, or discomfort.'
            '\n\nSaunas are not recommended because they can cause overheating, dehydration, and low blood pressure. For safer relaxation, use comfortably warm (lukewarm) water.',
      },
      {
        'title': 'Is it safe to go to the dentist while pregnant?',
        'desc':
        'Dental care during pregnancy is generally safe and is actually recommended to maintain oral health. Routine check-ups, cleanings, and fillings can usually be done. '
            'Tell your dentist that you are pregnant so medications and procedures can be adjusted appropriately.'
            '\n\nThis is important because gum or tooth infections can affect both your health and your pregnancy.',
      },
    ],
    'Symptoms & Body Changes': [
      {
        'title': 'How can I know if I am pregnant?',
        'desc':
        'Presumptive (not certain) signs: a missed period, nausea/vomiting, tender or enlarged breasts, frequent urination, fatigue, dizziness/sleepiness, and appetite changes. These signs are not definite because they can be caused by other factors.'
            '\n\nProbable signs: an enlarged uterus, cervical changes, and a positive pregnancy test. These strongly suggest pregnancy but are still not 100% certain.'
            '\n\nPositive (certain) signs: the fetus is seen on ultrasound, fetal heartbeat is heard, or fetal parts are felt/identified by a clinician. These confirm pregnancy.',
      },
      {
        'title': 'Spotting during pregnancy—should I worry?',
        'desc':
        'Spotting can happen during pregnancy and is not always dangerous. In early pregnancy, light spotting may be normal (for example, implantation). '
            'However, you should still be cautious.'
            '\n\nSeek medical care promptly if you have bright red bleeding, heavy bleeding, strong or persistent abdominal pain, dizziness, passing blood clots, or any other concerning symptoms. '
            'These can be signs of a pregnancy complication. Don’t panic, but monitor the amount, color, and accompanying symptoms—and get checked to make sure you and the baby are safe.',
      },
      {
        'title': 'When do cravings start and end?',
        'desc':
        'Cravings often begin in the first trimester, around 4–8 weeks of pregnancy. During this time, you may strongly want certain foods or suddenly dislike foods you previously enjoyed.'
            '\n\nCravings often decrease or disappear in the second trimester, around 14–16 weeks. However, for some people, cravings can continue until late pregnancy, though usually not as intense as in the beginning.'
            '\n\nCravings are normal. The key is to keep your diet balanced and avoid overeating.',
      },
      {
        'title': 'When will I start feeling the baby move?',
        'desc':
        'Most people feel the first fetal movements around 18–20 weeks of pregnancy. If you have been pregnant before, you may feel movement earlier—around 16 weeks.'
            '\n\nAt first, movements can feel subtle, like bubbles or small flutters, and become stronger as pregnancy progresses. '
            'If you have not felt any movement by 24 weeks, it is best to consult a healthcare facility for evaluation.',
      },
    ],
    'Activities & Lifestyle': [
      {
        'title': 'What exercises are safe during pregnancy?',
        'desc':
        'Safe exercises during pregnancy often include walking, swimming, prenatal yoga, and pregnancy exercise classes. Avoid activities with a high risk of falls or abdominal impact.'
            '\n\nAlways consult your doctor before starting a new exercise program—especially if you have medical conditions or a high-risk pregnancy. Listen to your body and stop if you feel pain, dizziness, or severe fatigue.',
      },
      {
        'title': 'Is air travel safe during pregnancy?',
        'desc':
        'Air travel is generally safe if the pregnancy is healthy and there are no complications. Airlines often allow travel up to around 36 weeks of pregnancy, but after 28 weeks they may require a doctor’s note.'
            '\n\nWhen traveling, drink plenty of water, move or stretch periodically to keep blood flow healthy, and choose a comfortable seat. '
            'If you have symptoms or a high-risk pregnancy, consult your healthcare provider before flying.',
      },
    ],
    'Health & Complications': [
      {
        'title': 'When should I contact a doctor during pregnancy?',
        'desc':
        'Contact a doctor immediately if you experience: vaginal bleeding, severe or persistent abdominal pain, a severe headache that does not improve, blurred vision, sudden swelling in the hands or face, high fever, persistent vomiting, or a noticeable decrease in fetal movement—especially after 28 weeks.',
      },
      {
        'title': 'What should I do if the baby is breech?',
        'desc':
        'A breech position means the baby’s head is up instead of down. This is fairly common earlier in pregnancy and the baby may still turn on their own.'
            '\n\nIf the baby remains breech close to delivery, you should have regular check-ups with an obstetrician. Your healthcare provider will monitor the baby’s position, may suggest specific exercises or positioning techniques, and will decide the safest delivery method.'
            '\n\nTry not to panic—focus on staying healthy and follow your scheduled prenatal care.',
      },
      {
        'title': 'Is pregnancy after age 35 safe?',
        'desc':
        'Pregnancy after age 35 can still be safe, and many people have healthy pregnancies and normal deliveries at this age. '
            'However, some risks can be slightly higher compared to younger pregnancies—such as high blood pressure, gestational diabetes, miscarriage, or chromosomal abnormalities. The likelihood of a C-section may also be higher.'
            '\n\nEven so, risks can be reduced with good preconception planning, regular prenatal check-ups, nutritious food, adequate rest, and a healthy lifestyle. With proper medical monitoring, pregnancy after 35 can still be safe for both mother and baby.',
      },
    ],
  };

  Map<String, List<Map<String, String>>> get _categorizedQuestions {
    final isEn = context.read<LocaleCubit>().state.languageCode == 'en';
    return isEn ? _categorizedQuestionsEn : _categorizedQuestionsId;
  }

  final Map<String, bool> _categoryExpansionState = {};

  void _ensureExpansionKeys(Map<String, List<Map<String, String>>> data) {
    // tambahkan key yang belum ada, jangan reset agar user state tidak hilang saat switch
    for (final k in data.keys) {
      _categoryExpansionState.putIfAbsent(k, () => true);
    }
    // bersihkan key lama yang tidak dipakai di locale sekarang
    final keysToRemove = _categoryExpansionState.keys
        .where((k) => !data.keys.contains(k))
        .toList();
    for (final k in keysToRemove) {
      _categoryExpansionState.remove(k);
    }
  }

  List<Map<String, String>> _filterQuestions(List<Map<String, String>> questions) {
    if (_searchQuery.isEmpty) return questions;

    final q = _searchQuery.toLowerCase();
    return questions.where((question) {
      return question['title']!.toLowerCase().contains(q) ||
          question['desc']!.toLowerCase().contains(q);
    }).toList();
  }

  List<Map<String, String>> _getAllQuestions(
      Map<String, List<Map<String, String>>> data,
      ) {
    final all = <Map<String, String>>[];
    data.forEach((_, value) => all.addAll(value));
    return _filterQuestions(all);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isEn = locale.languageCode == 'en';
        final data = _categorizedQuestions;
        _ensureExpansionKeys(data);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              isEn ? "Pregnancy FAQs" : "Pertanyaan Umum Kehamilan",
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
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                    decoration: InputDecoration(
                      hintText: isEn ? 'Search questions...' : 'Cari pertanyaan...',
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
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
                      // Mode Search
                      if (_searchQuery.isNotEmpty)
                        _getAllQuestions(data).isNotEmpty
                            ? Column(
                          children: _getAllQuestions(data)
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
                            : Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Text(
                            isEn
                                ? "No questions found.\nTry another keyword."
                                : "Tidak ditemukan pertanyaan.\nCoba dengan keyword lain.",
                            textAlign: TextAlign.center,
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      else
                      // Mode Normal (Kategori)
                        Column(
                          children: data.entries.map((entry) {
                            final category = entry.key;
                            final questions = _filterQuestions(entry.value);

                            if (questions.isEmpty) return const SizedBox.shrink();

                            return Column(
                              children: [
                                // Header Kategori
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
                                      color: kPrimaryColor.withValues(alpha: 0.1),
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
      },
    );
  }
}
