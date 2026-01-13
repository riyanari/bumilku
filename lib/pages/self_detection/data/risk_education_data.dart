import 'package:flutter/widgets.dart';

// Data edukasi untuk level risiko (Bilingual)
class RiskEducationData {
  static final Map<String, Map<String, Map<String, String>>> data = {
    "Normal": {
      "id": {
        "title": "Selamat! Kehamilan Anda Normal",
        "description": "Kondisi kehamilan normal. Tetap jaga kesehatan.",
        "recommendations":
        "• Kontrol rutin\n• Makan bergizi\n• Minum vitamin\n• Olahraga ringan",
      },
      "en": {
        "title": "Great! Your Pregnancy Looks Normal",
        "description": "Your pregnancy appears normal. Keep maintaining a healthy lifestyle.",
        "recommendations":
        "• Attend regular check-ups\n• Eat nutritious food\n• Take prenatal vitamins\n• Do light exercise",
      },
    },

    "Perlu Perhatian": {
      "id": {
        "title": "Perlu Perhatian Khusus",
        "description": "Ada faktor yang perlu perhatian lebih.",
        "recommendations":
        "• Konsultasi bidan/dokter\n• Pemeriksaan penunjang\n• Pantau kondisi",
      },
      "en": {
        "title": "Needs Special Attention",
        "description": "Some factors need extra attention.",
        "recommendations":
        "• Consult a midwife/doctor\n• Do recommended tests\n• Monitor your condition",
      },
    },

    "Risiko Tinggi": {
      "id": {
        "title": "Risiko Tinggi - Perhatian!",
        "description": "Terdeteksi tanda bahaya, perlu penanganan medis.",
        "recommendations":
        "• SEGERA ke RS\n• Jangan tunda pengobatan\n• Ikuti instruksi medis",
      },
      "en": {
        "title": "High Risk — Urgent Attention!",
        "description": "Warning signs were detected and may require prompt medical care.",
        "recommendations":
        "• Go to the hospital immediately\n• Do not delay treatment\n• Follow medical instructions",
      },
    },
  };

  static bool _isEn(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'en';

  /// riskLevel bisa "Normal" / "Perlu Perhatian" / "Risiko Tinggi"
  static Map<String, String>? getEducation(BuildContext context, String riskLevel) {
    final lang = _isEn(context) ? "en" : "id";
    final item = data[riskLevel];
    if (item == null) return null;
    return item[lang] ?? item["id"];
  }
}
