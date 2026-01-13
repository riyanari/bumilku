import 'package:flutter/widgets.dart';

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
  // =========================
  // 1) COMPLAINT EDUCATION (BILINGUAL)
  // Key tetap bahasa Indonesia (kompatibel dengan data input)
  // =========================
  static final Map<String, Map<String, Map<String, String>>> complaintEducation = {
    "Mual dan muntah": {
      "id": {
        "title": "Mual dan Muntah",
        "theory":
        "Disebabkan oleh hormon hCG dan progesteron yang meningkat di trimester awal, memengaruhi pusat muntah di otak.",
        "normalCondition":
        "Terjadi pada 60–80% ibu hamil, biasanya membaik setelah usia 12–16 minggu.",
        "risk":
        "Bila muntah berlebihan (hiperemesis gravidarum), bisa menyebabkan dehidrasi, gangguan elektrolit, berat badan turun.",
        "tips":
        "Makan porsi kecil tapi sering, konsumsi makanan kering (roti, biskuit), minum air sedikit-sedikit tapi sering, hindari makanan berbau menyengat.",
        "warning":
        "Muntah terus-menerus, tidak bisa makan/minum, badan lemah → segera ke RS.",
      },
      "en": {
        "title": "Nausea and Vomiting",
        "theory":
        "Caused by increased hCG and progesterone in early pregnancy, affecting the brain’s vomiting center.",
        "normalCondition":
        "Occurs in 60–80% of pregnancies and usually improves after 12–16 weeks.",
        "risk":
        "Severe vomiting (hyperemesis gravidarum) can lead to dehydration, electrolyte imbalance, and weight loss.",
        "tips":
        "Eat small, frequent meals; choose dry foods (toast, crackers); sip water often; avoid strong-smelling foods.",
        "warning":
        "Persistent vomiting, unable to eat/drink, severe weakness → go to the hospital immediately.",
      },
    },

    "Kembung": {
      "id": {
        "title": "Kembung",
        "theory":
        "Hormon progesteron memperlambat gerakan usus, sehingga gas menumpuk. Rahim yang membesar juga menekan lambung.",
        "normalCondition": "Wajar terjadi sepanjang kehamilan.",
        "risk":
        "Jika kembung disertai nyeri perut hebat atau muntah, bisa tanda sumbatan usus.",
        "tips": "Kurangi minuman bersoda, perbanyak serat dan air putih, makan perlahan.",
        "warning": "Kembung disertai nyeri hebat → perlu pemeriksaan.",
      },
      "en": {
        "title": "Bloating",
        "theory":
        "Progesterone slows bowel movement causing gas buildup. The growing uterus can also press on the stomach.",
        "normalCondition": "Common throughout pregnancy.",
        "risk":
        "If bloating comes with severe abdominal pain or vomiting, it may indicate bowel obstruction.",
        "tips": "Reduce carbonated drinks, increase fiber and water, and eat slowly.",
        "warning": "Bloating with severe pain → needs medical evaluation.",
      },
    },

    "Maag / nyeri ulu hati": {
      "id": {
        "title": "Maag / Nyeri Ulu Hati",
        "theory":
        "Sfingter lambung melemah akibat hormon, ditambah rahim menekan lambung → asam naik ke kerongkongan.",
        "normalCondition": "Sering terjadi trimester 2–3.",
        "risk":
        "Heartburn berat dapat memengaruhi pola makan ibu → berdampak pada nutrisi janin.",
        "tips":
        "Hindari makan pedas, asam, berlemak. Tidur miring kiri dengan bantal tinggi.",
        "warning":
        "Jika nyeri sangat hebat atau disertai muntah darah → perlu pemeriksaan medis.",
      },
      "en": {
        "title": "Heartburn / Upper Stomach Pain",
        "theory":
        "Hormones relax the stomach sphincter and the uterus presses the stomach, allowing acid to reflux into the esophagus.",
        "normalCondition": "Common in the 2nd–3rd trimester.",
        "risk":
        "Severe heartburn may affect maternal eating patterns and impact fetal nutrition.",
        "tips":
        "Avoid spicy, acidic, and fatty foods. Sleep on your left side with an elevated pillow.",
        "warning": "If pain is very severe or you vomit blood → seek medical care.",
      },
    },

    "Sakit kepala": {
      "id": {
        "title": "Sakit Kepala",
        "theory":
        "Bisa akibat perubahan hormon estrogen & progesteron, kurang tidur, anemia, atau tekanan darah.",
        "normalCondition": "Ringan, hilang dengan istirahat.",
        "risk": "Sakit kepala hebat + pandangan kabur + bengkak → tanda preeklamsia.",
        "tips": "Minum cukup air, istirahat, hindari stres.",
        "warning":
        "Jika sakit kepala berat, menetap, disertai gejala lain → segera periksa.",
      },
      "en": {
        "title": "Headache",
        "theory":
        "May be due to hormonal changes, lack of sleep, anemia, or blood pressure changes.",
        "normalCondition": "Mild and improves with rest.",
        "risk": "Severe headache + blurred vision + swelling may indicate preeclampsia.",
        "tips": "Drink enough water, rest, and reduce stress.",
        "warning":
        "If headache is severe, persistent, or accompanied by other symptoms → get checked promptly.",
      },
    },

    "Kram perut": {
      "id": {
        "title": "Kram Perut",
        "theory":
        "Peregangan ligamen karena rahim membesar, atau kurang cairan/elektrolit.",
        "normalCondition": "Ringan dan hilang dengan istirahat.",
        "risk": "Jika kuat dan sering, bisa tanda keguguran atau kontraksi prematur.",
        "tips": "Minum air cukup, lakukan peregangan, istirahat.",
        "warning": "Kram disertai pendarahan → segera periksa.",
      },
      "en": {
        "title": "Abdominal Cramps",
        "theory":
        "Caused by ligament stretching from uterine growth or dehydration/electrolyte imbalance.",
        "normalCondition": "Mild and improves with rest.",
        "risk": "If strong and frequent, it could be a sign of miscarriage or preterm contractions.",
        "tips": "Hydrate well, do gentle stretching, and rest.",
        "warning": "Cramps with bleeding → seek care immediately.",
      },
    },

    "Keputihan": {
      "id": {
        "title": "Keputihan",
        "theory": "Hormon estrogen meningkatkan produksi cairan vagina.",
        "normalCondition": "Putih susu, tidak bau, tidak gatal.",
        "risk":
        "Jika kuning/hijau, bau, gatal → infeksi (jamur, bakteri, PMS). Infeksi bisa memicu persalinan prematur.",
        "tips":
        "Gunakan celana katun, jaga kebersihan, ganti celana dalam bila lembap.",
        "warning":
        "Cairan keluar deras, encer seperti air → bisa tanda ketuban pecah dini.",
      },
      "en": {
        "title": "Vaginal Discharge",
        "theory": "Estrogen increases vaginal fluid production.",
        "normalCondition": "Milky white, odorless, and not itchy.",
        "risk":
        "Yellow/green, foul-smelling, or itchy discharge may indicate infection. Infection can trigger preterm labor.",
        "tips":
        "Wear cotton underwear, keep clean, and change underwear when damp.",
        "warning": "A sudden gush of watery fluid may indicate rupture of membranes.",
      },
    },

    "Ngidam": {
      "id": {
        "title": "Ngidam",
        "theory": "Perubahan hormon, psikologis, atau kebutuhan nutrisi tertentu.",
        "normalCondition": "Selama makanan sehat.",
        "risk": "Ngidam benda aneh (pica) → berbahaya (tanah, kapur).",
        "tips": "Penuhi ngidam dengan makanan sehat.",
        "warning": "Ngidam benda non-makanan → konsultasi dengan dokter.",
      },
      "en": {
        "title": "Cravings",
        "theory": "Driven by hormonal changes, psychological factors, or certain nutrient needs.",
        "normalCondition": "Normal as long as choices are healthy.",
        "risk": "Craving non-food items (pica) can be dangerous (soil, chalk, etc.).",
        "tips": "Satisfy cravings with healthier alternatives.",
        "warning": "Craving non-food items → consult a doctor.",
      },
    },

    "Pendarahan / bercak dari jalan lahir": {
      "id": {
        "title": "Pendarahan / Bercak",
        "theory": "Bisa karena implantasi janin, tapi juga bisa tanda keguguran atau plasenta bermasalah.",
        "normalCondition": "Bercak ringan di awal kehamilan.",
        "risk": "Pendarahan banyak → keguguran, plasenta previa, solusio plasenta.",
        "tips": "Catat jumlah dan warna darah.",
        "warning": "Jika darah banyak, merah segar, dengan nyeri perut → segera ke RS.",
      },
      "en": {
        "title": "Bleeding / Spotting",
        "theory": "May occur with implantation, but can also signal miscarriage or placental problems.",
        "normalCondition": "Light spotting early in pregnancy can be normal.",
        "risk": "Heavy bleeding may indicate miscarriage, placenta previa, or placental abruption.",
        "tips": "Track the amount and color of bleeding.",
        "warning": "Heavy bright red bleeding with abdominal pain → go to the hospital immediately.",
      },
    },

    "Bengkak pada kaki / tangan / wajah": {
      "id": {
        "title": "Bengkak",
        "theory": "Retensi cairan akibat hormon, rahim menekan pembuluh darah balik.",
        "normalCondition": "Bengkak ringan di kaki sore hari.",
        "risk": "Bengkak mendadak + hipertensi → preeklamsia.",
        "tips": "Istirahat dengan kaki lebih tinggi, minum cukup air, kurangi garam.",
        "warning": "Bengkak di wajah/tangan + sakit kepala → tanda bahaya.",
      },
      "en": {
        "title": "Swelling",
        "theory": "Fluid retention from hormones and pressure on veins from the growing uterus.",
        "normalCondition": "Mild swelling in the legs later in the day.",
        "risk": "Sudden swelling with high blood pressure may indicate preeclampsia.",
        "tips": "Elevate legs, stay hydrated, and reduce salt intake.",
        "warning": "Swelling in face/hands with headache is a danger sign.",
      },
    },

    "Sembelit": {
      "id": {
        "title": "Sembelit",
        "theory": "Progesteron memperlambat usus, rahim menekan usus, dan kurang serat.",
        "normalCondition": "Wajar pada kehamilan.",
        "risk": "Bisa menyebabkan hemoroid (ambeien).",
        "tips": "Konsumsi serat, cukup minum, olahraga ringan.",
        "warning": "BAB berdarah atau sangat sulit → perlu pemeriksaan.",
      },
      "en": {
        "title": "Constipation",
        "theory": "Progesterone slows the bowel, the uterus presses the intestines, and fiber intake may be low.",
        "normalCondition": "Common in pregnancy.",
        "risk": "Can lead to hemorrhoids.",
        "tips": "Increase fiber, drink enough water, and do light exercise.",
        "warning": "Bloody stool or extreme difficulty passing stool → seek medical advice.",
      },
    },

    "Kelelahan berlebihan": {
      "id": {
        "title": "Kelelahan Berlebihan",
        "theory": "Metabolisme meningkat, jantung bekerja lebih keras, anemia sering terjadi.",
        "normalCondition": "Umum di trimester awal.",
        "risk": "Anemia berat → mengganggu perkembangan janin.",
        "tips": "Istirahat, makan bergizi, periksa Hb jika lemas sekali.",
        "warning": "Lemas sangat berat hingga tidak bisa beraktivitas → periksa ke dokter.",
      },
      "en": {
        "title": "Excessive Fatigue",
        "theory": "Higher metabolism, increased heart workload, and anemia are common contributors.",
        "normalCondition": "Common in the first trimester.",
        "risk": "Severe anemia can affect fetal development.",
        "tips": "Rest, eat nutritious foods, and check hemoglobin if very weak.",
        "warning": "Severe weakness that prevents daily activities → see a doctor.",
      },
    },

    "Ngantuk dan pusing": {
      "id": {
        "title": "Ngantuk dan Pusing",
        "theory": "Akibat hormon dan perubahan tekanan darah.",
        "normalCondition": "Sesekali, ringan.",
        "risk": "Pusing berulang → anemia, tekanan darah tinggi/rendah.",
        "tips": "Tidur cukup, bangun perlahan.",
        "warning": "Pusing berat, sering jatuh, pandangan kabur → segera periksa.",
      },
      "en": {
        "title": "Sleepiness and Dizziness",
        "theory": "Due to hormones and changes in blood pressure.",
        "normalCondition": "Occasional and mild.",
        "risk": "Recurrent dizziness may indicate anemia or abnormal blood pressure.",
        "tips": "Get enough sleep and stand up slowly.",
        "warning": "Severe dizziness, frequent falls, or blurred vision → seek care promptly.",
      },
    },

    "Perubahan mood": {
      "id": {
        "title": "Perubahan Mood",
        "theory": "Hormon memengaruhi otak, ditambah kecemasan menghadapi kehamilan.",
        "normalCondition": "Naik-turun emosi.",
        "risk": "Depresi kehamilan → berdampak pada janin.",
        "tips": "Dukungan keluarga, relaksasi, ibadah.",
        "warning": "Ibu merasa ingin menyakiti diri sendiri → segera cari pertolongan.",
      },
      "en": {
        "title": "Mood Changes",
        "theory": "Hormones affect the brain, plus anxiety about pregnancy can contribute.",
        "normalCondition": "Emotional ups and downs are common.",
        "risk": "Prenatal depression can impact both mother and baby.",
        "tips": "Seek family support, relaxation, and spiritual practices if helpful.",
        "warning": "If you feel like harming yourself → seek help immediately.",
      },
    },

    "Masalah tidur": {
      "id": {
        "title": "Masalah Tidur",
        "theory": "Posisi rahim besar, sering BAK, cemas.",
        "normalCondition": "Susah tidur wajar.",
        "risk": "Kurang tidur → mudah lelah, depresi.",
        "tips": "Tidur miring kiri, gunakan bantal tambahan.",
        "warning": "Insomnia berat hingga mengganggu aktivitas → konsultasi dokter.",
      },
      "en": {
        "title": "Sleep Problems",
        "theory": "Caused by a larger uterus, frequent urination, and anxiety.",
        "normalCondition": "Difficulty sleeping can be normal.",
        "risk": "Poor sleep may increase fatigue and risk of depression.",
        "tips": "Sleep on the left side and use extra pillows for support.",
        "warning": "Severe insomnia affecting daily life → consult a healthcare provider.",
      },
    },

    "Hilang nafsu makan": {
      "id": {
        "title": "Hilang Nafsu Makan",
        "theory": "Mual, hormon, atau psikologis.",
        "normalCondition": "Trimester awal.",
        "risk": "Berat badan tidak naik → janin bisa BBLR.",
        "tips": "Makan porsi kecil sering, makanan bergizi.",
        "warning": "Tidak bisa makan sama sekali → segera periksa.",
      },
      "en": {
        "title": "Loss of Appetite",
        "theory": "Due to nausea, hormones, or psychological factors.",
        "normalCondition": "Often occurs in the first trimester.",
        "risk": "Poor weight gain may increase the risk of low birth weight.",
        "tips": "Eat small frequent meals and choose nutrient-dense foods.",
        "warning": "Unable to eat at all → seek medical advice promptly.",
      },
    },

    "Detak jantung cepat": {
      "id": {
        "title": "Detak Jantung Cepat",
        "theory": "Volume darah meningkat 40–50% → jantung bekerja lebih cepat.",
        "normalCondition": "Ringan, tidak disertai gejala lain.",
        "risk": "Palpitasi berat bisa tanda anemia, penyakit jantung.",
        "tips": "Istirahat, kurangi kafein.",
        "warning": "Disertai sesak atau nyeri dada → segera ke RS.",
      },
      "en": {
        "title": "Rapid Heartbeat",
        "theory": "Blood volume increases by ~40–50%, so the heart works faster.",
        "normalCondition": "Mild and not accompanied by other symptoms.",
        "risk": "Severe palpitations may indicate anemia or heart conditions.",
        "tips": "Rest and reduce caffeine intake.",
        "warning": "With shortness of breath or chest pain → go to the hospital immediately.",
      },
    },

    "Nyeri pinggang / punggung": {
      "id": {
        "title": "Nyeri Pinggang / Punggung",
        "theory": "Perubahan postur, hormon relaksin membuat sendi lebih longgar.",
        "normalCondition": "Ringan, membaik dengan istirahat.",
        "risk": "Nyeri berat bisa tanda masalah ginjal atau saraf.",
        "tips": "Gunakan alas kaki nyeman, olahraga hamil.",
        "warning": "Nyeri hebat disertai demam atau BAK sakit → periksa ke dokter.",
      },
      "en": {
        "title": "Back / Lower Back Pain",
        "theory": "Postural changes and relaxin hormone loosen joints.",
        "normalCondition": "Mild and improves with rest.",
        "risk": "Severe pain may indicate kidney or nerve issues.",
        "tips": "Wear supportive footwear and do safe prenatal exercises.",
        "warning": "Severe pain with fever or painful urination → see a doctor.",
      },
    },

    "Sesak napas": {
      "id": {
        "title": "Sesak Napas",
        "theory": "Rahim besar menekan diafragma, oksigen juga dibutuhkan lebih banyak.",
        "normalCondition": "Ringan, hilang dengan istirahat.",
        "risk": "Sesak mendadak bisa tanda asma, emboli paru, preeklamsia.",
        "tips": "Duduk tegak, tarik napas dalam.",
        "warning": "Sesak berat hingga tidak bisa bicara → darurat medis.",
      },
      "en": {
        "title": "Shortness of Breath",
        "theory": "The uterus presses the diaphragm and oxygen demand increases.",
        "normalCondition": "Mild and improves with rest.",
        "risk": "Sudden severe shortness of breath may indicate asthma, pulmonary embolism, or preeclampsia.",
        "tips": "Sit upright and take slow deep breaths.",
        "warning": "Severe shortness of breath preventing speech → medical emergency.",
      },
    },

    "Pandangan kabur / berkunang-kunang": {
      "id": {
        "title": "Pandangan Kabur",
        "theory": "Bisa karena tekanan darah rendah atau tinggi.",
        "normalCondition": "Sesekali karena perubahan posisi.",
        "risk": "Tanda khas preeklamsia.",
        "tips": "Bangun perlahan, duduk jika pusing.",
        "warning": "Jika disertai sakit kepala berat & bengkak → darurat medis.",
      },
      "en": {
        "title": "Blurred Vision",
        "theory": "May be caused by low or high blood pressure.",
        "normalCondition": "Occasional episodes due to position changes can be normal.",
        "risk": "A hallmark sign of preeclampsia.",
        "tips": "Stand up slowly and sit down if you feel dizzy.",
        "warning": "If accompanied by severe headache and swelling → medical emergency.",
      },
    },

    "Kontraksi dini (perut sering kencang sebelum waktunya)": {
      "id": {
        "title": "Kontraksi Dini",
        "theory": "Bisa berupa Braxton Hicks (latihan kontraksi).",
        "normalCondition": "Jarang, tidak teratur, hilang dengan istirahat.",
        "risk": "Kontraksi teratur + nyeri + keluar darah/lendir → persalinan prematur.",
        "tips": "Minum cukup air, istirahat.",
        "warning": "Bila kontraksi makin sering/kuat → segera ke RS.",
      },
      "en": {
        "title": "Early Contractions",
        "theory": "May be Braxton Hicks (practice contractions).",
        "normalCondition": "Infrequent, irregular, and improves with rest.",
        "risk": "Regular contractions with pain and bleeding/mucus may indicate preterm labor.",
        "tips": "Stay hydrated and rest.",
        "warning": "If contractions become more frequent/strong → go to the hospital immediately.",
      },
    },
  };

  // =========================
  // 2) RISK LEVEL EDUCATION (BILINGUAL)
  // KEY harus match internal risk dari DetailHistoryPage:
  // normal / perlu perhatian / perlu pemantauan / risiko tinggi / unknown
  // =========================
  static final Map<String, Map<String, Map<String, String>>> riskLevelEducation = {
    "normal": {
      "id": {
        "title": "Selamat! Kondisi Anda Normal",
        "description":
        "Kondisi Anda terdeteksi normal. Tetap jaga kesehatan dengan pola makan bergizi dan istirahat yang cukup.",
        "recommendations": """
• Lakukan kontrol rutin ke tenaga kesehatan
• Konsumsi makanan bergizi seimbang
• Minum vitamin kehamilan secara teratur
• Lakukan olahraga ringan yang aman untuk ibu hamil
• Hindari rokok, alkohol, dan obat-obatan terlarang
• Istirahat yang cukup (7–8 jam per hari)
• Kelola stres dengan baik
""",
      },
      "en": {
        "title": "Great! Your Condition Looks Normal",
        "description":
        "Your condition appears normal. Keep maintaining a healthy diet and adequate rest.",
        "recommendations": """
• Attend regular prenatal check-ups
• Eat a balanced, nutritious diet
• Take prenatal vitamins as prescribed
• Do safe light exercises for pregnancy
• Avoid smoking, alcohol, and illegal drugs
• Get adequate sleep (7–8 hours/day)
• Manage stress well
""",
      },
    },

    "perlu perhatian": {
      "id": {
        "title": "Perlu Perhatian Khusus",
        "description":
        "Terdapat beberapa faktor yang perlu mendapatkan perhatian lebih. Disarankan untuk melakukan pemeriksaan lebih lanjut.",
        "recommendations": """
• Segera konsultasi dengan bidan atau dokter kandungan
• Lakukan pemeriksaan penunjang yang disarankan
• Pantau kondisi secara berkala
• Terapkan pola hidup sehat dengan disiplin
• Hindari aktivitas berat yang dapat memperburuk kondisi
• Catat keluhan yang muncul untuk dilaporkan ke tenaga kesehatan
""",
      },
      "en": {
        "title": "Needs Special Attention",
        "description":
        "Some factors need extra attention. Further evaluation is recommended.",
        "recommendations": """
• Consult a midwife/OB-GYN soon
• Do recommended additional tests
• Monitor your condition regularly
• Maintain a disciplined healthy lifestyle
• Avoid strenuous activities that may worsen symptoms
• Record symptoms to report to healthcare providers
""",
      },
    },

    "perlu pemantauan": {
      "id": {
        "title": "Perlu Pemantauan",
        "description":
        "Kondisi Anda perlu pemantauan lebih rutin. Perhatikan perubahan gejala dan lakukan kontrol sesuai anjuran.",
        "recommendations": """
• Pantau kondisi setiap hari
• Lakukan kontrol sesuai jadwal
• Catat perubahan keluhan
• Kurangi aktivitas berat
• Konsultasi bila ada perubahan signifikan
""",
      },
      "en": {
        "title": "Needs Monitoring",
        "description":
        "Your condition needs closer monitoring. Watch symptom changes and follow check-up recommendations.",
        "recommendations": """
• Monitor your condition daily
• Follow your scheduled check-ups
• Record changes in symptoms
• Reduce strenuous activities
• Consult if there are significant changes
""",
      },
    },

    "risiko tinggi": {
      "id": {
        "title": "Risiko Tinggi - Perhatian Khusus!",
        "description":
        "Terdeteksi adanya tanda bahaya yang memerlukan penanganan medis segera. Jangan tunda untuk berkonsultasi dengan tenaga kesehatan.",
        "recommendations": """
• SEGERA periksakan diri ke rumah sakit atau fasilitas kesehatan
• Jangan menunda pengobatan atau pemeriksaan
• Ikuti semua instruksi dari tenaga medis
• Siapkan rencana persalinan dengan tim medis
• Lakukan pemantauan ketat terhadap kondisi
• Hindari aktivitas fisik berat
• Segera ke IGD jika mengalami kondisi darurat
""",
      },
      "en": {
        "title": "High Risk — Urgent Attention!",
        "description":
        "Warning signs were detected that may require prompt medical care. Do not delay seeking help.",
        "recommendations": """
• Go to a hospital/health facility immediately
• Do not delay evaluation or treatment
• Follow medical instructions carefully
• Prepare a birth plan with your medical team
• Monitor your condition closely
• Avoid heavy physical activities
• Go to the ER if emergency symptoms occur
""",
      },
    },

    "unknown": {
      "id": {
        "title": "Data Belum Lengkap",
        "description": "Data belum lengkap atau tidak valid. Silakan lengkapi input untuk hasil yang lebih akurat.",
        "recommendations": "• Lengkapi data yang diperlukan dan lakukan pemeriksaan ulang.",
      },
      "en": {
        "title": "Incomplete Data",
        "description": "Data is incomplete or invalid. Please complete the input for more accurate results.",
        "recommendations": "• Complete the required data and re-check the result.",
      },
    },
  };

  // =========================
  // 3) GENERAL TIPS (BILINGUAL)
  // =========================
  static final List<Map<String, String>> generalPregnancyTips = [
    {"id": "Konsumsi makanan bergizi dengan gizi seimbang", "en": "Eat a balanced, nutritious diet"},
    {"id": "Minum air putih minimal 8-10 gelas per hari", "en": "Drink at least 8–10 glasses of water daily"},
    {"id": "Istirahat yang cukup dan hindari kelelahan", "en": "Get enough rest and avoid overexertion"},
    {"id": "Lakukan olahraga ringan seperti jalan pagi atau senam hamil", "en": "Do light exercises such as walking or prenatal workouts"},
    {"id": "Hindari rokok, alkohol, dan obat-obatan terlarang", "en": "Avoid smoking, alcohol, and illegal drugs"},
    {"id": "Kontrol rutin ke bidan atau dokter kandungan", "en": "Attend regular prenatal check-ups"},
    {"id": "Minum vitamin dan suplemen yang diresepkan dokter", "en": "Take vitamins/supplements as prescribed"},
    {"id": "Kelola stres dengan teknik relaksasi", "en": "Manage stress with relaxation techniques"},
    {"id": "Persiapkan mental dan fisik untuk persalinan", "en": "Prepare mentally and physically for delivery"},
    {"id": "Ikuti kelas prenatal untuk edukasi kehamilan dan persalinan", "en": "Join prenatal classes for pregnancy and birth education"},
  ];

  // =========================
  // 4) HELPERS: Ambil text sesuai locale
  // =========================
  static bool isEn(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'en';

  static String pick(BuildContext context, {required String id, required String en}) =>
      isEn(context) ? en : id;

  /// Ambil edukasi risiko sesuai risk internal.
  /// return map berisi: title, description, recommendations (sudah sesuai bahasa)
  static Map<String, String> getRiskEducation(BuildContext context, String internalRiskLevel) {
    final key = internalRiskLevel.toLowerCase();
    final lang = isEn(context) ? "en" : "id";
    final data = riskLevelEducation[key] ?? riskLevelEducation["unknown"]!;
    return data[lang] ?? data["id"]!;
  }

  /// Ambil edukasi keluhan berdasarkan key keluhan Indonesia.
  /// return map berisi: title, theory, normalCondition, risk, tips, warning
  static Map<String, String>? getEducationByComplaint(BuildContext context, String complaintKeyId) {
    final lang = isEn(context) ? "en" : "id";
    final data = complaintEducation[complaintKeyId];
    if (data == null) return null;
    return data[lang] ?? data["id"];
  }

  /// General tips sesuai bahasa
  static List<String> getGeneralTips(BuildContext context) {
    final lang = isEn(context) ? "en" : "id";
    return generalPregnancyTips.map((e) => e[lang] ?? e["id"]!).toList();
  }
}
