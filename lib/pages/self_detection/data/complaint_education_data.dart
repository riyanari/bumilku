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
    "Mual dan muntah": ComplaintEducation(
      title: "Mual dan Muntah",
      theory: "Disebabkan oleh hormon hCG dan progesteron yang meningkat.",
      normalCondition: "Normal di trimester awal, membaik setelah 12-16 minggu.",
      risk: "Dehidrasi dan gangguan elektrolit jika berlebihan.",
      tips: "Makan porsi kecil, makanan kering, hindari bau menyengat.",
      warning: "Muntah terus-menerus → segera ke RS.",
    ),
    "Kembung": ComplaintEducation(
      title: "Kembung",
      theory: "Hormon progesteron memperlambat gerakan usus.",
      normalCondition: "Wajar terjadi sepanjang kehamilan.",
      risk: "Bisa tanda sumbatan usus jika disertai nyeri.",
      tips: "Kurangi minuman bersoda, perbanyak serat.",
      warning: "Kembung + nyeri hebat → perlu pemeriksaan.",
    ),
    "Maag / nyeri ulu hati": ComplaintEducation(
      title: "Maag / Nyeri Ulu Hati",
      theory: "Sfingter lambung melemah, rahim menekan lambung.",
      normalCondition: "Sering terjadi trimester 2–3.",
      risk: "Mempengaruhi pola makan dan nutrisi janin.",
      tips: "Hindari pedas, asam, berlemak. Tidur miring kiri.",
      warning: "Nyeri sangat hebat → perlu pemeriksaan.",
    ),
    // Tambahkan keluhan lainnya di sini...
    "Pendarahan / bercak dari jalan lahir": ComplaintEducation(
      title: "Pendarahan / Bercak",
      theory: "Bisa implantasi atau tanda keguguran/plasenta bermasalah.",
      normalCondition: "Bercak ringan di awal kehamilan.",
      risk: "Pendarahan banyak → keguguran, plasenta previa.",
      tips: "Catat jumlah dan warna darah.",
      warning: "Darah banyak + nyeri → segera ke RS.",
    ),
  };

  static ComplaintEducation? getEducation(String complaintName) {
    return data[complaintName];
  }
}