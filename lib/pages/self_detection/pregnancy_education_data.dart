// Data edukasi lengkap untuk setiap keluhan kehamilan
class PregnancyComplaintEducation {
  final String title;
  final String theory;
  final String normalCondition;
  final String risk;
  final String tips;
  final String warning;

  PregnancyComplaintEducation({
    required this.title,
    required this.theory,
    required this.normalCondition,
    required this.risk,
    required this.tips,
    required this.warning,
  });
}

class PregnancyEducationData {
  static final Map<String, PregnancyComplaintEducation> complaintEducation = {
    "Mual dan muntah": PregnancyComplaintEducation(
      title: "Mual dan Muntah",
      theory: "Disebabkan oleh hormon hCG dan progesteron yang meningkat di trimester awal, memengaruhi pusat muntah di otak.",
      normalCondition: "Terjadi pada 60–80% ibu hamil, biasanya membaik setelah usia 12–16 minggu.",
      risk: "Bila muntah berlebihan (hiperemesis gravidarum), bisa menyebabkan dehidrasi, gangguan elektrolit, berat badan turun.",
      tips: "Makan porsi kecil tapi sering, konsumsi makanan kering (roti, biskuit), minum air sedikit-sedikit tapi sering, hindari makanan berbau menyengat.",
      warning: "Muntah terus-menerus, tidak bisa makan/minum, badan lemah → segera ke RS.",
    ),
    "Kembung": PregnancyComplaintEducation(
      title: "Kembung",
      theory: "Hormon progesteron memperlambat gerakan usus, sehingga gas menumpuk. Rahim yang membesar juga menekan lambung.",
      normalCondition: "Wajar terjadi sepanjang kehamilan.",
      risk: "Jika kembung disertai nyeri perut hebat atau muntah, bisa tanda sumbatan usus.",
      tips: "Kurangi minuman bersoda, perbanyak serat dan air putih, makan perlahan.",
      warning: "Kembung disertai nyeri hebat → perlu pemeriksaan.",
    ),
    "Maag / nyeri ulu hati": PregnancyComplaintEducation(
      title: "Maag / Nyeri Ulu Hati",
      theory: "Sfingter lambung melemah akibat hormon, ditambah rahim menekan lambung → asam naik ke kerongkongan.",
      normalCondition: "Sering terjadi trimester 2–3.",
      risk: "Heartburn berat dapat memengaruhi pola makan ibu → berdampak pada nutrisi janin.",
      tips: "Hindari makan pedas, asam, berlemak. Tidur miring kiri dengan bantal tinggi.",
      warning: "Jika nyeri sangat hebat atau disertai muntah darah → perlu pemeriksaan medis.",
    ),
    "Sakit kepala": PregnancyComplaintEducation(
      title: "Sakit Kepala",
      theory: "Bisa akibat perubahan hormon estrogen & progesteron, kurang tidur, anemia, atau tekanan darah.",
      normalCondition: "Ringan, hilang dengan istirahat.",
      risk: "Sakit kepala hebat + pandangan kabur + bengkak → tanda preeklamsia.",
      tips: "Minum cukup air, istirahat, hindari stres.",
      warning: "Jika sakit kepala berat, menetap, disertai gejala lain → segera periksa.",
    ),
    "Kram perut": PregnancyComplaintEducation(
      title: "Kram Perut",
      theory: "Peregangan ligamen karena rahim membesar, atau kurang cairan/elektrolit.",
      normalCondition: "Ringan dan hilang dengan istirahat.",
      risk: "Jika kuat dan sering, bisa tanda keguguran atau kontraksi prematur.",
      tips: "Minum air cukup, lakukan peregangan, istirahat.",
      warning: "Kram disertai pendarahan → segera periksa.",
    ),
    "Keputihan": PregnancyComplaintEducation(
      title: "Keputihan",
      theory: "Hormon estrogen meningkatkan produksi cairan vagina.",
      normalCondition: "Putih susu, tidak bau, tidak gatal.",
      risk: "Jika kuning/hijau, bau, gatal → infeksi (jamur, bakteri, PMS). Infeksi bisa memicu persalinan prematur.",
      tips: "Gunakan celana katun, jaga kebersihan, ganti celana dalam bila lembap.",
      warning: "Cairan keluar deras, encer seperti air → bisa tanda ketuban pecah dini.",
    ),
    "Ngidam": PregnancyComplaintEducation(
      title: "Ngidam",
      theory: "Perubahan hormon, psikologis, atau kebutuhan nutrisi tertentu.",
      normalCondition: "Selama makanan sehat.",
      risk: "Ngidam benda aneh (pica) → berbahaya (tanah, kapur).",
      tips: "Penuhi ngidam dengan makanan sehat.",
      warning: "Ngidam benda non-makanan → konsultasi dengan dokter.",
    ),
    "Pendarahan / bercak dari jalan lahir": PregnancyComplaintEducation(
      title: "Pendarahan / Bercak",
      theory: "Bisa karena implantasi janin, tapi juga bisa tanda keguguran atau plasenta bermasalah.",
      normalCondition: "Bercak ringan di awal kehamilan.",
      risk: "Pendarahan banyak → keguguran, plasenta previa, solusio plasenta.",
      tips: "Catat jumlah dan warna darah.",
      warning: "Jika darah banyak, merah segar, dengan nyeri perut → segera ke RS.",
    ),
    "Bengkak pada kaki / tangan / wajah": PregnancyComplaintEducation(
      title: "Bengkak",
      theory: "Retensi cairan akibat hormon, rahim menekan pembuluh darah balik.",
      normalCondition: "Bengkak ringan di kaki sore hari.",
      risk: "Bengkak mendadak + hipertensi → preeklamsia.",
      tips: "Istirahat dengan kaki lebih tinggi, minum cukup air, kurangi garam.",
      warning: "Bengkak di wajah/tangan + sakit kepala → tanda bahaya.",
    ),
    "Sembelit": PregnancyComplaintEducation(
      title: "Sembelit",
      theory: "Progesteron memperlambat usus, rahim menekan usus, dan kurang serat.",
      normalCondition: "Wajar pada kehamilan.",
      risk: "Bisa menyebabkan hemoroid (ambeien).",
      tips: "Konsumsi serat, cukup minum, olahraga ringan.",
      warning: "BAB berdarah atau sangat sulit → perlu pemeriksaan.",
    ),
    "Kelelahan berlebihan": PregnancyComplaintEducation(
      title: "Kelelahan Berlebihan",
      theory: "Metabolisme meningkat, jantung bekerja lebih keras, anemia sering terjadi.",
      normalCondition: "Umum di trimester awal.",
      risk: "Anemia berat → mengganggu perkembangan janin.",
      tips: "Istirahat, makan bergizi, periksa Hb jika lemas sekali.",
      warning: "Lemas sangat berat hingga tidak bisa beraktivitas → periksa ke dokter.",
    ),
    "Ngantuk dan pusing": PregnancyComplaintEducation(
      title: "Ngantuk dan Pusing",
      theory: "Akibat hormon dan perubahan tekanan darah.",
      normalCondition: "Sesekali, ringan.",
      risk: "Pusing berulang → anemia, tekanan darah tinggi/rendah.",
      tips: "Tidur cukup, bangun perlahan.",
      warning: "Pusing berat, sering jatuh, pandangan kabur → segera periksa.",
    ),
    "Perubahan mood": PregnancyComplaintEducation(
      title: "Perubahan Mood",
      theory: "Hormon memengaruhi otak, ditambah kecemasan menghadapi kehamilan.",
      normalCondition: "Naik-turun emosi.",
      risk: "Depresi kehamilan → berdampak pada janin.",
      tips: "Dukungan keluarga, relaksasi, ibadah.",
      warning: "Ibu merasa ingin menyakiti diri sendiri → segera cari pertolongan.",
    ),
    "Masalah tidur": PregnancyComplaintEducation(
      title: "Masalah Tidur",
      theory: "Posisi rahim besar, sering BAK, cemas.",
      normalCondition: "Susah tidur wajar.",
      risk: "Kurang tidur → mudah lelah, depresi.",
      tips: "Tidur miring kiri, gunakan bantal tambahan.",
      warning: "Insomnia berat hingga mengganggu aktivitas → konsultasi dokter.",
    ),
    "Hilang nafsu makan": PregnancyComplaintEducation(
      title: "Hilang Nafsu Makan",
      theory: "Mual, hormon, atau psikologis.",
      normalCondition: "Trimester awal.",
      risk: "Berat badan tidak naik → janin bisa BBLR.",
      tips: "Makan porsi kecil sering, makanan bergizi.",
      warning: "Tidak bisa makan sama sekali → segera periksa.",
    ),
    "Detak jantung cepat": PregnancyComplaintEducation(
      title: "Detak Jantung Cepat",
      theory: "Volume darah meningkat 40–50% → jantung bekerja lebih cepat.",
      normalCondition: "Ringan, tidak disertai gejala lain.",
      risk: "Palpitasi berat bisa tanda anemia, penyakit jantung.",
      tips: "Istirahat, kurangi kafein.",
      warning: "Disertai sesak atau nyeri dada → segera ke RS.",
    ),
    "Nyeri pinggang / punggung": PregnancyComplaintEducation(
      title: "Nyeri Pinggang / Punggung",
      theory: "Perubahan postur, hormon relaksin membuat sendi lebih longgar.",
      normalCondition: "Ringan, membaik dengan istirahat.",
      risk: "Nyeri berat bisa tanda masalah ginjal atau saraf.",
      tips: "Gunakan alas kaki nyeman, olahraga hamil.",
      warning: "Nyeri hebat disertai demam atau BAK sakit → periksa ke dokter.",
    ),
    "Sesak napas": PregnancyComplaintEducation(
      title: "Sesak Napas",
      theory: "Rahim besar menekan diafragma, oksigen juga dibutuhkan lebih banyak.",
      normalCondition: "Ringan, hilang dengan istirahat.",
      risk: "Sesak mendadak bisa tanda asma, emboli paru, preeklamsia.",
      tips: "Duduk tegak, tarik napas dalam.",
      warning: "Sesak berat hingga tidak bisa bicara → darurat medis.",
    ),
    "Pandangan kabur / berkunang-kunang": PregnancyComplaintEducation(
      title: "Pandangan Kabur",
      theory: "Bisa karena tekanan darah rendah atau tinggi.",
      normalCondition: "Sesekali karena perubahan posisi.",
      risk: "Tanda khas preeklamsia.",
      tips: "Bangun perlahan, duduk jika pusing.",
      warning: "Jika disertai sakit kepala berat & bengkak → darurat medis.",
    ),
    "Kontraksi dini (perut sering kencang sebelum waktunya)": PregnancyComplaintEducation(
      title: "Kontraksi Dini",
      theory: "Bisa berupa Braxton Hicks (latihan kontraksi).",
      normalCondition: "Jarang, tidak teratur, hilang dengan istirahat.",
      risk: "Kontraksi teratur + nyeri + keluar darah/lendir → persalinan prematur.",
      tips: "Minum cukup air, istirahat.",
      warning: "Bila kontraksi makin sering/kuat → segera ke RS.",
    ),
  };

  // Edukasi berdasarkan hasil deteksi risiko
  static Map<String, Map<String, String>> riskLevelEducation = {
    "Kehamilan Normal": {
      "title": "Selamat! Kehamilan Anda Normal",
      "description": "Kondisi kehamilan Anda terdeteksi normal. Tetap jaga kesehatan dengan pola makan bergizi dan istirahat yang cukup.",
      "recommendations": """
• Lakukan kontrol rutin ke tenaga kesehatan
• Konsumsi makanan bergizi seimbang
• Minum vitamin kehamilan secara teratur
• Lakukan olahraga ringan yang aman untuk ibu hamil
• Hindari rokok, alkohol, dan obat-obatan terlarang
• Istirahat yang cukup (7-8 jam per hari)
• Kelola stres dengan baik
"""
    },
    "Perlu Perhatian": {
      "title": "Perlu Perhatian Khusus",
      "description": "Terdapat beberapa faktor yang perlu mendapatkan perhatian lebih. Disarankan untuk melakukan pemeriksaan lebih lanjut.",
      "recommendations": """
• Segera konsultasi dengan bidan atau dokter kandungan
• Lakukan pemeriksaan penunjang yang disarankan
• Pantau kondisi secara berkala
• Terapkan pola hidup sehat dengan disiplin
• Hindari aktivitas berat yang dapat memperburuk kondisi
• Catat keluhan yang muncul untuk dilaporkan ke tenaga kesehatan
"""
    },
    "Risiko Tinggi": {
      "title": "Risiko Tinggi - Perhatian Khusus!",
      "description": "Terdeteksi adanya tanda bahaya yang memerlukan penanganan medis segera. Jangan tunda untuk berkonsultasi dengan tenaga kesehatan.",
      "recommendations": """
• SEGERA periksakan diri ke rumah sakit atau fasilitas kesehatan
• Jangan menunda pengobatan atau pemeriksaan
• Ikuti semua instruksi dari tenaga medis
• Siapkan rencana persalinan dengan tim medis
• Lakukan pemantauan ketat terhadap kondisi
• Hindari aktivitas fisik berat
• Segera ke IGD jika mengalami kondisi darurat
"""
    }
  };

  // Tips umum untuk ibu hamil
  static List<String> generalPregnancyTips = [
    "Konsumsi makanan bergizi dengan gizi seimbang",
    "Minum air putih minimal 8-10 gelas per hari",
    "Istirahat yang cukup dan hindari kelelahan",
    "Lakukan olahraga ringan seperti jalan pagi atau senam hamil",
    "Hindari rokok, alkohol, dan obat-obatan terlarang",
    "Kontrol rutin ke bidan atau dokter kandungan",
    "Minum vitamin dan suplemen yang diresepkan dokter",
    "Kelola stres dengan teknik relaksasi",
    "Persiapkan mental dan fisik untuk persalinan",
    "Ikuti kelas prenatal untuk edukasi kehamilan dan persalinan"
  ];
}