// Data edukasi untuk level risiko
class RiskEducationData {
  static final Map<String, Map<String, String>> data = {
    "Kehamilan Normal": {
      "title": "Selamat! Kehamilan Anda Normal",
      "description": "Kondisi kehamilan normal. Tetap jaga kesehatan.",
      "recommendations": "• Kontrol rutin\n• Makan bergizi\n• Minum vitamin\n• Olahraga ringan"
    },
    "Perlu Perhatian": {
      "title": "Perlu Perhatian Khusus",
      "description": "Ada faktor yang perlu perhatian lebih.",
      "recommendations": "• Konsultasi bidan/dokter\n• Pemeriksaan penunjang\n• Pantau kondisi"
    },
    "Risiko Tinggi": {
      "title": "Risiko Tinggi - Perhatian!",
      "description": "Terdeteksi tanda bahaya, perlu penanganan medis.",
      "recommendations": "• SEGERA ke RS\n• Jangan tunda pengobatan\n• Ikuti instruksi medis"
    }
  };

  static Map<String, String>? getEducation(String riskLevel) {
    return data[riskLevel];
  }
}