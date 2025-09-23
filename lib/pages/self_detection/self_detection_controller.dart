import 'package:flutter/material.dart';
import 'data/complaint_education_data.dart';
import 'data/pregnancy_tips_data.dart';
import 'data/risk_education_data.dart';

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

  // Keluhan dan severity
  final List<String> complaints = [
    "Mual dan muntah", "Kembung", "Maag / nyeri ulu hati", "Sakit kepala",
    "Kram perut", "Keputihan", "Ngidam", "Pendarahan / bercak dari jalan lahir",
    "Bengkak pada kaki / tangan / wajah", "Sembelit", "Kelelahan berlebihan",
    "Ngantuk dan pusing", "Perubahan mood", "Masalah tidur", "Hilang nafsu makan",
    "Detak jantung cepat", "Nyeri pinggang / punggung", "Sesak napas",
    "Pandangan kabur / berkunang-kunang", "Kontraksi dini (perut sering kencang sebelum waktunya)",
  ];

  final Map<String, int> complaintSeverity = {
    "Mual dan muntah": 0, "Kembung": 0, "Maag / nyeri ulu hati": 1,
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
    super.dispose();
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

  // TAMBAHKAN METHOD _getRecommendation YANG HILANG
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

  // Tambahkan metode baru untuk menghitung risiko berdasarkan formula
  Map<String, dynamic> calculateRiskBasedOnFormula() {
    // Hitung skor sesuai formula
    int totalScore = _calculateScore();
    bool hasRedFlag = _hasRedFlag;

    // Tentukan risk level berdasarkan formula
    String riskLevel;
    if (hasRedFlag || totalScore >= 4) {
      riskLevel = "Risiko Tinggi";
    } else if (totalScore >= 2 || (totalScore == 1 && hasRedFlag)) {
      riskLevel = "Perlu Perhatian";
    } else {
      riskLevel = "Normal";
    }

    // Dapatkan rekomendasi berdasarkan risk level
    String recommendation = _getRecommendation(riskLevel);

    // Dapatkan edukasi
    _riskLevelEducation = RiskEducationData.getEducation(riskLevel);

    return {
      'riskLevel': riskLevel.toLowerCase(),
      'score': totalScore, // Skor asli (0-23)
      'recommendation': recommendation,
      'details': _redFlagReasons,
      'complaintEducations': _selectedComplaintEducations,
      'riskEducation': _riskLevelEducation,
      'generalTips': getGeneralPregnancyTips(),
      'hasRedFlag': hasRedFlag,
    };
  }

  // PERBAIKI metode calculateRisk yang sudah ada:
  void calculateRisk() {
    _score = _calculateScore(); // Hapus .toDouble(), karena _score sudah int

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

    _riskLevelEducation = RiskEducationData.getEducation(result);
    notifyListeners();
  }

  int _calculateScore() {
    int totalScore = 0;
    _hasRedFlag = false;
    _redFlagReasons.clear();
    _selectedComplaintEducations.clear();

    totalScore += _assessVitalData();
    totalScore += _assessComplaints();
    totalScore += _assessPregnancyHistory();
    totalScore += _assessHealthHistory();
    totalScore += _assessPhysicalData();
    totalScore += _assessMenstrualPregnancyData();
    totalScore += _assessLifestyleData();

    return totalScore;
  }

  int _assessComplaints() {
    int score = 0;
    List<String> selectedComplaints = complaintSelected.entries
        .where((element) => element.value)
        .map((e) => e.key)
        .toList();

    for (var complaint in selectedComplaints) {
      int severity = complaintSeverity[complaint] ?? 0;
      score += severity;

      // Simpan edukasi untuk keluhan yang dipilih
      var education = ComplaintEducationData.getEducation(complaint);
      if (education != null) {
        _selectedComplaintEducations[complaint] = education;
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

    // Blood Pressure Assessment
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

    // Temperature Assessment
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

    // Pulse Assessment
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

    // Respiration Assessment
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

    // Check for previous complications
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
        break; // Count only the most serious complication
      }
    }

    return score;
  }

  int _assessHealthHistory() {
    int score = 0;

    String diseaseHistory = diseaseHistoryController.text.toLowerCase();

    // Serious chronic conditions
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

    // Mild conditions
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

    // BMI Assessment
    if (bmiValue != null) {
      if (bmiValue! >= 30) {
        score += 2;
        _hasRedFlag = true;
        _redFlagReasons.add("Obesitas (IMT: ${bmiValue!.toStringAsFixed(1)})");
      } else if (bmiValue! < 18.5 || bmiValue! >= 25) {
        score += 1;
      }
    }

    // LILA Assessment
    double? lila = double.tryParse(lilaController.text);
    if (lila != null && lila < 23.5) {
      score += 1;
    }

    return score;
  }

  int _assessMenstrualPregnancyData() {
    int score = 0;

    // Check for irregular menstrual cycle
    String cycle = menstrualCycleController.text.toLowerCase();
    if (cycle.contains("tidak teratur")) {
      score += 1;
    }

    // Check ultrasound results
    String ultrasound = ultrasoundResultController.text.toLowerCase();
    if (ultrasound.contains("masalah") || ultrasound.contains("abnormal")) {
      score += 2;
      _hasRedFlag = true;
      _redFlagReasons.add("Hasil USG menunjukkan masalah");
    }

    // Check fetal movement
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

    // Age Assessment
    int? age = int.tryParse(currentAgeController.text);
    if (age != null && (age < 20 || age > 35)) {
      score += 1;
    }

    // Smoking Assessment
    if (smokingStatus["Merokok"] == true) {
      score += 2;
      _hasRedFlag = true;
      _redFlagReasons.add("Kebiasaan merokok");
    } else if (smokingStatus["Terpapar asap rokok"] == true) {
      score += 1;
    }

    // Alcohol/Drug Assessment
    if (alcoholDrugStatus["Mengonsumsi alkohol"] == true ||
        alcoholDrugStatus["Mengonsumsi obat terlarang"] == true) {
      score += 2;
      _hasRedFlag = true;
      _redFlagReasons.add("Konsumsi alkohol/obat terlarang");
    }

    // Family Support Assessment
    String support = familySupportController.text.toLowerCase();
    if (support.contains("tidak") || support.contains("minim")) {
      score += 1;
    }

    return score;
  }

  bool validateCurrentPage() {
    switch (_currentPage) {
      case 0: // Data Vital
        return _validateVitalData();
      case 1: // Keluhan
        return true; // No validation needed for checkboxes
      case 2: // Riwayat Kehamilan & Persalinan
        return _validatePregnancyHistory();
      case 3: // Riwayat Kesehatan
        return true; // No mandatory fields
      case 4: // Data Fisik
        return _validatePhysicalData();
      case 5: // Data Haid & Kehamilan
        return _selectedLMPDate != null;
      case 6: // Faktor Sosial & Gaya Hidup
        return _validateLifestyleData();
      default:
        return true;
    }
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

    bool allValid = true;
    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        allValid = false;
      }
    }

    return allValid;
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

    bool allValid = true;
    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        allValid = false;
      }
    }

    return allValid;
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

    bool allValid = true;
    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        allValid = false;
      }
    }

    return allValid;
  }

  bool _validateLifestyleData() {
    final validators = [
          (value) => value.isEmpty ? 'Usia saat ini harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
    ];

    final controllers = [
      currentAgeController,
    ];

    bool allValid = true;
    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        allValid = false;
      }
    }

    return allValid;
  }

  // Method untuk mendapatkan tips umum
  List<String> getGeneralPregnancyTips() {
    return PregnancyTipsData.getTips();
  }
}