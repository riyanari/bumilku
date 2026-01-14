import 'package:flutter/material.dart';
import 'data/complaint_education_data.dart';
import 'data/pregnancy_tips_data.dart';
import 'data/risk_education_data.dart';

// Pindahkan enum PageType ke luar class agar bisa diakses dari mana saja
enum PageType {
  vitalData,
  complaints,
  fetalMovement,
  pregnancyHistory,
  healthHistory,
  physicalData,
  menstrual,
  lifestyle,
}

class SelfDetectionController extends ChangeNotifier {
  int _currentPage = 0;
  DateTime? _selectedLMPDate;
  int _score = 0;
  int get score => _score;

  bool _hasRedFlag = false;
  bool get hasRedFlag => _hasRedFlag;
  List<String> _redFlagReasons = [];
  List<String> get redFlagReasons => _redFlagReasons;

  // Data edukasi
  final Map<String, ComplaintEducation> _selectedComplaintEducations = {};
  Map<String, ComplaintEducation> get selectedComplaintEducations => _selectedComplaintEducations;

  Map<String, String>? _riskLevelEducation;
  Map<String, String>? get riskLevelEducation => _riskLevelEducation;

  // Controllers untuk form input
  final TextEditingController systolicBpController = TextEditingController();
  final TextEditingController diastolicBpController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController pulseController = TextEditingController();
  final TextEditingController respirationController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightBeforeController = TextEditingController();
  final TextEditingController currentWeightController = TextEditingController();
  final TextEditingController lilaController = TextEditingController();
  final TextEditingController childrenCountController = TextEditingController();
  final TextEditingController firstPregnancyAgeController = TextEditingController();
  final TextEditingController pregnancyGapController = TextEditingController();
  final TextEditingController obstetricHistoryController = TextEditingController();
  final TextEditingController deliveryComplicationController = TextEditingController();
  final TextEditingController babyWeightHistoryController = TextEditingController();
  final TextEditingController previousPregnancyController = TextEditingController();
  final TextEditingController diseaseHistoryController = TextEditingController();
  final TextEditingController allergyHistoryController = TextEditingController();
  final TextEditingController surgeryHistoryController = TextEditingController();
  final TextEditingController medicationController = TextEditingController();
  final TextEditingController menstrualCycleController = TextEditingController();
  final TextEditingController ultrasoundResultController = TextEditingController();
  final TextEditingController fetalMovementController = TextEditingController();
  final TextEditingController currentAgeController = TextEditingController();
  final TextEditingController physicalActivityController = TextEditingController();
  final TextEditingController familySupportController = TextEditingController();
  final TextEditingController customComplaintController = TextEditingController();

  // Data gerakan janin
  DateTime? _fetalMovementDateTime;
  int _fetalMovementCount = 0;
  int _fetalMovementDuration = 0;
  String _fetalActivityPattern = '';
  String _movementComparison = '';
  List<String> _fetalAdditionalComplaints = [];

  // Getter dan setter untuk data gerakan janin
  DateTime? get fetalMovementDateTime => _fetalMovementDateTime;
  set fetalMovementDateTime(DateTime? value) {
    _fetalMovementDateTime = value;
    notifyListeners();
  }

  int get fetalMovementCount => _fetalMovementCount;
  set fetalMovementCount(int value) {
    _fetalMovementCount = value;
    notifyListeners();
  }

  int get fetalMovementDuration => _fetalMovementDuration;
  set fetalMovementDuration(int value) {
    _fetalMovementDuration = value;
    notifyListeners();
  }

  String get fetalActivityPattern => _fetalActivityPattern;
  set fetalActivityPattern(String value) {
    _fetalActivityPattern = value;
    notifyListeners();
  }

  String get movementComparison => _movementComparison;
  set movementComparison(String value) {
    _movementComparison = value;
    notifyListeners();
  }

  List<String> get fetalAdditionalComplaints => _fetalAdditionalComplaints;
  set fetalAdditionalComplaints(List<String> value) {
    _fetalAdditionalComplaints = value;
    notifyListeners();
  }

  // Method untuk mengecek apakah perlu menampilkan halaman gerakan janin
  bool get shouldShowFetalMovementPage {
    return complaintSelected["Gerakan Janin"] == true;
  }

  // Keluhan dan severity
  final List<String> complaints = [
    "Mual dan muntah", "Kembung", "Maag / nyeri ulu hati", "Sakit kepala", "Gerakan Janin",
    "Kram perut", "Keputihan", "Ngidam", "Pendarahan / bercak dari jalan lahir",
    "Bengkak pada kaki / tangan / wajah", "Sembelit", "Kelelahan berlebihan",
    "Ngantuk dan pusing", "Perubahan mood", "Masalah tidur", "Hilang nafsu makan",
    "Detak jantung cepat", "Nyeri pinggang / punggung", "Sesak napas",
    "Pandangan kabur / berkunang-kunang", "Kontraksi dini (perut sering kencang sebelum waktunya)",
  ];

  final Map<String, int> complaintSeverity = {
    "Mual dan muntah": 0, "Kembung": 0, "Maag / nyeri ulu hati": 1, "Gerakan Janin": 2,
    "Sakit kepala": 1, "Kram perut": 1, "Keputihan": 0, "Ngidam": 0,
    "Pendarahan / bercak dari jalan lahir": 2, "Bengkak pada kaki / tangan / wajah": 2,
    "Sembelit": 0, "Kelelahan berlebihan": 0, "Ngantuk dan pusing": 0,
    "Perubahan mood": 0, "Masalah tidur": 0, "Hilang nafsu makan": 0,
    "Detak jantung cepat": 1, "Nyeri pinggang / punggung": 0, "Sesak napas": 2,
    "Pandangan kabur / berkunang-kunang": 2, "Kontraksi dini (perut sering kencang sebelum waktunya)": 2,
  };

  final Map<String, bool> complaintSelected = {};
  final Map<String, bool> smokingStatus = {
    "Tidak merokok": true, "Merokok": false, "Terpapar asap rokok": false,
  };

  final Map<String, bool> alcoholDrugStatus = {
    "Tidak mengonsumsi": true, "Mengonsumsi alkohol": false, "Mengonsumsi obat terlarang": false,
  };

  String result = "";
  String recommendation = "";
  double? bmiValue;

  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  DateTime? get selectedLMPDate => _selectedLMPDate;
  set selectedLMPDate(DateTime? value) {
    _selectedLMPDate = value;
    notifyListeners();
  }

  // Getter untuk total halaman
  int get totalPages => _getPageOrder().length;

  // Getter untuk current page type
  PageType get currentPageType {
    final pages = _getPageOrder();
    if (_currentPage < pages.length) {
      return pages[_currentPage];
    }
    return PageType.vitalData;
  }

  SelfDetectionController() {
    for (var c in complaints) {
      complaintSelected[c] = false;
    }
    heightController.addListener(_calculateBMI);
    currentWeightController.addListener(_calculateBMI);
  }

  @override
  void dispose() {
    // Dispose semua controller
    systolicBpController.dispose();
    diastolicBpController.dispose();
    temperatureController.dispose();
    pulseController.dispose();
    respirationController.dispose();
    heightController.dispose();
    weightBeforeController.dispose();
    currentWeightController.dispose();
    lilaController.dispose();
    childrenCountController.dispose();
    firstPregnancyAgeController.dispose();
    pregnancyGapController.dispose();
    obstetricHistoryController.dispose();
    deliveryComplicationController.dispose();
    babyWeightHistoryController.dispose();
    previousPregnancyController.dispose();
    diseaseHistoryController.dispose();
    allergyHistoryController.dispose();
    surgeryHistoryController.dispose();
    medicationController.dispose();
    menstrualCycleController.dispose();
    ultrasoundResultController.dispose();
    fetalMovementController.dispose();
    currentAgeController.dispose();
    physicalActivityController.dispose();
    familySupportController.dispose();
    customComplaintController.dispose();
    super.dispose();
  }

  void addCustomComplaint(String complaint) {
    final trimmed = complaint.trim();
    if (trimmed.isEmpty) return;

    final exists = complaints.any((c) => c.toLowerCase() == trimmed.toLowerCase());
    if (exists) return;

    // MASUK PALING ATAS
    complaints.insert(0, trimmed);

    complaintSeverity[trimmed] = 0;     // default normal
    complaintSelected[trimmed] = true;  // langsung terpilih

    customComplaintController.clear();
    notifyListeners();
  }


  void _calculateBMI() {
    double? height = double.tryParse(heightController.text);
    double? currentWeight = double.tryParse(currentWeightController.text);
    if (height != null && currentWeight != null && height > 0) {
      double heightInMeters = height / 100;
      bmiValue = currentWeight / (heightInMeters * heightInMeters);
      notifyListeners();
    }
  }

  String _getRecommendation(String riskLevel) {
    switch (riskLevel) {
      case "Risiko Tinggi":
        return "Segera periksakan diri ke fasilitas kesehatan untuk mendapatkan penanganan medis.";
      case "Perlu Perhatian":
        return "Disarankan kontrol lebih awal ke fasilitas pelayanan kesehatan untuk pemeriksaan lebih lanjut.";
      case "Normal":
        return "Selamat Bunda, kondisi kehamilan Anda terdeteksi normal. Tetap jaga pola makan, istirahat cukup, dan lakukan pemeriksaan rutin ke tenaga kesehatan.";
      default:
        return "Tidak ada rekomendasi spesifik.";
    }
  }

  Map<String, dynamic> calculateRiskBasedOnFormula(BuildContext context) {
    int totalScore = _calculateScore(context);
    bool hasRedFlag = _hasRedFlag;

    String riskLevel;
    if (hasRedFlag || totalScore >= 4) {
      riskLevel = "Risiko Tinggi";
    } else if (totalScore >= 2 || (totalScore == 1 && hasRedFlag)) {
      riskLevel = "Perlu Perhatian";
    } else {
      riskLevel = "Normal";
    }

    String recommendation = _getRecommendation(riskLevel);
    _riskLevelEducation = RiskEducationData.getEducation(context,riskLevel);

    // HITUNG STATUS GERAKAN JANIN UNTUK DISERTAKAN DI HASIL
    final fetalMovementStatus = _calculateFetalMovementStatus();

    return {
      'riskLevel': riskLevel.toLowerCase(),
      'score': totalScore,
      'recommendation': recommendation,
      'details': _redFlagReasons,
      'complaintEducations': _selectedComplaintEducations,
      'riskEducation': _riskLevelEducation,
      'generalTips': getGeneralPregnancyTips(),
      'hasRedFlag': hasRedFlag,

      // DATA GERAKAN JANIN YANG LEBIH DETAIL
      'hasFetalMovementData': shouldShowFetalMovementPage,
      'fetalMovementCount': _fetalMovementCount,
      'fetalMovementDuration': _fetalMovementDuration,
      'movementComparison': _movementComparison,
      'fetalActivityPattern': _fetalActivityPattern,
      'fetalAdditionalComplaints': _fetalAdditionalComplaints,
      'fetalMovementDateTime': _fetalMovementDateTime?.toIso8601String(),
      'fetalMovementStatus': fetalMovementStatus, // Status dinamis
      // PERBAIKAN: Hitung movementsPerHour yang benar untuk 12 jam
      'movementsPerHour': _fetalMovementCount > 0 && _fetalMovementDuration > 0
          ? (_fetalMovementCount / _fetalMovementDuration) // Sudah dalam jam, jadi langsung bagi
          : 0.0,
    };
  }

  // Tambahkan method untuk menghitung status gerakan janin
  // PERBAIKI method _calculateFetalMovementStatus di SelfDetectionController
  Map<String, dynamic> _calculateFetalMovementStatus() {
    if (_fetalMovementCount == 0 || _fetalMovementDuration == 0) {
      return {
        'status': 'incomplete',
        'title': 'Data Tercatat',
        'message': 'Data gerakan janin belum lengkap',
        'color': 'grey'
      };
    }

    // STANDAR BARU: minimal 10 gerakan dalam 12 jam
    if (_fetalMovementCount >= 10) {
      return {
        'status': 'normal',
        'title': 'Kondisi Normal',
        'message': 'Gerakan janin dalam batas normal ($_fetalMovementCount gerakan dalam 12 jam)',
        'color': 'green'
      };
    } else if (_fetalMovementCount >= 7) {
      return {
        'status': 'monitoring',
        'title': 'Perlu Pemantauan',
        'message': 'Gerakan janin $_fetalMovementCount kali dalam 12 jam. Tetap pantau secara rutin.',
        'color': 'blue'
      };
    } else if (_fetalMovementCount >= 4) {
      return {
        'status': 'attention',
        'title': 'Perlu Perhatian',
        'message': 'Gerakan janin $_fetalMovementCount kali dalam 12 jam. Disarankan konsultasi dengan tenaga kesehatan.',
        'color': 'orange'
      };
    } else {
      return {
        'status': 'emergency',
        'title': 'Perhatian Khusus',
        'message': 'Gerakan janin hanya $_fetalMovementCount kali dalam 12 jam. Segera hubungi tenaga kesehatan.',
        'color': 'red'
      };
    }
  }

  void calculateRisk(BuildContext context) {
    _score = _calculateScore(context);

    if (_hasRedFlag || _score >= 4) {
      result = "Risiko Tinggi";
      recommendation = "Segera periksakan diri ke fasilitas kesehatan.";
    } else if (_score >= 2 || (_score == 1 && _hasRedFlag)) {
      result = "Perlu Perhatian";
      recommendation = "Disarankan kontrol lebih awal untuk pemeriksaan.";
    } else {
      result = "Kehamilan Normal";
      recommendation = "Tetap jaga pola makan dan istirahat cukup.";
    }

    _riskLevelEducation = RiskEducationData.getEducation(context, result);
    notifyListeners();
  }

  // Tambahkan method untuk menilai gerakan janin secara dinamis
  // Dalam SelfDetectionController, ubah method _assessFetalMovement:
  int _assessFetalMovement() {
    int score = 0;

    // Hanya beri penilaian jika ada data gerakan janin
    if (_fetalMovementCount > 0 && _fetalMovementDuration > 0) {
      // STANDAR BARU: minimal 10 gerakan dalam 12 jam
      if (_fetalMovementCount < 4) { // Kurang dari 4 gerakan dalam 12 jam
        score += 2; // Sangat berbahaya
        _hasRedFlag = true;
        _redFlagReasons.add("Gerakan janin sangat berkurang ($_fetalMovementCount gerakan dalam 12 jam)");
      } else if (_fetalMovementCount < 7) { // 4-6 gerakan dalam 12 jam
        score += 1; // Perlu perhatian
        _redFlagReasons.add("Gerakan janin berkurang ($_fetalMovementCount gerakan dalam 12 jam)");
      } else if (_fetalMovementCount < 10) { // 7-9 gerakan dalam 12 jam
        score += 1; // Perlu pemantauan
        _redFlagReasons.add("Gerakan janin mendekati batas minimal ($_fetalMovementCount gerakan dalam 12 jam)");
      }

      // Tambahkan penilaian untuk perbandingan gerakan
      if (_movementComparison == 'Lebih sedikit') {
        score += 1;
        _redFlagReasons.add("Penurunan gerakan janin dibanding hari sebelumnya");
      }
    }

    return score;
  }

  int _calculateScore(BuildContext context) {
    int totalScore = 0;
    _hasRedFlag = false;
    _redFlagReasons.clear();
    _selectedComplaintEducations.clear();

    totalScore += _assessVitalData();
    totalScore += _assessComplaints(context);
    // TAMBAHKAN PENILAIAN GERAKAN JANIN JIKA ADA DATA
    if (shouldShowFetalMovementPage) {
      totalScore += _assessFetalMovement();
    }
    totalScore += _assessPregnancyHistory();
    totalScore += _assessHealthHistory();
    totalScore += _assessPhysicalData();
    totalScore += _assessMenstrualPregnancyData();
    totalScore += _assessLifestyleData();

    return totalScore;
  }

  int _assessComplaints(BuildContext context) {
    int score = 0;
    List<String> selectedComplaints = complaintSelected.entries
        .where((element) => element.value)
        .map((e) => e.key)
        .toList();

    for (var complaint in selectedComplaints) {
      int severity = complaintSeverity[complaint] ?? 0;
      score += severity;

      final key = ComplaintEducationData.mapFromTitle(context, complaint);
      if (key != null) {
        final education = ComplaintEducationData.getEducationByKey(context, key);
        if (education != null) {
          _selectedComplaintEducations[complaint] = education;
        }
      }


      if (severity == 2) {
        _hasRedFlag = true;
        _redFlagReasons.add("Keluhan berat: $complaint");
      }
    }
    return score;
  }

  int _assessVitalData() {
    int score = 0;

    double? systolic = double.tryParse(systolicBpController.text);
    double? diastolic = double.tryParse(diastolicBpController.text);

    if (systolic != null && diastolic != null) {
      if (systolic >= 140 || diastolic >= 90) {
        score += 2;
        _hasRedFlag = true;
        _redFlagReasons.add("Tekanan darah tinggi ($systolic/$diastolic mmHg)");
      } else if (systolic < 90 || diastolic < 60) {
        score += 1;
      }
    }

    double? temp = double.tryParse(temperatureController.text);
    if (temp != null) {
      if (temp > 38) {
        score += 2;
        _hasRedFlag = true;
        _redFlagReasons.add("Demam tinggi ($temp °C)");
      } else if (temp >= 37.6) {
        score += 1;
      }
    }

    int? pulse = int.tryParse(pulseController.text);
    if (pulse != null) {
      if (pulse < 50 || pulse > 120) {
        score += 2;
        _hasRedFlag = true;
        _redFlagReasons.add("Denyut nadi abnormal ($pulse x/menit)");
      } else if (pulse < 60 || pulse > 100) {
        score += 1;
      }
    }

    int? respiration = int.tryParse(respirationController.text);
    if (respiration != null) {
      if (respiration < 12 || respiration > 24) {
        score += 2;
        _hasRedFlag = true;
        _redFlagReasons.add("Frekuensi napas abnormal ($respiration x/menit)");
      } else if (respiration < 16 || respiration > 20) {
        score += 1;
      }
    }

    return score;
  }

  int _assessPregnancyHistory() {
    int score = 0;

    String complications = deliveryComplicationController.text.toLowerCase();
    String obstetricHistory = obstetricHistoryController.text.toLowerCase();
    String previousPregnancy = previousPregnancyController.text.toLowerCase();

    List<String> seriousComplications = [
      "perdarahan", "preeklampsia", "janin meninggal", "hamil ektopik",
      "keguguran", "prematur", "bblr", "bayi besar"
    ];

    for (var complication in seriousComplications) {
      if (complications.contains(complication) ||
          obstetricHistory.contains(complication) ||
          previousPregnancy.contains(complication)) {

        if (complication == "perdarahan" ||
            complication == "preeklampsia" ||
            complication == "janin meninggal" ||
            complication == "hamil ektopik") {
          score += 2;
          _hasRedFlag = true;
          _redFlagReasons.add("Riwayat komplikasi serius: $complication");
        } else {
          score += 1;
        }
        break;
      }
    }

    return score;
  }

  int _assessHealthHistory() {
    int score = 0;

    String diseaseHistory = diseaseHistoryController.text.toLowerCase();

    List<String> seriousConditions = [
      "hipertensi", "diabetes", "jantung", "ginjal", "hiv", "hepatitis", "tb aktif"
    ];

    for (var condition in seriousConditions) {
      if (diseaseHistory.contains(condition)) {
        score += 2;
        _hasRedFlag = true;
        _redFlagReasons.add("Penyakit kronis: $condition");
        break;
      }
    }

    if (score == 0) {
      List<String> mildConditions = ["asma", "alergi", "tb sembuh"];
      for (var condition in mildConditions) {
        if (diseaseHistory.contains(condition)) {
          score += 1;
          break;
        }
      }
    }

    return score;
  }

  int _assessPhysicalData() {
    int score = 0;

    if (bmiValue != null) {
      if (bmiValue! >= 30) {
        score += 2;
        _hasRedFlag = true;
        _redFlagReasons.add("Obesitas (IMT: ${bmiValue!.toStringAsFixed(1)})");
      } else if (bmiValue! < 18.5 || bmiValue! >= 25) {
        score += 1;
      }
    }

    double? lila = double.tryParse(lilaController.text);
    if (lila != null && lila < 23.5) {
      score += 1;
    }

    return score;
  }

  int _assessMenstrualPregnancyData() {
    int score = 0;

    String cycle = menstrualCycleController.text.toLowerCase();
    if (cycle.contains("tidak teratur")) {
      score += 1;
    }

    String ultrasound = ultrasoundResultController.text.toLowerCase();
    if (ultrasound.contains("masalah") || ultrasound.contains("abnormal")) {
      score += 2;
      _hasRedFlag = true;
      _redFlagReasons.add("Hasil USG menunjukkan masalah");
    }

    String movement = fetalMovementController.text.toLowerCase();
    if (movement.contains("tidak") || movement.contains("berkurang")) {
      score += 2;
      _hasRedFlag = true;
      _redFlagReasons.add("Tidak ada/berkurangnya gerakan janin");
    }

    return score;
  }

  int _assessLifestyleData() {
    int score = 0;

    int? age = int.tryParse(currentAgeController.text);
    if (age != null && (age < 20 || age > 35)) {
      score += 1;
    }

    if (smokingStatus["Merokok"] == true) {
      score += 2;
      _hasRedFlag = true;
      _redFlagReasons.add("Kebiasaan merokok");
    } else if (smokingStatus["Terpapar asap rokok"] == true) {
      score += 1;
    }

    if (alcoholDrugStatus["Mengonsumsi alkohol"] == true ||
        alcoholDrugStatus["Mengonsumsi obat terlarang"] == true) {
      score += 2;
      _hasRedFlag = true;
      _redFlagReasons.add("Konsumsi alkohol/obat terlarang");
    }

    String support = familySupportController.text.toLowerCase();
    if (support.contains("tidak") || support.contains("minim")) {
      score += 1;
    }

    return score;
  }

  bool validateCurrentPage() {
    final pages = _getPageOrder();

    if (_currentPage >= pages.length) {
      return true;
    }

    final pageType = pages[_currentPage];

    switch (pageType) {
      case PageType.vitalData:
        return _validateVitalData();
      case PageType.complaints:
        return true;
      case PageType.fetalMovement:
        return _validateFetalMovementPage();
      case PageType.pregnancyHistory:
        return _validatePregnancyHistory();
      case PageType.healthHistory:
        return true;
      case PageType.physicalData:
        return _validatePhysicalData();
      case PageType.menstrual:
        return _selectedLMPDate != null;
      case PageType.lifestyle:
        return _validateLifestyleData();
      }
  }

  bool _validateFetalMovementPage() {
    bool isValid = _fetalMovementCount > 0 &&
        _fetalMovementDuration > 0 &&
        _movementComparison.isNotEmpty;

    return isValid;
  }

  List<PageType> _getPageOrder() {
    final pages = [PageType.vitalData, PageType.complaints];

    if (shouldShowFetalMovementPage) {
      pages.add(PageType.fetalMovement);
    }

    pages.addAll([
      PageType.pregnancyHistory,
      PageType.healthHistory,
      PageType.physicalData,
      PageType.menstrual,
      PageType.lifestyle,
    ]);

    return pages;
  }

  bool _validateVitalData() {
    final validators = [
          (value) => value.isEmpty ? 'Tekanan darah sistolik harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Tekanan darah diastolik harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Suhu tubuh harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Nadi harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Frekuensi napas harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
    ];

    final controllers = [
      systolicBpController,
      diastolicBpController,
      temperatureController,
      pulseController,
      respirationController,
    ];

    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        return false;
      }
    }
    return true;
  }

  bool _validatePregnancyHistory() {
    final validators = [
          (value) => value.isEmpty ? 'Jumlah anak harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Usia pertama hamil harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Jarak kehamilan harus diisi' : null,
    ];

    final controllers = [
      childrenCountController,
      firstPregnancyAgeController,
      pregnancyGapController,
    ];

    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        return false;
      }
    }
    return true;
  }

  bool _validatePhysicalData() {
    final validators = [
          (value) => value.isEmpty ? 'Tinggi badan harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Berat sebelum hamil harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Berat saat ini harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
    ];

    final controllers = [
      heightController,
      weightBeforeController,
      currentWeightController,
    ];

    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        return false;
      }
    }
    return true;
  }

  bool _validateLifestyleData() {
    final validators = [
          (value) => value.isEmpty ? 'Usia saat ini harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
    ];

    final controllers = [
      currentAgeController,
    ];

    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        return false;
      }
    }
    return true;
  }

  List<String> getGeneralPregnancyTips() {
    return PregnancyTipsData.getTipsId(); // ✅ tanpa context, default ID
  }

}