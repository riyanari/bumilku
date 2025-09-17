import 'package:flutter/material.dart';

class SelfDetectionController extends ChangeNotifier {
  int _currentPage = 0;
  DateTime? _selectedLMPDate;
  double _score = 0;
  double get score => _score;

  // Data Vital
  final TextEditingController bloodPressureController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController pulseController = TextEditingController();
  final TextEditingController respirationController = TextEditingController();

  // Data Fisik Bunda
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightBeforeController = TextEditingController();
  final TextEditingController currentWeightController = TextEditingController();
  final TextEditingController lilaController = TextEditingController();

  // Riwayat Kehamilan & Persalinan
  final TextEditingController childrenCountController = TextEditingController();
  final TextEditingController firstPregnancyAgeController = TextEditingController();
  final TextEditingController pregnancyGapController = TextEditingController();
  final TextEditingController obstetricHistoryController = TextEditingController();
  final TextEditingController deliveryComplicationController = TextEditingController();
  final TextEditingController babyWeightHistoryController = TextEditingController();
  final TextEditingController previousPregnancyController = TextEditingController();

  // Riwayat Kesehatan Bunda
  final TextEditingController diseaseHistoryController = TextEditingController();
  final TextEditingController allergyHistoryController = TextEditingController();
  final TextEditingController surgeryHistoryController = TextEditingController();
  final TextEditingController medicationController = TextEditingController();

  // Data Haid & Kehamilan
  final TextEditingController menstrualCycleController = TextEditingController();
  final TextEditingController ultrasoundResultController = TextEditingController();

  // Faktor Sosial & Gaya Hidup
  final TextEditingController currentAgeController = TextEditingController();
  final TextEditingController physicalActivityController = TextEditingController();
  final TextEditingController familySupportController = TextEditingController();

  // Keluhan utama
  final List<String> complaints = [
    "Mual dan muntah", "Kembung", "Maag / nyeri ulu hati", "Sakit kepala",
    "Kram perut", "Keputihan", "Ngidam", "Pendarahan / bercak dari jalan lahir",
    "Bengkak pada kaki / tangan / wajah", "Sembelit",
    "Kelelahan berlebihan", "Ngantuk dan pusing", "Perubahan mood",
    "Masalah tidur", "Hilang nafsu makan", "Detak jantung cepat",
    "Nyeri pinggang / punggung", "Sesak napas", "Pandangan kabur / berkunang-kunang",
    "Kontraksi dini (perut sering kencang sebelum waktunya)",
  ];

  final Map<String, bool> complaintSelected = {};
  final Map<String, bool> smokingStatus = {
    "Tidak merokok": true,
    "Merokok": false,
    "Terpapar asap rokok": false,
  };

  final Map<String, bool> alcoholDrugStatus = {
    "Tidak mengonsumsi": true,
    "Mengonsumsi alkohol": false,
    "Mengonsumsi obat terlarang": false,
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
    // Initialize complaint selection map
    for (var c in complaints) {
      complaintSelected[c] = false;
    }

    // Add listeners for BMI calculation
    heightController.addListener(_calculateBMI);
    currentWeightController.addListener(_calculateBMI);
  }

  @override
  void dispose() {
    // Dispose all controllers
    bloodPressureController.dispose();
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

  double _calculateScore() {
    double calculatedScore = 50; // Skor dasar (netral)

    // 1. Faktor Usia
    int? age = int.tryParse(currentAgeController.text);
    if (age != null) {
      if (age < 18 || age > 35) {
        calculatedScore += 15; // Usia berisiko
      } else {
        calculatedScore -= 5; // Usia ideal
      }
    }

    // 2. Faktor Tekanan Darah
    double? bp = double.tryParse(bloodPressureController.text);
    if (bp != null) {
      if (bp > 140) {
        calculatedScore += 20; // Hipertensi
      } else if (bp < 90) {
        calculatedScore += 10; // Hipotensi
      } else {
        calculatedScore -= 5; // Normal
      }
    }

    // 3. Faktor Suhu
    double? temp = double.tryParse(temperatureController.text);
    if (temp != null && temp > 38) {
      calculatedScore += 15; // Demam
    }

    // 4. Faktor BMI
    if (bmiValue != null) {
      if (bmiValue! < 18.5) {
        calculatedScore += 12; // Underweight
      } else if (bmiValue! > 25) {
        calculatedScore += 10; // Overweight
      } else {
        calculatedScore -= 3; // Normal
      }
    }

    // 5. Faktor Keluhan Berisiko Tinggi
    List<String> selectedComplaints = complaintSelected.entries
        .where((element) => element.value)
        .map((e) => e.key)
        .toList();

    // Keluhan yang meningkatkan skor risiko
    const highRiskComplaints = [
      "Pendarahan / bercak dari jalan lahir",
      "Bengkak pada kaki / tangan / wajah",
      "Sesak napas",
      "Pandangan kabur / berkunang-kunang",
      "Kontraksi dini (perut sering kencang sebelum waktunya)"
    ];

    for (var complaint in selectedComplaints) {
      if (highRiskComplaints.contains(complaint)) {
        calculatedScore += 8; // Setiap keluhan berisiko tinggi
      } else {
        calculatedScore += 3; // Keluhan normal
      }
    }

    // 6. Faktor Riwayat Kehamilan
    int? childrenCount = int.tryParse(childrenCountController.text);
    if (childrenCount != null && childrenCount > 3) {
      calculatedScore += 5; // Multigravida
    }

    // 7. Faktor Gaya Hidup
    if (smokingStatus["Merokok"] == true) {
      calculatedScore += 15;
    } else if (smokingStatus["Terpapar asap rokok"] == true) {
      calculatedScore += 8;
    }

    if (alcoholDrugStatus["Mengonsumsi alkohol"] == true ||
        alcoholDrugStatus["Mengonsumsi obat terlarang"] == true) {
      calculatedScore += 20;
    }

    // Normalisasi skor antara 0-100
    return calculatedScore.clamp(0, 100).toDouble();
  }

  void calculateRisk() {
    _score = _calculateScore();

    List<String> riskFactors = [];
    String explanation = "";

    // Analisis faktor risiko
    int? age = int.tryParse(currentAgeController.text);
    if (age != null && (age < 18 || age > 35)) {
      riskFactors.add("Usia ${age < 18 ? "terlalu muda (<18)" : "terlalu tua (>35)"}");
    }

    double? bp = double.tryParse(bloodPressureController.text);
    if (bp != null && bp > 140) {
      riskFactors.add("Tekanan darah tinggi ($bp mmHg)");
    }

    if (bmiValue != null && bmiValue! < 18.5) {
      riskFactors.add("IMT rendah (${bmiValue!.toStringAsFixed(1)})");
    } else if (bmiValue != null && bmiValue! > 25) {
      riskFactors.add("IMT tinggi (${bmiValue!.toStringAsFixed(1)})");
    }

    // Keluhan berisiko tinggi
    List<String> selectedComplaints = complaintSelected.entries
        .where((element) => element.value)
        .map((e) => e.key)
        .toList();

    const highRiskComplaints = [
      "Pendarahan / bercak dari jalan lahir",
      "Bengkak pada kaki / tangan / wajah",
      "Sesak napas",
      "Pandangan kabur / berkunang-kunang",
      "Kontraksi dini (perut sering kencang sebelum waktunya)"
    ];

    for (var complaint in selectedComplaints) {
      if (highRiskComplaints.contains(complaint)) {
        riskFactors.add("Keluhan: $complaint");
      }
    }

    // Tentukan tingkat risiko berdasarkan skor
    if (_score >= 70) {
      result = "Risiko tinggi";
      recommendation = "Segera konsultasi ke tenaga kesehatan atau rumah sakit.";
    } else if (_score >= 40) {
      result = "Perlu perhatian";
      recommendation = "Perlu pemantauan lebih lanjut dan konsultasi dengan bidan/dokter.";
    } else {
      result = "Kehamilan normal";
      recommendation = "Tetap lakukan kontrol rutin kehamilan dan pertahankan gaya hidup sehat.";
    }

    // Tambahkan penjelasan faktor risiko
    if (riskFactors.isNotEmpty) {
      explanation = "Faktor risiko yang teridentifikasi:\n• ${riskFactors.join('\n• ')}";
      recommendation += "\n\n$explanation";
    }

    notifyListeners();
  }

  List<String> getRiskFactors() {
    List<String> factors = [];

    int? age = int.tryParse(currentAgeController.text);
    if (age != null && (age < 18 || age > 35)) {
      factors.add("Usia ${age < 18 ? "terlalu muda (<18)" : "terlalu tua (>35)"}");
    }

    double? bp = double.tryParse(bloodPressureController.text);
    if (bp != null && bp > 140) {
      factors.add("Tekanan darah tinggi ($bp mmHg)");
    }

    if (bmiValue != null && bmiValue! < 18.5) {
      factors.add("IMT rendah (${bmiValue!.toStringAsFixed(1)})");
    } else if (bmiValue != null && bmiValue! > 25) {
      factors.add("IMT tinggi (${bmiValue!.toStringAsFixed(1)})");
    }

    // Tambahkan faktor risiko lainnya sesuai kebutuhan

    return factors;
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
          (value) => value.isEmpty ? 'Tekanan darah harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Suhu tubuh harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Nadi harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Frekuensi napas harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
    ];

    final controllers = [
      bloodPressureController,
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
}