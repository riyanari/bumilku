// Data edukasi untuk setiap keluhan kehamilan
import '../../../l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

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

enum ComplaintKey {
  nauseaVomiting,
  bloating,
  heartburn,
  headache,
  abdominalCramp,
  vaginalDischarge,
  bleedingSpotting,
  swelling,
  cravings,
  constipation,
  excessiveFatigue,
  sleepyDizzy,
  moodChanges,
  sleepProblems,
  lossOfAppetite,
  fastHeartbeat,
  backPain,
  shortnessOfBreath,
  blurredVision,
  earlyContractions,
  fetalMovement,
  sti,
}


class ComplaintEducationData {
  // =========================
  // ID DATA (as-is dari kamu)
  // =========================
  static final Map<ComplaintKey, ComplaintEducation> _id = {
    ComplaintKey.nauseaVomiting: ComplaintEducation(
      title: "Mual dan Muntah",
      theory:
      "Disebabkan oleh hormon hCG dan progesteron yang meningkat di trimester awal, memengaruhi pusat muntah di otak.",
      normalCondition:
      "Terjadi pada 60–80% ibu hamil, biasanya membaik setelah usia 12–16 minggu.",
      risk: "Hiperemesis gravidarum → dehidrasi, gangguan elektrolit, berat badan turun.",
      tips:
      "Makan porsi kecil tapi sering, konsumsi makanan kering (roti, biskuit), minum sedikit-sedikit tapi sering, hindari bau menyengat.",
      warning:
      "Muntah terus-menerus, tidak bisa makan/minum, badan lemah → segera ke RS.",
    ),

    ComplaintKey.bloating: ComplaintEducation(
      title: "Kembung",
      theory: "Hormon progesteron memperlambat gerakan usus, rahim menekan lambung.",
      normalCondition: "Wajar terjadi sepanjang kehamilan.",
      risk: "Jika disertai nyeri perut hebat atau muntah → bisa tanda sumbatan usus.",
      tips: "Kurangi minuman bersoda, perbanyak serat & air putih, makan perlahan.",
      warning: "Kembung + nyeri hebat → perlu pemeriksaan.",
    ),

    ComplaintKey.heartburn: ComplaintEducation(
      title: "Maag / Nyeri Ulu Hati",
      theory:
      "Sfingter lambung melemah akibat hormon, ditambah rahim menekan lambung → asam naik ke kerongkongan.",
      normalCondition: "Sering terjadi trimester 2–3.",
      risk:
      "Heartburn berat dapat memengaruhi pola makan ibu → berdampak pada nutrisi janin.",
      tips: "Hindari makan pedas, asam, berlemak. Tidur miring kiri dengan bantal tinggi.",
      warning: "Nyeri sangat hebat atau muntah darah → segera periksa.",
    ),

    ComplaintKey.headache: ComplaintEducation(
      title: "Sakit Kepala",
      theory: "Perubahan hormon, kurang tidur, anemia, atau tekanan darah.",
      normalCondition: "Ringan, hilang dengan istirahat.",
      risk: "Sakit kepala hebat + pandangan kabur + bengkak → tanda preeklamsia.",
      tips: "Minum cukup air, istirahat, hindari stres.",
      warning: "Jika berat/menetap dengan gejala lain → segera periksa.",
    ),

    ComplaintKey.abdominalCramp: ComplaintEducation(
      title: "Kram Perut",
      theory: "Peregangan ligamen karena rahim membesar, atau kurang cairan/elektrolit.",
      normalCondition: "Ringan dan hilang dengan istirahat.",
      risk: "Jika kuat/sering → tanda keguguran atau kontraksi prematur.",
      tips: "Minum cukup air, peregangan, istirahat.",
      warning: "Kram disertai pendarahan → segera periksa.",
    ),

    ComplaintKey.vaginalDischarge: ComplaintEducation(
      title: "Keputihan",
      theory: "Hormon estrogen meningkatkan produksi cairan vagina.",
      normalCondition: "Putih susu, tidak bau, tidak gatal.",
      risk: "Jika kuning/hijau, bau, gatal → infeksi, bisa picu persalinan prematur.",
      tips:
      "Gunakan celana katun, jaga kebersihan, ganti celana dalam bila lembap.",
      warning: "Cairan deras, encer seperti air → tanda ketuban pecah dini.",
    ),

    ComplaintKey.bleedingSpotting: ComplaintEducation(
      title: "Pendarahan / Bercak",
      theory: "Bisa implantasi janin, atau tanda keguguran/plasenta bermasalah.",
      normalCondition: "Bercak ringan di awal kehamilan.",
      risk: "Pendarahan banyak → keguguran, plasenta previa, solusio plasenta.",
      tips: "Catat jumlah dan warna darah.",
      warning: "Darah banyak + nyeri → segera ke RS.",
    ),

    ComplaintKey.swelling: ComplaintEducation(
      title: "Bengkak pada Kaki/Tangan/Wajah",
      theory: "Retensi cairan akibat hormon, rahim menekan pembuluh balik.",
      normalCondition: "Bengkak ringan di kaki sore hari.",
      risk: "Bengkak mendadak + hipertensi (tekanan darah tinggi) → preeklamsia.",
      tips: "Istirahat dengan kaki tinggi, minum cukup, kurangi garam.",
      warning: "Bengkak wajah/tangan + sakit kepala → tanda bahaya.",
    ),

    ComplaintKey.sti: ComplaintEducation(
      title: "Infeksi Menular Seksual (IMS)",
      theory:
      "Infeksi Menular Seksual (IMS) adalah infeksi yang dapat menular melalui hubungan seksual. Pada masa kehamilan, IMS perlu mendapat perhatian karena dapat memengaruhi kesehatan ibu dan tumbuh kembang janin.",
      normalCondition:
      "Sebagian IMS tidak menimbulkan gejala, sehingga ibu hamil bisa merasa sehat meskipun sedang terinfeksi.",
      risk:
      "Jika tidak terdeteksi dan tidak diobati, IMS dapat meningkatkan risiko persalinan prematur, bayi lahir dengan berat badan rendah, serta penularan infeksi dari ibu ke bayi. IMS yang perlu diwaspadai antara lain sifilis, HIV, gonore, klamidia, hepatitis B, dan herpes genital.",
      tips:
      "Lakukan pencegahan dengan setia pada satu pasangan, menjaga kebersihan organ reproduksi, menggunakan kondom bila berisiko, serta memeriksakan diri bila muncul keluhan seperti keputihan tidak normal, nyeri saat buang air kecil, atau nyeri perut bawah. Ikuti pemeriksaan kehamilan rutin (ANC), termasuk skrining IMS sesuai anjuran tenaga kesehatan.",
      warning:
      "Jika memiliki keluhan atau kekhawatiran terkait IMS, segera konsultasikan dengan tenaga kesehatan. Bumilku hadir untuk membantu ibu hamil mendapatkan informasi yang tepat demi kehamilan yang sehat dan aman.",
    ),

    ComplaintKey.cravings: ComplaintEducation(
      title: "Ngidam",
      theory: "Perubahan hormon, psikologis, atau kebutuhan nutrisi.",
      normalCondition: "Wajar selama makanan sehat.",
      risk: "Ngidam benda aneh (pica) → berbahaya.",
      tips: "Penuhi ngidam dengan makanan sehat.",
      warning: "Jika konsumsi benda berbahaya → segera konsultasi.",
    ),

    ComplaintKey.constipation: ComplaintEducation(
      title: "Sembelit",
      theory: "Progesteron memperlambat usus, rahim menekan usus, kurang serat.",
      normalCondition: "Wajar pada kehamilan.",
      risk: "Bisa sebabkan hemoroid.",
      tips: "Makan serat, minum cukup, olahraga ringan.",
      warning: "BAB berdarah atau sangat sulit → periksa medis.",
    ),

    ComplaintKey.excessiveFatigue: ComplaintEducation(
      title: "Kelelahan Berlebihan",
      theory: "Metabolisme meningkat, jantung bekerja lebih keras, anemia sering terjadi.",
      normalCondition: "Umum di trimester awal.",
      risk: "Anemia berat → ganggu perkembangan janin.",
      tips: "Istirahat, makan bergizi, cek Hb bila lemas sekali.",
      warning: "Jika sangat lemah, tidak mampu beraktivitas → periksa medis.",
    ),

    ComplaintKey.sleepyDizzy: ComplaintEducation(
      title: "Ngantuk dan Pusing",
      theory: "Akibat hormon dan perubahan tekanan darah.",
      normalCondition: "Ringan, sesekali.",
      risk: "Pusing berulang → anemia atau tekanan darah tinggi/rendah.",
      tips: "Tidur cukup, bangun perlahan.",
      warning: "Pusing berat, sering jatuh, pandangan kabur → segera periksa.",
    ),

    ComplaintKey.moodChanges: ComplaintEducation(
      title: "Perubahan Mood",
      theory: "Hormon memengaruhi otak, ditambah kecemasan.",
      normalCondition: "Naik-turun emosi wajar.",
      risk: "Depresi kehamilan → berdampak pada janin.",
      tips: "Dukungan keluarga, relaksasi, ibadah.",
      warning: "Ibu ingin menyakiti diri sendiri → segera cari pertolongan.",
    ),

    ComplaintKey.sleepProblems: ComplaintEducation(
      title: "Masalah Tidur",
      theory: "Rahim besar, sering BAK, cemas.",
      normalCondition: "Susah tidur wajar.",
      risk: "Kurang tidur → mudah lelah, depresi.",
      tips: "Tidur miring kiri, gunakan bantal tambahan.",
      warning: "Jika insomnia berat dan mengganggu kesehatan → konsultasi.",
    ),

    ComplaintKey.lossOfAppetite: ComplaintEducation(
      title: "Hilang Nafsu Makan",
      theory: "Mual, hormon, atau psikologis.",
      normalCondition: "Trimester awal.",
      risk: "Berat badan tidak naik → janin bisa BBLR.",
      tips: "Makan porsi kecil sering, pilih makanan bergizi.",
      warning: "Tidak bisa makan sama sekali → segera periksa.",
    ),

    ComplaintKey.fastHeartbeat: ComplaintEducation(
      title: "Detak Jantung Cepat",
      theory: "Volume darah naik 40–50% → jantung lebih cepat.",
      normalCondition: "Ringan, tanpa gejala lain.",
      risk: "Palpitasi berat bisa tanda anemia/penyakit jantung.",
      tips: "Istirahat, kurangi kafein.",
      warning: "Jika disertai sesak/nyeri dada → segera ke RS.",
    ),

    ComplaintKey.backPain: ComplaintEducation(
      title: "Nyeri Pinggang / Punggung",
      theory: "Perubahan postur, hormon relaksin membuat sendi lebih longgar.",
      normalCondition: "Ringan, membaik dengan istirahat.",
      risk: "Nyeri berat bisa tanda masalah ginjal/saraf.",
      tips: "Gunakan alas kaki nyaman, olahraga hamil.",
      warning: "Nyeri menetap/berat → periksa medis.",
    ),

    ComplaintKey.shortnessOfBreath: ComplaintEducation(
      title: "Sesak Napas",
      theory: "Rahim besar menekan diafragma, oksigen lebih banyak dibutuhkan.",
      normalCondition: "Ringan, hilang dengan istirahat.",
      risk: "Sesak mendadak bisa tanda asma, emboli paru, preeklamsia.",
      tips: "Duduk tegak, tarik napas dalam.",
      warning: "Sesak berat mendadak → segera ke RS.",
    ),

    ComplaintKey.blurredVision: ComplaintEducation(
      title: "Pandangan Kabur / Berkunang-kunang",
      theory: "Bisa karena tekanan darah rendah/tinggi.",
      normalCondition: "Kadang-kadang, ringan.",
      risk: "Tanda khas preeklamsia.",
      tips: "Segera cek tekanan darah.",
      warning: "Disertai sakit kepala berat & bengkak → darurat medis.",
    ),

    ComplaintKey.earlyContractions: ComplaintEducation(
      title: "Kontraksi Dini",
      theory: "Bisa berupa Braxton Hicks (latihan kontraksi).",
      normalCondition: "Jarang, tidak teratur, hilang dengan istirahat.",
      risk: "Kontraksi teratur + nyeri + darah/lendir → persalinan prematur.",
      tips: "Minum cukup air, istirahat.",
      warning: "Jika kontraksi makin sering/kuat → segera ke RS.",
    ),

    ComplaintKey.fetalMovement: ComplaintEducation(
      title: "Gerakan Janin",
      theory:
      "Gerakan janin merupakan tanda vitalitas janin, mulai dapat dirasakan ibu pada usia kehamilan sekitar 18–20 minggu. Dipengaruhi oleh aktivitas janin, volume cairan ketuban, dan sensitivitas ibu.",
      normalCondition:
      "Gerakan terasa setiap hari, rata-rata minimal 5 gerakan per jam atau 10 gerakan dalam 2 jam setelah usia kehamilan 28 minggu.",
      risk:
      "Gerakan janin berkurang atau tidak terasa bisa menandakan hipoksia janin, gangguan pertumbuhan intrauterin, atau gawat janin.",
      tips:
      "Lakukan pencatatan gerakan janin secara rutin, pilih waktu saat janin biasanya aktif (misalnya setelah makan). Gunakan sistem hitung yang dinamis berdasarkan durasi pencatatan.",
      warning:
      "Bila gerakan janin kurang dari 3 gerakan per jam atau terjadi penurunan drastis aktivitas janin → segera periksa ke tenaga kesehatan.",
    ),
  };

  // =========================
  // EN DATA (terjemahan)
  // =========================
  static final Map<ComplaintKey, ComplaintEducation> _en = {
    ComplaintKey.sti: ComplaintEducation(
      title: "Sexually Transmitted Infection (STI)",
      theory:
      "Sexually transmitted infections (STIs) are infections that can spread through sexual contact. During pregnancy, STIs need special attention because they may affect the mother’s health and the baby’s development.",
      normalCondition:
      "Some STIs may cause no symptoms, so a pregnant woman can feel healthy even when infected.",
      risk:
      "If not detected and treated, STIs may increase the risk of preterm birth, low birth weight, and transmission of infection from mother to baby. STIs to watch for include syphilis, HIV, gonorrhea, chlamydia, hepatitis B, and genital herpes.",
      tips:
      "Prevention includes staying with one trusted partner, maintaining genital hygiene, using condoms if at risk, and getting checked if you experience abnormal discharge, pain when urinating, or lower abdominal pain. Attend routine antenatal care (ANC), including STI screening as advised by healthcare professionals.",
      warning:
      "If you have symptoms or concerns related to STIs, consult a healthcare professional promptly. Bumilku helps provide accurate information for a healthy and safe pregnancy.",
    ),

    ComplaintKey.nauseaVomiting: ComplaintEducation(
      title: "Nausea and Vomiting",
      theory:
      "Caused by rising hCG and progesterone hormones in early pregnancy, which affect the vomiting center in the brain.",
      normalCondition:
      "Occurs in about 60–80% of pregnant women and usually improves after 12–16 weeks.",
      risk:
      "Hyperemesis gravidarum → dehydration, electrolyte imbalance, and weight loss.",
      tips:
      "Eat small frequent meals, choose dry foods (toast, crackers), sip fluids often, avoid strong odors.",
      warning:
      "Persistent vomiting, inability to eat/drink, severe weakness → seek medical care immediately.",
    ),

    ComplaintKey.bloating: ComplaintEducation(
      title: "Bloating",
      theory:
      "Progesterone slows bowel movement, and the growing uterus can put pressure on the stomach.",
      normalCondition: "Common throughout pregnancy.",
      risk:
      "If accompanied by severe abdominal pain or vomiting → may indicate bowel obstruction.",
      tips:
      "Avoid carbonated drinks, increase fiber and water intake, eat slowly.",
      warning: "Bloating with severe pain → needs medical evaluation.",
    ),

    ComplaintKey.heartburn: ComplaintEducation(
      title: "Heartburn / Upper Abdominal Pain",
      theory:
      "The stomach sphincter relaxes due to hormones and the uterus presses the stomach → acid reflux into the esophagus.",
      normalCondition: "Common in the 2nd–3rd trimester.",
      risk:
      "Severe heartburn may affect maternal eating patterns and fetal nutrition.",
      tips:
      "Avoid spicy, acidic, and fatty foods. Sleep on your left side with your head elevated.",
      warning: "Severe pain or vomiting blood → seek urgent care.",
    ),

    ComplaintKey.headache: ComplaintEducation(
      title: "Headache",
      theory:
      "Related to hormonal changes, lack of sleep, anemia, or blood pressure changes.",
      normalCondition: "Mild and relieved by rest.",
      risk:
      "Severe headache with blurred vision and swelling → possible preeclampsia.",
      tips: "Drink enough water, rest, and reduce stress.",
      warning: "If severe/persistent with other symptoms → get checked immediately.",
    ),

    ComplaintKey.abdominalCramp: ComplaintEducation(
      title: "Abdominal Cramps",
      theory:
      "Ligament stretching as the uterus grows, or dehydration/electrolyte imbalance.",
      normalCondition: "Mild and improves with rest.",
      risk:
      "Strong/frequent cramps → can indicate miscarriage or preterm contractions.",
      tips: "Stay hydrated, stretch gently, and rest.",
      warning: "Cramps with bleeding → seek medical care immediately.",
    ),

    ComplaintKey.vaginalDischarge: ComplaintEducation(
      title: "Vaginal Discharge",
      theory: "Higher estrogen increases vaginal fluid production.",
      normalCondition: "Milky white, odorless, not itchy.",
      risk:
      "Yellow/green, foul-smelling, itchy discharge → infection, may trigger preterm labor.",
      tips:
      "Wear cotton underwear, keep area clean, change underwear when damp.",
      warning:
      "Sudden watery leakage → could be leaking amniotic fluid (PROM).",
    ),

    ComplaintKey.bleedingSpotting: ComplaintEducation(
      title: "Bleeding / Spotting",
      theory:
      "May be implantation spotting or a sign of miscarriage/placental issues.",
      normalCondition: "Light spotting early in pregnancy can be normal.",
      risk:
      "Heavy bleeding → miscarriage, placenta previa, placental abruption.",
      tips: "Track the amount and color of blood.",
      warning: "Heavy bleeding with pain → go to the ER immediately.",
    ),

    ComplaintKey.swelling: ComplaintEducation(
      title: "Swelling (Feet/Hands/Face)",
      theory:
      "Fluid retention due to hormones and venous pressure from the uterus.",
      normalCondition: "Mild ankle swelling in the evening is common.",
      risk:
      "Sudden swelling with high blood pressure → possible preeclampsia.",
      tips: "Elevate legs, stay hydrated, reduce salt intake.",
      warning: "Swollen face/hands with headache → danger sign.",
    ),

    ComplaintKey.cravings: ComplaintEducation(
      title: "Cravings",
      theory: "Hormonal changes, psychological factors, or nutritional needs.",
      normalCondition: "Normal if cravings are for safe foods.",
      risk: "Craving non-food items (pica) can be dangerous.",
      tips: "Try to meet cravings with healthier alternatives.",
      warning: "If consuming harmful items → consult a professional urgently.",
    ),

    ComplaintKey.constipation: ComplaintEducation(
      title: "Constipation",
      theory:
      "Progesterone slows digestion; the uterus presses the bowel; low fiber intake.",
      normalCondition: "Common during pregnancy.",
      risk: "Can lead to hemorrhoids.",
      tips: "Increase fiber, drink enough water, do light exercise.",
      warning: "Bleeding during bowel movement or severe constipation → get checked.",
    ),

    ComplaintKey.excessiveFatigue: ComplaintEducation(
      title: "Excessive Fatigue",
      theory:
      "Higher metabolism, increased cardiac workload, and anemia are common contributors.",
      normalCondition: "Common in early pregnancy.",
      risk: "Severe anemia may affect fetal growth and development.",
      tips: "Rest, eat nutritious foods, check hemoglobin if very weak.",
      warning: "Unable to do daily activities due to weakness → seek evaluation.",
    ),

    ComplaintKey.sleepyDizzy: ComplaintEducation(
      title: "Sleepiness and Dizziness",
      theory: "Hormonal effects and blood pressure changes.",
      normalCondition: "Mild and occasional.",
      risk:
      "Frequent dizziness → may indicate anemia or abnormal blood pressure.",
      tips: "Get enough sleep and stand up slowly.",
      warning: "Severe dizziness, frequent falls, blurred vision → seek care.",
    ),

    ComplaintKey.moodChanges: ComplaintEducation(
      title: "Mood Changes",
      theory: "Hormonal changes affect the brain; anxiety can contribute.",
      normalCondition: "Emotional ups and downs can be normal.",
      risk: "Prenatal depression may affect both mother and baby.",
      tips: "Family support, relaxation, spiritual practices.",
      warning: "Thoughts of self-harm → seek urgent professional help.",
    ),

    ComplaintKey.sleepProblems: ComplaintEducation(
      title: "Sleep Problems",
      theory: "Growing uterus, frequent urination, anxiety.",
      normalCondition: "Difficulty sleeping can be common.",
      risk: "Poor sleep can worsen fatigue and mood.",
      tips: "Sleep on your left side, use extra pillows.",
      warning: "Severe insomnia affecting health → consult a provider.",
    ),

    ComplaintKey.lossOfAppetite: ComplaintEducation(
      title: "Loss of Appetite",
      theory: "Nausea, hormonal changes, or psychological factors.",
      normalCondition: "Common in early pregnancy.",
      risk: "Poor weight gain → risk of low birth weight baby.",
      tips: "Small frequent meals, choose nutrient-dense foods.",
      warning: "Cannot eat at all → seek medical care.",
    ),

    ComplaintKey.fastHeartbeat: ComplaintEducation(
      title: "Fast Heartbeat",
      theory:
      "Blood volume increases by 40–50% → the heart may beat faster.",
      normalCondition: "Mild palpitations without other symptoms.",
      risk:
      "Severe palpitations may indicate anemia or heart conditions.",
      tips: "Rest and reduce caffeine intake.",
      warning: "With shortness of breath/chest pain → go to ER.",
    ),

    ComplaintKey.backPain: ComplaintEducation(
      title: "Lower Back Pain",
      theory:
      "Posture changes and relaxin hormone loosen joints and ligaments.",
      normalCondition: "Mild and improves with rest.",
      risk: "Severe persistent pain may indicate kidney/nerve issues.",
      tips: "Wear supportive footwear, do pregnancy-safe exercise.",
      warning: "Severe/persistent pain → medical evaluation needed.",
    ),

    ComplaintKey.shortnessOfBreath: ComplaintEducation(
      title: "Shortness of Breath",
      theory:
      "The uterus pushes the diaphragm; oxygen demand increases.",
      normalCondition: "Mild and relieved by rest.",
      risk:
      "Sudden severe shortness of breath → asthma, pulmonary embolism, preeclampsia.",
      tips: "Sit upright and take slow deep breaths.",
      warning: "Sudden severe shortness of breath → emergency care.",
    ),

    ComplaintKey.blurredVision: ComplaintEducation(
      title: "Blurred Vision / Seeing Spots",
      theory: "Can be related to low or high blood pressure.",
      normalCondition: "Occasional and mild.",
      risk: "A classic sign of preeclampsia.",
      tips: "Check blood pressure promptly.",
      warning: "With severe headache and swelling → medical emergency.",
    ),

    ComplaintKey.earlyContractions: ComplaintEducation(
      title: "Early Contractions",
      theory: "May be Braxton Hicks (practice contractions).",
      normalCondition: "Infrequent, irregular, relieved by rest.",
      risk:
      "Regular contractions with pain and bleeding/mucus → preterm labor.",
      tips: "Hydrate and rest.",
      warning: "If contractions become frequent/strong → seek care immediately.",
    ),

    ComplaintKey.fetalMovement: ComplaintEducation(
      title: "Fetal Movement",
      theory:
      "Fetal movement is a vital sign of fetal well-being, commonly felt around 18–20 weeks. It is influenced by fetal activity, amniotic fluid volume, and maternal sensitivity.",
      normalCondition:
      "Felt daily; after 28 weeks, average is at least ~5 movements/hour or 10 movements within 2 hours.",
      risk:
      "Reduced or absent movement may indicate fetal hypoxia, growth restriction, or fetal distress.",
      tips:
      "Track fetal movement routinely. Choose a time when the baby is usually active (e.g., after meals). Use a dynamic counting system based on tracking duration.",
      warning:
      "If movement is less than 3 per hour or there is a sudden significant decrease → seek medical attention immediately.",
    ),
  };

  // ==========
  // PUBLIC API
  // ==========

  static ComplaintEducation? getEducationByKey(
      BuildContext context,
      ComplaintKey key,
      ) {
    final locale = Localizations.localeOf(context);
    final isEn = locale.languageCode.toLowerCase() == 'en';
    return (isEn ? _en : _id)[key];
  }

  /// Kalau controller/UI kamu masih kirim String "nama keluhan",
  /// pakai mapper ini biar tetap aman.
  static ComplaintKey? mapFromTitle(BuildContext context, String title) {
    final t = AppLocalizations.of(context)!;

    final map = <String, ComplaintKey>{
      // gunakan label UI (localized) sebagai mapping aman
      t.complaintNauseaVomiting: ComplaintKey.nauseaVomiting,
      t.complaintBloating: ComplaintKey.bloating,
      t.complaintHeartburn: ComplaintKey.heartburn,
      t.complaintHeadache: ComplaintKey.headache,
      t.complaintAbdominalCramp: ComplaintKey.abdominalCramp,
      t.complaintVaginalDischarge: ComplaintKey.vaginalDischarge,
      t.complaintBleedingSpotting: ComplaintKey.bleedingSpotting,
      t.complaintSwelling: ComplaintKey.swelling,
      t.complaintCravings: ComplaintKey.cravings,
      t.complaintConstipation: ComplaintKey.constipation,
      t.complaintExcessiveFatigue: ComplaintKey.excessiveFatigue,
      t.complaintSleepyDizzy: ComplaintKey.sleepyDizzy,
      t.complaintMoodChanges: ComplaintKey.moodChanges,
      t.complaintSleepProblems: ComplaintKey.sleepProblems,
      t.complaintLossOfAppetite: ComplaintKey.lossOfAppetite,
      t.complaintFastHeartbeat: ComplaintKey.fastHeartbeat,
      t.complaintBackPain: ComplaintKey.backPain,
      t.complaintShortnessOfBreath: ComplaintKey.shortnessOfBreath,
      t.complaintBlurredVision: ComplaintKey.blurredVision,
      t.complaintEarlyContractions: ComplaintKey.earlyContractions,
      t.complaintFetalMovement: ComplaintKey.fetalMovement,
      t.complaintSti: ComplaintKey.sti,
    };

    // fallback juga (kalau title ID lama masih lewat)
    final fallback = <String, ComplaintKey>{
      "Mual dan Muntah": ComplaintKey.nauseaVomiting,
      "Kembung": ComplaintKey.bloating,
      "Maag / Nyeri Ulu Hati": ComplaintKey.heartburn,
      "Sakit Kepala": ComplaintKey.headache,
      "Kram Perut": ComplaintKey.abdominalCramp,
      "Keputihan": ComplaintKey.vaginalDischarge,
      "Pendarahan / Bercak": ComplaintKey.bleedingSpotting,
      "Bengkak": ComplaintKey.swelling,
      "Ngidam": ComplaintKey.cravings,
      "Sembelit": ComplaintKey.constipation,
      "Kelelahan": ComplaintKey.excessiveFatigue,
      "Ngantuk dan Pusing": ComplaintKey.sleepyDizzy,
      "Perubahan Mood": ComplaintKey.moodChanges,
      "Masalah Tidur": ComplaintKey.sleepProblems,
      "Hilang Nafsu Makan": ComplaintKey.lossOfAppetite,
      "Detak Jantung Cepat": ComplaintKey.fastHeartbeat,
      "Nyeri Pinggang": ComplaintKey.backPain,
      "Sesak Napas": ComplaintKey.shortnessOfBreath,
      "Pandangan Kabur": ComplaintKey.blurredVision,
      "Kontraksi Dini": ComplaintKey.earlyContractions,
      "Gerakan Janin": ComplaintKey.fetalMovement,
      "Infeksi Menular Seksual (IMS)": ComplaintKey.sti,
    };

    return map[title] ?? fallback[title];
  }
}
