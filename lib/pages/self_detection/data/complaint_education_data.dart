// Data edukasi untuk setiap keluhan kehamilan
class ComplaintEducation {
  final String title;
  final String theory;
  final String normalCondition;
  final String risk;
  final String tips;
  final String warning;

  ComplaintEducation({
    required this.title,
    required this.theory,
    required this.normalCondition,
    required this.risk,
    required this.tips,
    required this.warning,
  });
}

class ComplaintEducationData {
  static final Map<String, ComplaintEducation> data = {
    "Mual dan Muntah": ComplaintEducation(
      title: "Mual dan Muntah",
      theory: "Disebabkan oleh hormon hCG dan progesteron yang meningkat di trimester awal, memengaruhi pusat muntah di otak.",
      normalCondition: "Terjadi pada 60–80% ibu hamil, biasanya membaik setelah usia 12–16 minggu.",
      risk: "Hiperemesis gravidarum → dehidrasi, gangguan elektrolit, berat badan turun.",
      tips: "Makan porsi kecil tapi sering, konsumsi makanan kering (roti, biskuit), minum sedikit-sedikit tapi sering, hindari bau menyengat.",
      warning: "Muntah terus-menerus, tidak bisa makan/minum, badan lemah → segera ke RS.",
    ),
    "Kembung": ComplaintEducation(
      title: "Kembung",
      theory: "Hormon progesteron memperlambat gerakan usus, rahim menekan lambung.",
      normalCondition: "Wajar terjadi sepanjang kehamilan.",
      risk: "Jika disertai nyeri perut hebat atau muntah → bisa tanda sumbatan usus.",
      tips: "Kurangi minuman bersoda, perbanyak serat & air putih, makan perlahan.",
      warning: "Kembung + nyeri hebat → perlu pemeriksaan.",
    ),
    "Maag / Nyeri Ulu Hati": ComplaintEducation(
      title: "Maag / Nyeri Ulu Hati",
      theory: "Sfingter lambung melemah akibat hormon, ditambah rahim menekan lambung → asam naik ke kerongkongan.",
      normalCondition: "Sering terjadi trimester 2–3.",
      risk: "Heartburn berat dapat memengaruhi pola makan ibu → berdampak pada nutrisi janin.",
      tips: "Hindari makan pedas, asam, berlemak. Tidur miring kiri dengan bantal tinggi.",
      warning: "Nyeri sangat hebat atau muntah darah → segera periksa.",
    ),
    "Sakit Kepala": ComplaintEducation(
      title: "Sakit Kepala",
      theory: "Perubahan hormon, kurang tidur, anemia, atau tekanan darah.",
      normalCondition: "Ringan, hilang dengan istirahat.",
      risk: "Sakit kepala hebat + pandangan kabur + bengkak → tanda preeklamsia.",
      tips: "Minum cukup air, istirahat, hindari stres.",
      warning: "Jika berat/menetap dengan gejala lain → segera periksa.",
    ),
    "Kram Perut": ComplaintEducation(
      title: "Kram Perut",
      theory: "Peregangan ligamen karena rahim membesar, atau kurang cairan/elektrolit.",
      normalCondition: "Ringan dan hilang dengan istirahat.",
      risk: "Jika kuat/sering → tanda keguguran atau kontraksi prematur.",
      tips: "Minum cukup air, peregangan, istirahat.",
      warning: "Kram disertai pendarahan → segera periksa.",
    ),
    "Keputihan": ComplaintEducation(
      title: "Keputihan",
      theory: "Hormon estrogen meningkatkan produksi cairan vagina.",
      normalCondition: "Putih susu, tidak bau, tidak gatal.",
      risk: "Jika kuning/hijau, bau, gatal → infeksi, bisa picu persalinan prematur.",
      tips: "Gunakan celana katun, jaga kebersihan, ganti celana dalam bila lembap.",
      warning: "Cairan deras, encer seperti air → tanda ketuban pecah dini.",
    ),
    "Pendarahan / Bercak": ComplaintEducation(
      title: "Pendarahan / Bercak",
      theory: "Bisa implantasi janin, atau tanda keguguran/plasenta bermasalah.",
      normalCondition: "Bercak ringan di awal kehamilan.",
      risk: "Pendarahan banyak → keguguran, plasenta previa, solusio plasenta.",
      tips: "Catat jumlah dan warna darah.",
      warning: "Darah banyak + nyeri → segera ke RS.",
    ),
    "Bengkak": ComplaintEducation(
      title: "Bengkak pada Kaki/Tangan/Wajah",
      theory: "Retensi cairan akibat hormon, rahim menekan pembuluh balik.",
      normalCondition: "Bengkak ringan di kaki sore hari.",
      risk: "Bengkak mendadak + hipertensi (tekanan darah tinggi) → preeklamsia.",
      tips: "Istirahat dengan kaki tinggi, minum cukup, kurangi garam.",
      warning: "Bengkak wajah/tangan + sakit kepala → tanda bahaya.",
    ),
    "Ngidam": ComplaintEducation(
      title: "Ngidam",
      theory: "Perubahan hormon, psikologis, atau kebutuhan nutrisi.",
      normalCondition: "Wajar selama makanan sehat.",
      risk: "Ngidam benda aneh (pica) → berbahaya.",
      tips: "Penuhi ngidam dengan makanan sehat.",
      warning: "Jika konsumsi benda berbahaya → segera konsultasi.",
    ),
    "Sembelit": ComplaintEducation(
      title: "Sembelit",
      theory: "Progesteron memperlambat usus, rahim menekan usus, kurang serat.",
      normalCondition: "Wajar pada kehamilan.",
      risk: "Bisa sebabkan hemoroid.",
      tips: "Makan serat, minum cukup, olahraga ringan.",
      warning: "BAB berdarah atau sangat sulit → periksa medis.",
    ),
    "Kelelahan": ComplaintEducation(
      title: "Kelelahan Berlebihan",
      theory: "Metabolisme meningkat, jantung bekerja lebih keras, anemia sering terjadi.",
      normalCondition: "Umum di trimester awal.",
      risk: "Anemia berat → ganggu perkembangan janin.",
      tips: "Istirahat, makan bergizi, cek Hb bila lemas sekali.",
      warning: "Jika sangat lemah, tidak mampu beraktivitas → periksa medis.",
    ),
    "Ngantuk dan Pusing": ComplaintEducation(
      title: "Ngantuk dan Pusing",
      theory: "Akibat hormon dan perubahan tekanan darah.",
      normalCondition: "Ringan, sesekali.",
      risk: "Pusing berulang → anemia atau tekanan darah tinggi/rendah.",
      tips: "Tidur cukup, bangun perlahan.",
      warning: "Pusing berat, sering jatuh, pandangan kabur → segera periksa.",
    ),
    "Perubahan Mood": ComplaintEducation(
      title: "Perubahan Mood",
      theory: "Hormon memengaruhi otak, ditambah kecemasan.",
      normalCondition: "Naik-turun emosi wajar.",
      risk: "Depresi kehamilan → berdampak pada janin.",
      tips: "Dukungan keluarga, relaksasi, ibadah.",
      warning: "Ibu ingin menyakiti diri sendiri → segera cari pertolongan.",
    ),
    "Masalah Tidur": ComplaintEducation(
      title: "Masalah Tidur",
      theory: "Rahim besar, sering BAK, cemas.",
      normalCondition: "Susah tidur wajar.",
      risk: "Kurang tidur → mudah lelah, depresi.",
      tips: "Tidur miring kiri, gunakan bantal tambahan.",
      warning: "Jika insomnia berat dan mengganggu kesehatan → konsultasi.",
    ),
    "Hilang Nafsu Makan": ComplaintEducation(
      title: "Hilang Nafsu Makan",
      theory: "Mual, hormon, atau psikologis.",
      normalCondition: "Trimester awal.",
      risk: "Berat badan tidak naik → janin bisa BBLR.",
      tips: "Makan porsi kecil sering, pilih makanan bergizi.",
      warning: "Tidak bisa makan sama sekali → segera periksa.",
    ),
    "Detak Jantung Cepat": ComplaintEducation(
      title: "Detak Jantung Cepat",
      theory: "Volume darah naik 40–50% → jantung lebih cepat.",
      normalCondition: "Ringan, tanpa gejala lain.",
      risk: "Palpitasi berat bisa tanda anemia/penyakit jantung.",
      tips: "Istirahat, kurangi kafein.",
      warning: "Jika disertai sesak/nyeri dada → segera ke RS.",
    ),
    "Nyeri Pinggang": ComplaintEducation(
      title: "Nyeri Pinggang / Punggung",
      theory: "Perubahan postur, hormon relaksin membuat sendi lebih longgar.",
      normalCondition: "Ringan, membaik dengan istirahat.",
      risk: "Nyeri berat bisa tanda masalah ginjal/saraf.",
      tips: "Gunakan alas kaki nyaman, olahraga hamil.",
      warning: "Nyeri menetap/berat → periksa medis.",
    ),
    "Sesak Napas": ComplaintEducation(
      title: "Sesak Napas",
      theory: "Rahim besar menekan diafragma, oksigen lebih banyak dibutuhkan.",
      normalCondition: "Ringan, hilang dengan istirahat.",
      risk: "Sesak mendadak bisa tanda asma, emboli paru, preeklamsia.",
      tips: "Duduk tegak, tarik napas dalam.",
      warning: "Sesak berat mendadak → segera ke RS.",
    ),
    "Pandangan Kabur": ComplaintEducation(
      title: "Pandangan Kabur / Berkunang-kunang",
      theory: "Bisa karena tekanan darah rendah/tinggi.",
      normalCondition: "Kadang-kadang, ringan.",
      risk: "Tanda khas preeklamsia.",
      tips: "Segera cek tekanan darah.",
      warning: "Disertai sakit kepala berat & bengkak → darurat medis.",
    ),
    "Kontraksi Dini": ComplaintEducation(
      title: "Kontraksi Dini",
      theory: "Bisa berupa Braxton Hicks (latihan kontraksi).",
      normalCondition: "Jarang, tidak teratur, hilang dengan istirahat.",
      risk: "Kontraksi teratur + nyeri + darah/lendir → persalinan prematur.",
      tips: "Minum cukup air, istirahat.",
      warning: "Jika kontraksi makin sering/kuat → segera ke RS.",
    ),
    // Di ComplaintEducationData - perbaiki data gerakan janin
    "Gerakan Janin": ComplaintEducation(
      title: "Gerakan Janin",
      theory: "Gerakan janin merupakan tanda vitalitas janin, mulai dapat dirasakan ibu pada usia kehamilan sekitar 18–20 minggu. Dipengaruhi oleh aktivitas janin, volume cairan ketuban, dan sensitivitas ibu.",
      normalCondition: "Gerakan terasa setiap hari, rata-rata minimal 5 gerakan per jam atau 10 gerakan dalam 2 jam setelah usia kehamilan 28 minggu.",
      risk: "Gerakan janin berkurang atau tidak terasa bisa menandakan hipoksia janin, gangguan pertumbuhan intrauterin, atau gawat janin.",
      tips: "Lakukan pencatatan gerakan janin secara rutin, pilih waktu saat janin biasanya aktif (misalnya setelah makan). Gunakan sistem hitung yang dinamis berdasarkan durasi pencatatan.",
      warning: "Bila gerakan janin kurang dari 3 gerakan per jam atau terjadi penurunan drastis aktivitas janin → segera periksa ke tenaga kesehatan.",
    ),
  };

  static ComplaintEducation? getEducation(String complaintName) {
    return data[complaintName];
  }
}
