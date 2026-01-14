// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'BUMILKU';

  @override
  String get selfDetection => 'Self Detection';

  @override
  String get selfDetectionDesc =>
      'Mari deteksi kondisi kehamilan Anda sekarang';

  @override
  String get checkHistory => 'Riwayat Pemeriksaan';

  @override
  String get checkHistoryDesc =>
      'Riwayat pemeriksaan ini adalah riwayat yang dihasilkan dari self detection';

  @override
  String get maternalNursingTitle => 'Apa itu Keperawatan Maternitas?';

  @override
  String get maternalNursingDesc =>
      'Keperawatan maternitas adalah cabang keperawatan yang fokus pada kesehatan';

  @override
  String get faqTitle => 'Pertanyaan Umum';

  @override
  String get faqDesc =>
      'Mari baca pertanyaan yang sering kali ditanyakan saat hamil';

  @override
  String get noPregnancyData => 'Belum ada data kehamilan';

  @override
  String get addPregnancy => 'Tambah Kehamilan';

  @override
  String get tryAgain => 'Coba Lagi';

  @override
  String get medicalDataNotAvailable => 'Data medis belum tersedia';

  @override
  String get addFirstPregnancy => 'Tambah Kehamilan Pertama';

  @override
  String get logoutConfirmTitle => 'Konfirmasi Logout';

  @override
  String get logoutConfirmDesc =>
      'Apakah Anda yakin ingin logout dari aplikasi BUMILKU?';

  @override
  String get cancel => 'Batal';

  @override
  String get logout => 'Logout';

  @override
  String get addPregnancyNewTitle => 'Tambah Kehamilan Baru';

  @override
  String get addPregnancyNewDesc =>
      'Apakah Anda ingin menambah data kehamilan baru?';

  @override
  String get add => 'Tambah';

  @override
  String get pregnancyCalendarTitle => 'Kalender Kehamilan';

  @override
  String get edit => 'Edit';

  @override
  String get lastPeriodLabel => 'Haid pertama terakhir';

  @override
  String get dueDateLabel => 'Prediksi melahirkan';

  @override
  String get setPeriodInfoTitle => 'Atur Informasi Haid';

  @override
  String get setPeriodInfoDesc =>
      'Hari Pertama Haid Terakhir (LMP) adalah hari pertama menstruasi terakhir Anda. Data ini digunakan untuk menghitung usia kehamilan dan memperkirakan Hari Perkiraan Lahir (HPL).';

  @override
  String get lmpDateLabel => 'Tanggal Hari Pertama Haid Terakhir';

  @override
  String get cycleLengthLabel => 'Panjang Siklus Menstruasi';

  @override
  String get daysUnit => 'hari';

  @override
  String get save => 'Simpan';

  @override
  String pregnancyWeekInfo(int weeks) {
    return 'Anda memasuki minggu ke-$weeks usia kehamilan';
  }

  @override
  String get selfDetectionTitle => 'Deteksi Mandiri Ibu Hamil';

  @override
  String get detectionHistory => 'Riwayat Deteksi';

  @override
  String get back => 'Kembali';

  @override
  String get next => 'Lanjut';

  @override
  String get calculateRisk => 'Hitung Risiko';

  @override
  String get completeStepData => 'Harap lengkapi data pada langkah ini.';

  @override
  String get signUpNewAccountTitle => 'Daftar Akun Baru';

  @override
  String get emailHint => 'Email';

  @override
  String get emailRequired => 'Email wajib diisi';

  @override
  String get emailInvalid => 'Format email tidak valid';

  @override
  String get passwordHint => 'Password';

  @override
  String get confirmPasswordHint => 'Konfirmasi Password';

  @override
  String get passwordRequired => 'Password wajib diisi';

  @override
  String get passwordMin6 => 'Password minimal 6 karakter';

  @override
  String get confirmPasswordRequired => 'Konfirmasi password wajib diisi';

  @override
  String get passwordNotMatch => 'Password tidak cocok';

  @override
  String get passwordStrengthLabel => 'Kekuatan Password:';

  @override
  String get passwordStrengthWeak => 'Lemah';

  @override
  String get passwordStrengthFair => 'Cukup';

  @override
  String get passwordStrengthGood => 'Baik';

  @override
  String get passwordStrengthStrong => 'Kuat';

  @override
  String get showPassword => 'Tampilkan password';

  @override
  String get hidePassword => 'Sembunyikan password';

  @override
  String get signUpButton => 'Daftar';

  @override
  String get signingUpLoading => 'Mendaftarkan...';

  @override
  String get signupWelcomeTitle => 'Selamat datang! 👋';

  @override
  String get signupWelcomeDesc =>
      'Sebelum mulai, mari berkenalan terlebih dahulu';

  @override
  String get signupNameLabel => 'Nama Bunda';

  @override
  String get signupNameHint => 'Masukkan nama Bunda';

  @override
  String get signupNameEmpty => 'Nama tidak boleh kosong';

  @override
  String get signupNameMin2 => 'Nama minimal 2 karakter';

  @override
  String get signupNameMax30 => 'Nama maksimal 30 karakter';

  @override
  String get signupAddressLabel => 'Alamat';

  @override
  String get signupAddressHint => 'Masukkan alamat lengkap';

  @override
  String get signupAddressEmpty => 'Alamat tidak boleh kosong';

  @override
  String get signupDobLabel => 'Tanggal Lahir';

  @override
  String get signupDobHint => 'Pilih tanggal lahir';

  @override
  String get signupDobRequired => 'Tanggal lahir wajib diisi';

  @override
  String get vitalTitle => 'Data Vital';

  @override
  String get vitalSystolicLabel => 'Sistolik (mmHg)';

  @override
  String get vitalDiastolicLabel => 'Diastolik (mmHg)';

  @override
  String get vitalTempLabel => 'Suhu tubuh (°C)';

  @override
  String get vitalPulseLabel => 'Nadi (x/menit)';

  @override
  String get vitalRespLabel => 'Frekuensi napas (x/menit)';

  @override
  String get vitalSystolicRequired => 'Sistolik harus diisi';

  @override
  String get vitalDiastolicRequired => 'Diastolik harus diisi';

  @override
  String get vitalTempRequired => 'Suhu tubuh harus diisi';

  @override
  String get vitalPulseRequired => 'Nadi harus diisi';

  @override
  String get vitalRespRequired => 'Frekuensi napas harus diisi';

  @override
  String get vitalValidNumber => 'Masukkan angka yang valid';

  @override
  String get vitalNormalTitle => 'Nilai Normal:';

  @override
  String get vitalNormalBpMain => '• Tekanan darah: 90/60 - 139/89 mmHg';

  @override
  String get vitalNormalBpSys => '   - Sistolik (atas): 90-139 mmHg';

  @override
  String get vitalNormalBpDia => '   - Diastolik (bawah): 60-89 mmHg';

  @override
  String get vitalNormalTemp => '• Suhu tubuh: 36 - 37.5°C';

  @override
  String get vitalNormalPulse => '• Nadi: 60 - 100 x/menit';

  @override
  String get vitalNormalResp => '• Frekuensi napas: 16 - 20 x/menit';

  @override
  String get complaintsTitle => 'Keluhan yang Dirasakan';

  @override
  String get complaintsLegendTitle => 'Keterangan:';

  @override
  String get complaintsLegendHigh => 'Keluhan berisiko tinggi';

  @override
  String get complaintsLegendMedium => 'Keluhan perlu perhatian';

  @override
  String get complaintsLegendNormal => 'Keluhan normal';

  @override
  String get complaintsPickInstruction =>
      'Pilih keluhan yang dialami saat ini:';

  @override
  String complaintsSelectedCount(int count) {
    return '$count keluhan dipilih';
  }

  @override
  String get fetalMoveTitle => 'Pencatatan Gerakan Janin';

  @override
  String get fetalMoveImportantInfoTitle => 'Informasi Penting';

  @override
  String fetalMoveImportantInfoDesc(int hours) {
    return 'Pencatatan gerakan janin dilakukan selama $hours jam. Gerakan janin normal: minimal 10 gerakan dalam $hours jam. Catat semua gerakan yang dirasakan dalam periode $hours jam.';
  }

  @override
  String get fetalMoveMainParams => 'Parameter Utama Pencatatan';

  @override
  String get fetalMoveMotherSubjective => 'Kondisi Subjektif Ibu';

  @override
  String get fetalMoveStartDateTimeLabel => 'Tanggal & Waktu Mulai Pencatatan';

  @override
  String get fetalMovePickDateTime => 'Pilih tanggal & waktu';

  @override
  String fetalMoveCountLabel(int hours) {
    return 'Jumlah Gerakan dalam $hours Jam';
  }

  @override
  String fetalMoveCountHint(int hours) {
    return 'Masukkan total gerakan dalam $hours jam';
  }

  @override
  String get fetalMoveTimesSuffix => 'kali';

  @override
  String get fetalMoveTargetHint => 'Target: minimal 10 gerakan dalam 12 jam';

  @override
  String fetalMoveDurationInfo(int hours) {
    return 'Durasi Pencatatan: $hours Jam';
  }

  @override
  String get fetalMoveActivityPatternLabel => 'Pola Aktivitas Janin';

  @override
  String get fetalMoveComparisonLabel =>
      'Perbandingan Gerakan dengan Hari Sebelumnya';

  @override
  String get fetalMoveOtherComplaintsLabel => 'Keluhan Lain yang Dirasakan';

  @override
  String get fetalPatternMorning => 'Lebih aktif pagi hari';

  @override
  String get fetalPatternAfternoon => 'Lebih aktif siang hari';

  @override
  String get fetalPatternNight => 'Lebih aktif malam hari';

  @override
  String get fetalPatternNoPattern => 'Tidak ada pola khusus';

  @override
  String get fetalCompareMoreActive => 'Lebih aktif';

  @override
  String get fetalCompareSame => 'Sama saja';

  @override
  String get fetalCompareLess => 'Lebih sedikit';

  @override
  String get fetalComplaintDizzyWeak => 'Pusing/lemas';

  @override
  String get fetalComplaintAbdominalPain => 'Nyeri perut';

  @override
  String get fetalComplaintNone => 'Tidak ada';

  @override
  String get fetalMoveErrorRequired => 'Jumlah gerakan harus diisi';

  @override
  String get fetalMoveErrorInvalidNumber => 'Masukkan angka yang valid';

  @override
  String get fetalMoveErrorNegative => 'Tidak boleh negatif';

  @override
  String get fetalMoveSummaryEmpty =>
      'Isi jumlah gerakan untuk melihat ringkasan';

  @override
  String fetalMoveSummaryMoves(int count, int hours, double perHour) {
    return 'Gerakan: $count kali dalam $hours jam ($perHour gerakan/jam)';
  }

  @override
  String get fetalMoveSummaryDetailTitle => 'Detail Pencatatan:';

  @override
  String fetalMoveSummaryDetailCount(int count) {
    return '• Jumlah gerakan: $count kali';
  }

  @override
  String fetalMoveSummaryDetailDuration(int hours) {
    return '• Durasi: $hours jam';
  }

  @override
  String get fetalMoveSummaryDetailTarget => '• Target minimal: 10 gerakan';

  @override
  String fetalMoveSummaryDetailPattern(String pattern) {
    return '• Pola: $pattern';
  }

  @override
  String fetalMoveSummaryDetailCompare(String compare) {
    return '• Perbandingan: $compare';
  }

  @override
  String fetalMoveSummaryDetailComplaints(String complaints) {
    return '• Keluhan: $complaints';
  }

  @override
  String get fetalStatusIncomplete => 'Data Belum Lengkap';

  @override
  String get fetalStatusNormal => 'Kondisi Normal';

  @override
  String get fetalStatusMonitoring => 'Perlu Pemantauan';

  @override
  String get fetalStatusAttention => 'Perlu Perhatian';

  @override
  String get fetalStatusEmergency => 'Perhatian Khusus';

  @override
  String fetalMsgNormal(int count, int hours) {
    return 'Gerakan janin dalam batas normal ($count gerakan dalam $hours jam).';
  }

  @override
  String fetalMsgMonitoring(int count, int hours) {
    return 'Gerakan janin $count kali dalam $hours jam. Tetap pantau secara rutin dan perhatikan perubahan gerakan.';
  }

  @override
  String fetalMsgAttention(int count, int hours) {
    return 'Gerakan janin $count kali dalam $hours jam. Disarankan konsultasi dengan tenaga kesehatan.';
  }

  @override
  String fetalMsgEmergency(int count, int hours) {
    return 'Gerakan janin hanya $count kali dalam $hours jam. Segera hubungi tenaga kesehatan.';
  }

  @override
  String get fetalMsgIncomplete =>
      'Lengkapi data pencatatan untuk analisis yang akurat.';

  @override
  String get complaintNauseaVomiting => 'Mual dan muntah';

  @override
  String get complaintBloating => 'Kembung';

  @override
  String get complaintHeartburn => 'Maag / nyeri ulu hati';

  @override
  String get complaintHeadache => 'Sakit kepala';

  @override
  String get complaintFetalMovement => 'Gerakan Janin';

  @override
  String get complaintAbdominalCramp => 'Kram perut';

  @override
  String get complaintVaginalDischarge => 'Keputihan';

  @override
  String get complaintCravings => 'Ngidam';

  @override
  String get complaintBleedingSpotting =>
      'Pendarahan / bercak dari jalan lahir';

  @override
  String get complaintSwelling => 'Bengkak pada kaki / tangan / wajah';

  @override
  String get complaintConstipation => 'Sembelit';

  @override
  String get complaintExcessiveFatigue => 'Kelelahan berlebihan';

  @override
  String get complaintSleepyDizzy => 'Ngantuk dan pusing';

  @override
  String get complaintMoodChanges => 'Perubahan mood';

  @override
  String get complaintSleepProblems => 'Masalah tidur';

  @override
  String get complaintLossOfAppetite => 'Hilang nafsu makan';

  @override
  String get complaintFastHeartbeat => 'Detak jantung cepat';

  @override
  String get complaintBackPain => 'Nyeri pinggang / punggung';

  @override
  String get complaintShortnessOfBreath => 'Sesak napas';

  @override
  String get complaintBlurredVision => 'Pandangan kabur / berkunang-kunang';

  @override
  String get complaintEarlyContractions =>
      'Kontraksi dini (perut sering kencang sebelum waktunya)';

  @override
  String get pregnancyHistoryTitle => 'Riwayat Kehamilan & Persalinan';

  @override
  String get pregnancyHistorySubtitle =>
      'Isilah sesuai dengan riwayat kehamilan dan persalinan sebelumnya';

  @override
  String get pregnancyHistoryChildrenCountLabel =>
      'Jumlah anak yang sudah lahir';

  @override
  String get pregnancyHistoryFirstPregnancyAgeLabel =>
      'Usia bunda saat pertama kali hamil';

  @override
  String get pregnancyHistoryPregnancyGapLabel =>
      'Jarak kehamilan dengan anak sebelumnya';

  @override
  String get pregnancyHistoryObstetricHistoryLabel =>
      'Riwayat Obstetrik atau riwayat kehamilan dan persalinan (riwayat keguguran, riwayat caesar, riwayat kelahiran prematur, riwayat hamil ektopik atau di luar kandungan, dll)';

  @override
  String get pregnancyHistoryDeliveryComplicationsLabel =>
      'Riwayat komplikasi persalinan (perdarahan, tekanan darah tinggi saat hamil, dll.)';

  @override
  String get pregnancyHistoryBabyWeightHistoryLabel =>
      'Riwayat bayi lahir (berat badan normal >=2.5 / besar >4 kg)';

  @override
  String get pregnancyHistoryPreviousPregnancyLabel =>
      'Riwayat kehamilan sebelumnya (normal/bermasalah/janin meninggal)';

  @override
  String get pregnancyHistoryExamplesTitle => 'Contoh pengisian:';

  @override
  String get pregnancyHistoryExampleObstetricLabel =>
      '• Riwayat obstetrik / kehamilan & persalinan sebelumnya';

  @override
  String get pregnancyHistoryExampleComplicationLabel =>
      '• Riwayat komplikasi persalinan';

  @override
  String get pregnancyHistoryExampleObstetricValue =>
      '• Riwayat obstetri: Pernah keguguran 1x, SC 1x';

  @override
  String get pregnancyHistoryExampleComplicationValue =>
      '• Komplikasi: Perdarahan pasca persalinan';

  @override
  String get pregnancyHistoryExampleBabyWeightValue =>
      '• Bayi lahir: Berat badan normal minimal 2.5 kg';

  @override
  String get validationRequiredChildrenCount => 'Jumlah anak harus diisi';

  @override
  String get validationRequiredFirstPregnancyAge =>
      'Usia pertama hamil harus diisi';

  @override
  String get validationInvalidNumber => 'Masukkan angka yang valid';

  @override
  String get unitYears => 'tahun';

  @override
  String get unitMonths => 'bulan';

  @override
  String get healthHistoryTitle => 'Riwayat Kesehatan Bunda';

  @override
  String get healthHistorySubtitle =>
      'Informasi ini membantu tenaga kesehatan memahami kondisi Anda';

  @override
  String get healthHistoryDiseaseLabel =>
      'Penyakit yang pernah/sedang diderita (tekanan darah tinggi, diabetes, jantung, dll.)';

  @override
  String get healthHistoryAllergyLabel =>
      'Riwayat alergi (obat/makanan/bahan tertentu)';

  @override
  String get healthHistorySurgeryLabel => 'Riwayat operasi (selain SC)';

  @override
  String get healthHistoryMedicationLabel =>
      'Konsumsi obat-obatan rutin (termasuk vitamin/herbal)';

  @override
  String get healthHistoryExamplesTitle => 'Contoh pengisian:';

  @override
  String get healthHistoryExampleDisease =>
      '• Penyakit: tekanan darah tinggi sejak 2020';

  @override
  String get healthHistoryExampleAllergy =>
      '• Alergi: Alergi antibiotik Amoxicillin';

  @override
  String get healthHistoryExampleSurgery => '• Operasi: Usus buntu tahun 2018';

  @override
  String get healthHistoryExampleMedication =>
      '• Obat: Obat tekanan darah tinggi rutin, vitamin prenatal';

  @override
  String get commonInvalidNumber => 'Masukkan angka yang valid';

  @override
  String get physicalDataTitle => 'Data Fisik Bunda';

  @override
  String get physicalDataSubtitle =>
      'Data ini digunakan untuk menghitung Indeks Massa Tubuh (IMT)';

  @override
  String get physicalDataHeightLabel => 'Tinggi badan (cm)';

  @override
  String get physicalDataWeightBeforeLabel => 'Berat badan sebelum hamil (kg)';

  @override
  String get physicalDataCurrentWeightLabel => 'Berat badan saat ini (kg)';

  @override
  String get physicalDataMuacLabel => 'Lingkar lengan atas (LILA) (cm)';

  @override
  String get physicalDataHeightRequired => 'Tinggi badan harus diisi';

  @override
  String get physicalDataWeightBeforeRequired =>
      'Berat sebelum hamil harus diisi';

  @override
  String get physicalDataCurrentWeightRequired => 'Berat saat ini harus diisi';

  @override
  String physicalDataBmiValue(String value) {
    return 'Indeks Massa Tubuh (IMT): $value';
  }

  @override
  String get physicalDataBmiCategoryUnderweight => 'Kategori: Kurus';

  @override
  String get physicalDataBmiCategoryNormal => 'Kategori: Normal';

  @override
  String get physicalDataBmiCategoryOverweight => 'Kategori: Kelebihan berat';

  @override
  String get physicalDataBmiCategoryObesity => 'Kategori: Obesitas';

  @override
  String get physicalDataNormalValuesTitle => 'Nilai Normal:';

  @override
  String get physicalDataNormalBmi => '• IMT normal: 18.5 - 24.9';

  @override
  String get physicalDataNormalMuac => '• LILA normal: ≥ 23.5 cm';

  @override
  String get physicalDataBmiUnderweightInfo => '• IMT < 18.5: Kurus';

  @override
  String get physicalDataBmiOverweightInfo => '• IMT ≥ 25: Kelebihan berat';

  @override
  String get physicalDataBmiObesityInfo => '• IMT ≥ 30: Obesitas';

  @override
  String get commonPickDate => 'Pilih tanggal';

  @override
  String get menstrualTitle => 'Data Haid & Kehamilan';

  @override
  String get menstrualSubtitle =>
      'Informasi ini membantu menentukan usia kehamilan';

  @override
  String get menstrualLmpLabel => 'Tanggal Hari Pertama Haid Terakhir (HPHT)*';

  @override
  String get menstrualLmpRequired => 'Tanggal haid terakhir harus diisi';

  @override
  String get menstrualCycleLabel => 'Siklus haid (teratur/tidak, berapa hari)';

  @override
  String get menstrualFetalMovementLabel =>
      'Gerakan janin (sudah terasa/belum/berkurang)';

  @override
  String get menstrualUltrasoundLabel =>
      'Hasil pemeriksaan USG (jika sudah ada)';

  @override
  String get menstrualPregnancyInfoTitle => 'Informasi Kehamilan:';

  @override
  String menstrualEddLine(String date) {
    return '• Perkiraan Hari Lahir (HPL): $date';
  }

  @override
  String menstrualGestationalAgeLine(String weeks) {
    return '• Usia kehamilan: $weeks minggu';
  }

  @override
  String get menstrualImportantInfoTitle => 'Informasi Penting:';

  @override
  String get menstrualImportantBullet1 =>
      '• HPHT digunakan untuk menghitung usia kehamilan';

  @override
  String get menstrualImportantBullet2 =>
      '• Gerakan janin biasanya terasa mulai minggu 18-20';

  @override
  String get menstrualImportantBullet3 =>
      '• USG membantu memastikan usia kehamilan dan perkembangan janin';

  @override
  String get lifestyleTitle => 'Faktor Sosial & Gaya Hidup';

  @override
  String get lifestyleSubtitle =>
      'Informasi ini membantu memahami faktor risiko dari gaya hidup';

  @override
  String get lifestyleAgeLabel => 'Usia bunda sekarang (tahun)';

  @override
  String get lifestyleSmokingTitle => 'Status merokok / paparan asap rokok';

  @override
  String get lifestyleAlcoholDrugTitle =>
      'Konsumsi alkohol / obat-obatan terlarang';

  @override
  String get lifestylePhysicalActivityLabel =>
      'Aktivitas fisik harian (aktif/ringan/banyak istirahat)';

  @override
  String get lifestyleFamilySupportLabel =>
      'Dukungan keluarga (ada/minim/tidak ada)';

  @override
  String get lifestyleRiskInfoTitle => 'Faktor Risiko Penting:';

  @override
  String get lifestyleRiskBullet1 =>
      '• Usia <20 atau >35 tahun meningkatkan risiko';

  @override
  String get lifestyleRiskBullet2 =>
      '• Merokok/paparan asap rokok berisiko untuk janin';

  @override
  String get lifestyleRiskBullet3 =>
      '• Alkohol/obat terlarang sangat berbahaya untuk kehamilan';

  @override
  String get lifestyleRiskBullet4 =>
      '• Dukungan keluarga penting untuk kesehatan mental';

  @override
  String get lifestyleSmokingNone => 'Tidak merokok';

  @override
  String get lifestyleSmokingActive => 'Merokok';

  @override
  String get lifestyleSmokingPassive => 'Terpapar asap rokok';

  @override
  String get lifestyleAlcoholNone => 'Tidak mengonsumsi';

  @override
  String get lifestyleAlcoholYes => 'Mengonsumsi alkohol';

  @override
  String get lifestyleDrugsYes => 'Mengonsumsi obat terlarang';

  @override
  String get errorAgeRequired => 'Usia saat ini harus diisi';

  @override
  String get errorInvalidNumber => 'Masukkan angka yang valid';

  @override
  String get selfDetectionLoading => 'Sedang menghitung risiko...';

  @override
  String get selfDetectionResultTitle => 'Hasil Deteksi Mandiri';

  @override
  String get saveResultTooltip => 'Simpan Hasil';

  @override
  String get totalRiskPointsLabel => 'Total Poin Risiko:';

  @override
  String get noSpecificRecommendation => 'Tidak ada rekomendasi spesifik';

  @override
  String get riskHigh => 'Risiko Tinggi';

  @override
  String get riskAttention => 'Perlu Perhatian';

  @override
  String get riskMonitoring => 'Perlu Pemantauan';

  @override
  String get riskNormal => 'Normal';

  @override
  String get unknown => 'Tidak Diketahui';

  @override
  String get identifiedRiskFactorsTitle => 'Faktor Risiko yang Teridentifikasi';

  @override
  String get complaintEducationTitle => 'Edukasi Keluhan';

  @override
  String get riskEducationTitle => 'Edukasi Risiko';

  @override
  String get healthyPregnancyTipsTitle => 'Tips Kehamilan Sehat';

  @override
  String get recommendationTitle => 'Rekomendasi';

  @override
  String get fetalMovementRecordTitle => 'Hasil Pencatatan Gerakan Janin';

  @override
  String get recordDetailTitle => 'Detail Pencatatan:';

  @override
  String get movementCountLabel => 'Jumlah Gerakan';

  @override
  String get recordDurationLabel => 'Durasi Pencatatan';

  @override
  String get movementsPerHourLabel => 'Gerakan per Jam';

  @override
  String get comparisonWithYesterdayLabel => 'Perbandingan dengan Kemarin';

  @override
  String get activityPatternLabel => 'Pola Aktivitas';

  @override
  String get noData => 'Tidak ada data';

  @override
  String get timesSuffix => 'kali';

  @override
  String get hoursSuffix => 'jam';

  @override
  String get movementsPerHourSuffix => 'gerakan/jam';

  @override
  String fetalMovementNormalStandard(Object value) {
    return 'Standar normal: minimal 10 gerakan dalam 12 jam ($value gerakan/jam)';
  }

  @override
  String get fetalMovementIncompleteTitle => 'Data Belum Lengkap';

  @override
  String get fetalMovementNormalTitle => 'Kondisi Normal';

  @override
  String get fetalMovementMonitoringTitle => 'Perlu Pemantauan';

  @override
  String get fetalMovementAttentionTitle => 'Perlu Perhatian';

  @override
  String get fetalMovementCriticalTitle => 'Perhatian Khusus';

  @override
  String get fetalMovementIncompleteMsg =>
      'Data gerakan janin belum lengkap. Silakan lengkapi pencatatan.';

  @override
  String fetalMovementNormalMsg(Object count) {
    return 'Gerakan janin dalam batas normal ($count gerakan dalam 12 jam).';
  }

  @override
  String fetalMovementMonitoringMsg(Object count) {
    return 'Gerakan janin $count kali dalam 12 jam. Tetap pantau secara rutin dan perhatikan perubahan gerakan.';
  }

  @override
  String fetalMovementAttentionMsg(Object count) {
    return 'Gerakan janin $count kali dalam 12 jam. Disarankan konsultasi dengan tenaga kesehatan.';
  }

  @override
  String fetalMovementCriticalMsg(Object count) {
    return 'Gerakan janin hanya $count kali dalam 12 jam. Segera hubungi tenaga kesehatan.';
  }

  @override
  String get saveDetectionResultButton => 'Simpan Hasil Deteksi';

  @override
  String get backToSelfDetectionButton => 'Kembali ke Deteksi Mandiri';

  @override
  String get saveResultDialogTitle => 'Simpan Hasil Deteksi';

  @override
  String get saveResultDialogMessage =>
      'Apakah Anda ingin menyimpan hasil deteksi ini? Hasil akan disimpan dalam riwayat deteksi.';

  @override
  String get saveSuccessSnack => 'Hasil deteksi berhasil disimpan!';

  @override
  String get riskMsgHigh =>
      'Gerakan janin sangat berkurang. Segera hubungi tenaga kesehatan.';

  @override
  String get riskMsgAttention =>
      'Gerakan janin berkurang. Disarankan konsultasi dengan tenaga kesehatan.';

  @override
  String get riskMsgMonitoring =>
      'Gerakan janin mendekati batas minimal. Pantau rutin dan perhatikan perubahan.';

  @override
  String get riskMsgNormal =>
      'Gerakan janin dalam batas normal. Lanjutkan pemantauan rutin.';

  @override
  String get riskMsgUnknown => 'Data belum lengkap atau tidak valid.';

  @override
  String get historyTitle => 'Riwayat Deteksi';

  @override
  String get historySectionTitle => 'Riwayat Deteksi Mandiri';

  @override
  String get historyErrorTitle => 'Terjadi kesalahan';

  @override
  String get historyRetry => 'Coba Lagi';

  @override
  String get historyEmptyTitle => 'Belum ada riwayat deteksi';

  @override
  String get historyEmptySubtitle =>
      'Hasil deteksi mandiri akan muncul di sini';

  @override
  String get historyStartDetectionNow => 'Lakukan Self Detection Sekarang';

  @override
  String get historyUserDataUnavailable => 'Data tidak tersedia';

  @override
  String get historyPleaseRelogin => 'Silakan login ulang';

  @override
  String get historyFetalMovementLabel => 'Gerakan Janin';

  @override
  String get historyDetailLabel => 'Detail';

  @override
  String get historyStatusLabel => 'Status';

  @override
  String historyAgeYears(int age) {
    return '$age tahun';
  }

  @override
  String historyDetailCount(int count) {
    return '$count faktor';
  }

  @override
  String get riskLevelHigh => 'Risiko Tinggi';

  @override
  String get riskLevelNeedAttention => 'Perlu Perhatian';

  @override
  String get riskLevelNeedMonitoring => 'Perlu Pemantauan';

  @override
  String get riskLevelNormal => 'Normal';

  @override
  String get riskLevelUnknown => 'Tidak Diketahui';

  @override
  String get riskStatusNeedsTreatment => 'Perlu Penanganan';

  @override
  String get riskStatusNeedsAttention => 'Perlu Perhatian';

  @override
  String get riskStatusNeedsMonitoring => 'Perlu Pemantauan';

  @override
  String get riskStatusSafe => 'Aman';

  @override
  String get riskStatusUnknown => 'Tidak Diketahui';

  @override
  String get mothersListTitle => 'Daftar Bunda';

  @override
  String get searchNameOrUsernameHint => 'Cari nama atau username...';

  @override
  String get noMotherData => 'Belum ada data bunda';

  @override
  String get notFoundTitle => 'Tidak ditemukan';

  @override
  String noResultsForQuery(Object query) {
    return 'Tidak ada hasil untuk \'$query\'';
  }

  @override
  String get badgeMother => 'Bunda';

  @override
  String get yearsOldShort => 'tahun';

  @override
  String get languageTooltip => 'Bahasa';

  @override
  String get languageIndonesia => 'Indonesia';

  @override
  String get languageEnglish => 'English';

  @override
  String get logoutFailed => 'Logout gagal';

  @override
  String monitoringTitle(Object name) {
    return 'Monitoring $name';
  }

  @override
  String get refreshDataTooltip => 'Refresh Data';

  @override
  String get tabDevelopment => 'Perkembangan';

  @override
  String get tabSelfDetection => 'Self Detection';

  @override
  String ageYears(Object age) {
    return '$age tahun';
  }

  @override
  String get loadingPregnancyData => 'Memuat data kehamilan...';

  @override
  String get loadingDetectionHistory => 'Memuat riwayat deteksi...';

  @override
  String get loadingDataGeneric => 'Memuat data...';

  @override
  String get noPregnancyDataTitle => 'Belum Ada Data Kehamilan';

  @override
  String get noPregnancyDataSubtitle => 'Data kehamilan akan muncul di sini';

  @override
  String pregnancyNumber(Object n) {
    return 'Kehamilan $n';
  }

  @override
  String get activePregnancy => 'Kehamilan Aktif';

  @override
  String get pregnancyHistory => 'Riwayat Kehamilan';

  @override
  String get activeLabel => 'Aktif';

  @override
  String get babyNameLabel => '👶 Nama Bayi';

  @override
  String get babyNameNotSet => 'Belum diberi nama';

  @override
  String get lmpLabel => '📅 HPHT';

  @override
  String get eddLabel => '🎯 Perkiraan Lahir';

  @override
  String get cycleLabel => '🔄 Siklus';

  @override
  String cycleDaysValue(Object n) {
    return '$n hari';
  }

  @override
  String get pregnancyProgressTitle => 'Perkembangan Kehamilan';

  @override
  String trimesterWithValue(Object value) {
    return 'Trimester $value';
  }

  @override
  String get gestationalAgeLabel => 'Usia Kandungan';

  @override
  String gestationalAgeValue(Object weeks, Object days) {
    return '$weeks minggu $days hari';
  }

  @override
  String get daysToBirthLabel => 'Hari Menuju Lahir';

  @override
  String daysValue(Object n) {
    return '$n hari';
  }

  @override
  String get trimesterLabel => 'Trimester';

  @override
  String get timelineTitle => 'Timeline Perkembangan';

  @override
  String get trimester1 => 'Trimester 1';

  @override
  String get trimester2 => 'Trimester 2';

  @override
  String get trimester3 => 'Trimester 3';

  @override
  String get weekRange1_13 => 'Minggu 1-13';

  @override
  String get weekRange14_27 => 'Minggu 14-27';

  @override
  String get weekRange28_40 => 'Minggu 28-40';

  @override
  String dataCreatedAt(Object date) {
    return 'Data dibuat: $date';
  }

  @override
  String get fetalMovementMonitoringHeader => 'Pemantauan Gerakan Janin';

  @override
  String get selfDetectionHistoryHeader => 'Riwayat Self Detection';

  @override
  String get fetalMovementHistoryHeader => 'Riwayat Gerakan Janin';

  @override
  String get noSelfDetectionDataTitle => 'Belum Ada Data Self Detection';

  @override
  String get noSelfDetectionDataSubtitle =>
      'Data deteksi mandiri akan muncul di sini';

  @override
  String get noFetalMovementDataTitle => 'Belum Ada Data Gerakan Janin';

  @override
  String get noFetalMovementDataSubtitle =>
      'Data gerakan janin akan muncul di sini';

  @override
  String get fetalMovementStatsTitle => 'Statistik Gerakan Janin';

  @override
  String get avgMovementsLabel => 'Rata-rata Gerakan';

  @override
  String get normalSessionsLabel => 'Sesi Normal';

  @override
  String get totalSessionsLabel => 'Total Sesi';

  @override
  String get latestRecordDetailTitle => 'Detail Pencatatan Terbaru:';

  @override
  String get durationLabel => 'Durasi';

  @override
  String get comparisonLabel => 'Perbandingan';

  @override
  String get complaintsLabel => 'Keluhan';

  @override
  String get activityPatternShortLabel => 'Pola';

  @override
  String get comparisonShortLabel => 'Perbandingan';

  @override
  String timesValue(Object n) {
    return '$n kali';
  }

  @override
  String hoursValue(Object n) {
    return '$n jam';
  }

  @override
  String perHourValue(Object value) {
    return '$value/jam';
  }

  @override
  String get fetalMovementStandardTitle =>
      'Standar normal: minimal 10 gerakan dalam 12 jam';

  @override
  String fetalMovementStandardPerHour(Object value) {
    return '($value gerakan per jam)';
  }

  @override
  String movementsCountText(Object n) {
    return '$n gerakan';
  }

  @override
  String pointsValue(Object n) {
    return '$n poin';
  }

  @override
  String get detailLabel => 'Detail';

  @override
  String get statusLabel => 'Status';

  @override
  String get fetalMovementLabel => 'Gerakan Janin';

  @override
  String get recordedLabel => 'Tercatat';

  @override
  String factorsCount(Object n) {
    return '$n faktor';
  }

  @override
  String get riskNeedTreatment => 'Perlu Penanganan';

  @override
  String get riskNeedAttention => 'Perlu Perhatian';

  @override
  String get riskSafe => 'Aman';

  @override
  String get errorOccurredTitle => 'Terjadi Kesalahan';

  @override
  String get fetalMovementStatusIncomplete => 'Data Belum Lengkap';

  @override
  String get fetalMovementStatusNormal => 'Kondisi Normal';

  @override
  String get fetalMovementStatusMonitor => 'Perlu Pemantauan';

  @override
  String get fetalMovementStatusAttention => 'Perlu Perhatian';

  @override
  String get fetalMovementStatusUrgent => 'Perhatian Khusus';

  @override
  String get fetalMovementMsgIncomplete =>
      'Data gerakan janin belum lengkap. Silakan lengkapi pencatatan.';

  @override
  String fetalMovementMsgNormal(Object count) {
    return 'Gerakan janin dalam batas normal ($count gerakan dalam 12 jam).';
  }

  @override
  String fetalMovementMsgMonitor(Object count) {
    return 'Gerakan janin $count kali dalam 12 jam. Tetap pantau secara rutin dan perhatikan perubahan gerakan.';
  }

  @override
  String fetalMovementMsgAttention(Object count) {
    return 'Gerakan janin $count kali dalam 12 jam. Disarankan konsultasi dengan tenaga kesehatan.';
  }

  @override
  String fetalMovementMsgUrgent(Object count) {
    return 'Gerakan janin hanya $count kali dalam 12 jam. Segera hubungi tenaga kesehatan.';
  }

  @override
  String get deleteTooltip => 'Hapus';

  @override
  String get deleteBundaTitle => 'Hapus Data Bunda';

  @override
  String deleteBundaMessage(Object name) {
    return 'Yakin ingin menghapus data $name? Semua riwayat kehamilan & self detection akan ikut terhapus.';
  }

  @override
  String get delete => 'Hapus';

  @override
  String get deleteSuccess => 'Data berhasil dihapus';

  @override
  String deleteFailed(Object error) {
    return 'Gagal menghapus: $error';
  }

  @override
  String get signupHospitalLabel => 'Rumah Sakit';

  @override
  String get signupHospitalHint => 'Pilih rumah sakit';

  @override
  String get signupHospitalRequired => 'Rumah sakit wajib dipilih';

  @override
  String get hospitalRsudKisaDepok => 'RSUD Kisa Depok';

  @override
  String get hospitalRsiSultanAgung => 'RSI Sultan Agung';

  @override
  String get complaintsCustomHint => 'Tulis keluhan lain...';

  @override
  String get complaintsAddButton => 'Tambah';

  @override
  String get complaintsDuplicateError => 'Keluhan sudah ada';

  @override
  String get complaintsEmptyError => 'Keluhan tidak boleh kosong';

  @override
  String get tutorialTitle => 'Tutorial Aplikasi';

  @override
  String get tutorialSubtitle => 'Pelajari cara penggunaan';

  @override
  String get tutorialPreparing => 'Menyiapkan tutorial...';

  @override
  String get tutorialExpandTooltip => 'Perbesar Video';

  @override
  String get tutorialCollapseTooltip => 'Perkecil Video';

  @override
  String get tutorialStepsHeader => 'Langkah-langkah:';

  @override
  String get tutorialStep1Title => 'Tonton Video';

  @override
  String get tutorialStep1Desc => 'Simak video tutorial sampai selesai';

  @override
  String get tutorialStep2Title => 'Buat Akun';

  @override
  String get tutorialStep2Desc => 'Daftar dengan data diri yang valid';

  @override
  String get tutorialStep3Title => 'Jelajahi Fitur';

  @override
  String get tutorialStep3Desc => 'Temukan semua fitur menarik aplikasi';

  @override
  String get tutorialStep4Title => 'Nikmati Pengalaman';

  @override
  String get tutorialStep4Desc => 'Gunakan aplikasi dengan maksimal';

  @override
  String get tutorialGetStarted => 'Mulai Sekarang';

  @override
  String get skip => 'Skip';
}
