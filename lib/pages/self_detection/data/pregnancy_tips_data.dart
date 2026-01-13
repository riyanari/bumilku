import 'package:flutter/widgets.dart';

class PregnancyTipsData {
  // ✅ Bilingual source (id/en)
  static final List<Map<String, String>> generalTips = [
    {
      "id": "Konsumsi makanan bergizi seimbang",
      "en": "Eat a balanced, nutritious diet",
    },
    {
      "id": "Minum air putih 8-10 gelas per hari",
      "en": "Drink 8–10 glasses of water per day",
    },
    {
      "id": "Istirahat cukup dan hindari kelelahan",
      "en": "Get enough rest and avoid overexertion",
    },
    {
      "id": "Lakukan olahraga ringan seperti jalan pagi",
      "en": "Do light exercise such as morning walks",
    },
    {
      "id": "Hindari rokok, alkohol, dan obat terlarang",
      "en": "Avoid smoking, alcohol, and illegal drugs",
    },
    {
      "id": "Kontrol rutin ke bidan atau dokter",
      "en": "Attend regular check-ups with a midwife or doctor",
    },
    {
      "id": "Minum vitamin dan suplemen teratur",
      "en": "Take vitamins and supplements regularly",
    },
    {
      "id": "Kelola stres dengan relaksasi",
      "en": "Manage stress with relaxation",
    },
    {
      "id": "Persiapkan mental untuk persalinan",
      "en": "Prepare mentally for delivery",
    },
    {
      "id": "Ikuti kelas prenatal",
      "en": "Join prenatal classes",
    },
  ];

  static bool _isEn(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'en';

  /// ✅ UI pakai ini (punya context)
  static List<String> getTips(BuildContext context) {
    final lang = _isEn(context) ? "en" : "id";
    return generalTips.map((e) => e[lang] ?? e["id"]!).toList();
  }

  /// ✅ Untuk tempat yang belum punya context (misal controller lama)
  static List<String> getTipsId() {
    return generalTips.map((e) => e["id"]!).toList();
  }
}
