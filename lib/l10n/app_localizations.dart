import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appName.
  ///
  /// In id, this message translates to:
  /// **'BUMILKU'**
  String get appName;

  /// No description provided for @selfDetection.
  ///
  /// In id, this message translates to:
  /// **'Self Detection'**
  String get selfDetection;

  /// No description provided for @selfDetectionDesc.
  ///
  /// In id, this message translates to:
  /// **'Mari deteksi kondisi kehamilan Anda sekarang'**
  String get selfDetectionDesc;

  /// No description provided for @checkHistory.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Pemeriksaan'**
  String get checkHistory;

  /// No description provided for @checkHistoryDesc.
  ///
  /// In id, this message translates to:
  /// **'Riwayat pemeriksaan ini adalah riwayat yang dihasilkan dari self detection'**
  String get checkHistoryDesc;

  /// No description provided for @maternalNursingTitle.
  ///
  /// In id, this message translates to:
  /// **'Apa itu Keperawatan Maternitas?'**
  String get maternalNursingTitle;

  /// No description provided for @maternalNursingDesc.
  ///
  /// In id, this message translates to:
  /// **'Keperawatan maternitas adalah cabang keperawatan yang fokus pada kesehatan'**
  String get maternalNursingDesc;

  /// No description provided for @faqTitle.
  ///
  /// In id, this message translates to:
  /// **'Pertanyaan Umum'**
  String get faqTitle;

  /// No description provided for @faqDesc.
  ///
  /// In id, this message translates to:
  /// **'Mari baca pertanyaan yang sering kali ditanyakan saat hamil'**
  String get faqDesc;

  /// No description provided for @noPregnancyData.
  ///
  /// In id, this message translates to:
  /// **'Belum ada data kehamilan'**
  String get noPregnancyData;

  /// No description provided for @addPregnancy.
  ///
  /// In id, this message translates to:
  /// **'Tambah Kehamilan'**
  String get addPregnancy;

  /// No description provided for @tryAgain.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get tryAgain;

  /// No description provided for @medicalDataNotAvailable.
  ///
  /// In id, this message translates to:
  /// **'Data medis belum tersedia'**
  String get medicalDataNotAvailable;

  /// No description provided for @addFirstPregnancy.
  ///
  /// In id, this message translates to:
  /// **'Tambah Kehamilan Pertama'**
  String get addFirstPregnancy;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Logout'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmDesc.
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda yakin ingin logout dari aplikasi BUMILKU?'**
  String get logoutConfirmDesc;

  /// No description provided for @cancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get cancel;

  /// No description provided for @logout.
  ///
  /// In id, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @addPregnancyNewTitle.
  ///
  /// In id, this message translates to:
  /// **'Tambah Kehamilan Baru'**
  String get addPregnancyNewTitle;

  /// No description provided for @addPregnancyNewDesc.
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda ingin menambah data kehamilan baru?'**
  String get addPregnancyNewDesc;

  /// No description provided for @add.
  ///
  /// In id, this message translates to:
  /// **'Tambah'**
  String get add;

  /// No description provided for @pregnancyCalendarTitle.
  ///
  /// In id, this message translates to:
  /// **'Kalender Kehamilan'**
  String get pregnancyCalendarTitle;

  /// No description provided for @edit.
  ///
  /// In id, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @lastPeriodLabel.
  ///
  /// In id, this message translates to:
  /// **'Haid pertama terakhir'**
  String get lastPeriodLabel;

  /// No description provided for @dueDateLabel.
  ///
  /// In id, this message translates to:
  /// **'Prediksi melahirkan'**
  String get dueDateLabel;

  /// No description provided for @setPeriodInfoTitle.
  ///
  /// In id, this message translates to:
  /// **'Atur Informasi Haid'**
  String get setPeriodInfoTitle;

  /// No description provided for @setPeriodInfoDesc.
  ///
  /// In id, this message translates to:
  /// **'Hari Pertama Haid Terakhir (LMP) adalah hari pertama menstruasi terakhir Anda. Data ini digunakan untuk menghitung usia kehamilan dan memperkirakan Hari Perkiraan Lahir (HPL).'**
  String get setPeriodInfoDesc;

  /// No description provided for @lmpDateLabel.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Hari Pertama Haid Terakhir'**
  String get lmpDateLabel;

  /// No description provided for @cycleLengthLabel.
  ///
  /// In id, this message translates to:
  /// **'Panjang Siklus Menstruasi'**
  String get cycleLengthLabel;

  /// No description provided for @daysUnit.
  ///
  /// In id, this message translates to:
  /// **'hari'**
  String get daysUnit;

  /// No description provided for @save.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get save;

  /// No description provided for @pregnancyWeekInfo.
  ///
  /// In id, this message translates to:
  /// **'Anda memasuki minggu ke-{weeks} usia kehamilan'**
  String pregnancyWeekInfo(int weeks);

  /// No description provided for @selfDetectionTitle.
  ///
  /// In id, this message translates to:
  /// **'Deteksi Mandiri Ibu Hamil'**
  String get selfDetectionTitle;

  /// No description provided for @detectionHistory.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Deteksi'**
  String get detectionHistory;

  /// No description provided for @back.
  ///
  /// In id, this message translates to:
  /// **'Kembali'**
  String get back;

  /// No description provided for @next.
  ///
  /// In id, this message translates to:
  /// **'Lanjut'**
  String get next;

  /// No description provided for @calculateRisk.
  ///
  /// In id, this message translates to:
  /// **'Hitung Risiko'**
  String get calculateRisk;

  /// No description provided for @completeStepData.
  ///
  /// In id, this message translates to:
  /// **'Harap lengkapi data pada langkah ini.'**
  String get completeStepData;

  /// No description provided for @signUpNewAccountTitle.
  ///
  /// In id, this message translates to:
  /// **'Daftar Akun Baru'**
  String get signUpNewAccountTitle;

  /// No description provided for @emailHint.
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @emailRequired.
  ///
  /// In id, this message translates to:
  /// **'Email wajib diisi'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In id, this message translates to:
  /// **'Format email tidak valid'**
  String get emailInvalid;

  /// No description provided for @passwordHint.
  ///
  /// In id, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Password'**
  String get confirmPasswordHint;

  /// No description provided for @passwordRequired.
  ///
  /// In id, this message translates to:
  /// **'Password wajib diisi'**
  String get passwordRequired;

  /// No description provided for @passwordMin6.
  ///
  /// In id, this message translates to:
  /// **'Password minimal 6 karakter'**
  String get passwordMin6;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi password wajib diisi'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordNotMatch.
  ///
  /// In id, this message translates to:
  /// **'Password tidak cocok'**
  String get passwordNotMatch;

  /// No description provided for @passwordStrengthLabel.
  ///
  /// In id, this message translates to:
  /// **'Kekuatan Password:'**
  String get passwordStrengthLabel;

  /// No description provided for @passwordStrengthWeak.
  ///
  /// In id, this message translates to:
  /// **'Lemah'**
  String get passwordStrengthWeak;

  /// No description provided for @passwordStrengthFair.
  ///
  /// In id, this message translates to:
  /// **'Cukup'**
  String get passwordStrengthFair;

  /// No description provided for @passwordStrengthGood.
  ///
  /// In id, this message translates to:
  /// **'Baik'**
  String get passwordStrengthGood;

  /// No description provided for @passwordStrengthStrong.
  ///
  /// In id, this message translates to:
  /// **'Kuat'**
  String get passwordStrengthStrong;

  /// No description provided for @showPassword.
  ///
  /// In id, this message translates to:
  /// **'Tampilkan password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In id, this message translates to:
  /// **'Sembunyikan password'**
  String get hidePassword;

  /// No description provided for @signUpButton.
  ///
  /// In id, this message translates to:
  /// **'Daftar'**
  String get signUpButton;

  /// No description provided for @signingUpLoading.
  ///
  /// In id, this message translates to:
  /// **'Mendaftarkan...'**
  String get signingUpLoading;

  /// No description provided for @signupWelcomeTitle.
  ///
  /// In id, this message translates to:
  /// **'Selamat datang! 👋'**
  String get signupWelcomeTitle;

  /// No description provided for @signupWelcomeDesc.
  ///
  /// In id, this message translates to:
  /// **'Sebelum mulai, mari berkenalan terlebih dahulu'**
  String get signupWelcomeDesc;

  /// No description provided for @signupNameLabel.
  ///
  /// In id, this message translates to:
  /// **'Nama Bunda'**
  String get signupNameLabel;

  /// No description provided for @signupNameHint.
  ///
  /// In id, this message translates to:
  /// **'Masukkan nama Bunda'**
  String get signupNameHint;

  /// No description provided for @signupNameEmpty.
  ///
  /// In id, this message translates to:
  /// **'Nama tidak boleh kosong'**
  String get signupNameEmpty;

  /// No description provided for @signupNameMin2.
  ///
  /// In id, this message translates to:
  /// **'Nama minimal 2 karakter'**
  String get signupNameMin2;

  /// No description provided for @signupNameMax30.
  ///
  /// In id, this message translates to:
  /// **'Nama maksimal 30 karakter'**
  String get signupNameMax30;

  /// No description provided for @signupAddressLabel.
  ///
  /// In id, this message translates to:
  /// **'Alamat'**
  String get signupAddressLabel;

  /// No description provided for @signupAddressHint.
  ///
  /// In id, this message translates to:
  /// **'Masukkan alamat lengkap'**
  String get signupAddressHint;

  /// No description provided for @signupAddressEmpty.
  ///
  /// In id, this message translates to:
  /// **'Alamat tidak boleh kosong'**
  String get signupAddressEmpty;

  /// No description provided for @signupDobLabel.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Lahir'**
  String get signupDobLabel;

  /// No description provided for @signupDobHint.
  ///
  /// In id, this message translates to:
  /// **'Pilih tanggal lahir'**
  String get signupDobHint;

  /// No description provided for @signupDobRequired.
  ///
  /// In id, this message translates to:
  /// **'Tanggal lahir wajib diisi'**
  String get signupDobRequired;

  /// No description provided for @vitalTitle.
  ///
  /// In id, this message translates to:
  /// **'Data Vital'**
  String get vitalTitle;

  /// No description provided for @vitalSystolicLabel.
  ///
  /// In id, this message translates to:
  /// **'Sistolik (mmHg)'**
  String get vitalSystolicLabel;

  /// No description provided for @vitalDiastolicLabel.
  ///
  /// In id, this message translates to:
  /// **'Diastolik (mmHg)'**
  String get vitalDiastolicLabel;

  /// No description provided for @vitalTempLabel.
  ///
  /// In id, this message translates to:
  /// **'Suhu tubuh (°C)'**
  String get vitalTempLabel;

  /// No description provided for @vitalPulseLabel.
  ///
  /// In id, this message translates to:
  /// **'Nadi (x/menit)'**
  String get vitalPulseLabel;

  /// No description provided for @vitalRespLabel.
  ///
  /// In id, this message translates to:
  /// **'Frekuensi napas (x/menit)'**
  String get vitalRespLabel;

  /// No description provided for @vitalSystolicRequired.
  ///
  /// In id, this message translates to:
  /// **'Sistolik harus diisi'**
  String get vitalSystolicRequired;

  /// No description provided for @vitalDiastolicRequired.
  ///
  /// In id, this message translates to:
  /// **'Diastolik harus diisi'**
  String get vitalDiastolicRequired;

  /// No description provided for @vitalTempRequired.
  ///
  /// In id, this message translates to:
  /// **'Suhu tubuh harus diisi'**
  String get vitalTempRequired;

  /// No description provided for @vitalPulseRequired.
  ///
  /// In id, this message translates to:
  /// **'Nadi harus diisi'**
  String get vitalPulseRequired;

  /// No description provided for @vitalRespRequired.
  ///
  /// In id, this message translates to:
  /// **'Frekuensi napas harus diisi'**
  String get vitalRespRequired;

  /// No description provided for @vitalValidNumber.
  ///
  /// In id, this message translates to:
  /// **'Masukkan angka yang valid'**
  String get vitalValidNumber;

  /// No description provided for @vitalNormalTitle.
  ///
  /// In id, this message translates to:
  /// **'Nilai Normal:'**
  String get vitalNormalTitle;

  /// No description provided for @vitalNormalBpMain.
  ///
  /// In id, this message translates to:
  /// **'• Tekanan darah: 90/60 - 139/89 mmHg'**
  String get vitalNormalBpMain;

  /// No description provided for @vitalNormalBpSys.
  ///
  /// In id, this message translates to:
  /// **'   - Sistolik (atas): 90-139 mmHg'**
  String get vitalNormalBpSys;

  /// No description provided for @vitalNormalBpDia.
  ///
  /// In id, this message translates to:
  /// **'   - Diastolik (bawah): 60-89 mmHg'**
  String get vitalNormalBpDia;

  /// No description provided for @vitalNormalTemp.
  ///
  /// In id, this message translates to:
  /// **'• Suhu tubuh: 36 - 37.5°C'**
  String get vitalNormalTemp;

  /// No description provided for @vitalNormalPulse.
  ///
  /// In id, this message translates to:
  /// **'• Nadi: 60 - 100 x/menit'**
  String get vitalNormalPulse;

  /// No description provided for @vitalNormalResp.
  ///
  /// In id, this message translates to:
  /// **'• Frekuensi napas: 16 - 20 x/menit'**
  String get vitalNormalResp;

  /// No description provided for @complaintsTitle.
  ///
  /// In id, this message translates to:
  /// **'Keluhan yang Dirasakan'**
  String get complaintsTitle;

  /// No description provided for @complaintsLegendTitle.
  ///
  /// In id, this message translates to:
  /// **'Keterangan:'**
  String get complaintsLegendTitle;

  /// No description provided for @complaintsLegendHigh.
  ///
  /// In id, this message translates to:
  /// **'Keluhan berisiko tinggi'**
  String get complaintsLegendHigh;

  /// No description provided for @complaintsLegendMedium.
  ///
  /// In id, this message translates to:
  /// **'Keluhan perlu perhatian'**
  String get complaintsLegendMedium;

  /// No description provided for @complaintsLegendNormal.
  ///
  /// In id, this message translates to:
  /// **'Keluhan normal'**
  String get complaintsLegendNormal;

  /// No description provided for @complaintsPickInstruction.
  ///
  /// In id, this message translates to:
  /// **'Pilih keluhan yang dialami saat ini:'**
  String get complaintsPickInstruction;

  /// Show number of selected complaints
  ///
  /// In id, this message translates to:
  /// **'{count} keluhan dipilih'**
  String complaintsSelectedCount(int count);

  /// No description provided for @fetalMoveTitle.
  ///
  /// In id, this message translates to:
  /// **'Pencatatan Gerakan Janin'**
  String get fetalMoveTitle;

  /// No description provided for @fetalMoveImportantInfoTitle.
  ///
  /// In id, this message translates to:
  /// **'Informasi Penting'**
  String get fetalMoveImportantInfoTitle;

  /// No description provided for @fetalMoveImportantInfoDesc.
  ///
  /// In id, this message translates to:
  /// **'Pencatatan gerakan janin dilakukan selama {hours} jam. Gerakan janin normal: minimal 10 gerakan dalam {hours} jam. Catat semua gerakan yang dirasakan dalam periode {hours} jam.'**
  String fetalMoveImportantInfoDesc(int hours);

  /// No description provided for @fetalMoveMainParams.
  ///
  /// In id, this message translates to:
  /// **'Parameter Utama Pencatatan'**
  String get fetalMoveMainParams;

  /// No description provided for @fetalMoveMotherSubjective.
  ///
  /// In id, this message translates to:
  /// **'Kondisi Subjektif Ibu'**
  String get fetalMoveMotherSubjective;

  /// No description provided for @fetalMoveStartDateTimeLabel.
  ///
  /// In id, this message translates to:
  /// **'Tanggal & Waktu Mulai Pencatatan'**
  String get fetalMoveStartDateTimeLabel;

  /// No description provided for @fetalMovePickDateTime.
  ///
  /// In id, this message translates to:
  /// **'Pilih tanggal & waktu'**
  String get fetalMovePickDateTime;

  /// No description provided for @fetalMoveCountLabel.
  ///
  /// In id, this message translates to:
  /// **'Jumlah Gerakan dalam {hours} Jam'**
  String fetalMoveCountLabel(int hours);

  /// No description provided for @fetalMoveCountHint.
  ///
  /// In id, this message translates to:
  /// **'Masukkan total gerakan dalam {hours} jam'**
  String fetalMoveCountHint(int hours);

  /// No description provided for @fetalMoveTimesSuffix.
  ///
  /// In id, this message translates to:
  /// **'kali'**
  String get fetalMoveTimesSuffix;

  /// No description provided for @fetalMoveTargetHint.
  ///
  /// In id, this message translates to:
  /// **'Target: minimal 10 gerakan dalam 12 jam'**
  String get fetalMoveTargetHint;

  /// No description provided for @fetalMoveDurationInfo.
  ///
  /// In id, this message translates to:
  /// **'Durasi Pencatatan: {hours} Jam'**
  String fetalMoveDurationInfo(int hours);

  /// No description provided for @fetalMoveActivityPatternLabel.
  ///
  /// In id, this message translates to:
  /// **'Pola Aktivitas Janin'**
  String get fetalMoveActivityPatternLabel;

  /// No description provided for @fetalMoveComparisonLabel.
  ///
  /// In id, this message translates to:
  /// **'Perbandingan Gerakan dengan Hari Sebelumnya'**
  String get fetalMoveComparisonLabel;

  /// No description provided for @fetalMoveOtherComplaintsLabel.
  ///
  /// In id, this message translates to:
  /// **'Keluhan Lain yang Dirasakan'**
  String get fetalMoveOtherComplaintsLabel;

  /// No description provided for @fetalPatternMorning.
  ///
  /// In id, this message translates to:
  /// **'Lebih aktif pagi hari'**
  String get fetalPatternMorning;

  /// No description provided for @fetalPatternAfternoon.
  ///
  /// In id, this message translates to:
  /// **'Lebih aktif siang hari'**
  String get fetalPatternAfternoon;

  /// No description provided for @fetalPatternNight.
  ///
  /// In id, this message translates to:
  /// **'Lebih aktif malam hari'**
  String get fetalPatternNight;

  /// No description provided for @fetalPatternNoPattern.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada pola khusus'**
  String get fetalPatternNoPattern;

  /// No description provided for @fetalCompareMoreActive.
  ///
  /// In id, this message translates to:
  /// **'Lebih aktif'**
  String get fetalCompareMoreActive;

  /// No description provided for @fetalCompareSame.
  ///
  /// In id, this message translates to:
  /// **'Sama saja'**
  String get fetalCompareSame;

  /// No description provided for @fetalCompareLess.
  ///
  /// In id, this message translates to:
  /// **'Lebih sedikit'**
  String get fetalCompareLess;

  /// No description provided for @fetalComplaintDizzyWeak.
  ///
  /// In id, this message translates to:
  /// **'Pusing/lemas'**
  String get fetalComplaintDizzyWeak;

  /// No description provided for @fetalComplaintAbdominalPain.
  ///
  /// In id, this message translates to:
  /// **'Nyeri perut'**
  String get fetalComplaintAbdominalPain;

  /// No description provided for @fetalComplaintNone.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada'**
  String get fetalComplaintNone;

  /// No description provided for @fetalMoveErrorRequired.
  ///
  /// In id, this message translates to:
  /// **'Jumlah gerakan harus diisi'**
  String get fetalMoveErrorRequired;

  /// No description provided for @fetalMoveErrorInvalidNumber.
  ///
  /// In id, this message translates to:
  /// **'Masukkan angka yang valid'**
  String get fetalMoveErrorInvalidNumber;

  /// No description provided for @fetalMoveErrorNegative.
  ///
  /// In id, this message translates to:
  /// **'Tidak boleh negatif'**
  String get fetalMoveErrorNegative;

  /// No description provided for @fetalMoveSummaryEmpty.
  ///
  /// In id, this message translates to:
  /// **'Isi jumlah gerakan untuk melihat ringkasan'**
  String get fetalMoveSummaryEmpty;

  /// No description provided for @fetalMoveSummaryMoves.
  ///
  /// In id, this message translates to:
  /// **'Gerakan: {count} kali dalam {hours} jam ({perHour} gerakan/jam)'**
  String fetalMoveSummaryMoves(int count, int hours, double perHour);

  /// No description provided for @fetalMoveSummaryDetailTitle.
  ///
  /// In id, this message translates to:
  /// **'Detail Pencatatan:'**
  String get fetalMoveSummaryDetailTitle;

  /// No description provided for @fetalMoveSummaryDetailCount.
  ///
  /// In id, this message translates to:
  /// **'• Jumlah gerakan: {count} kali'**
  String fetalMoveSummaryDetailCount(int count);

  /// No description provided for @fetalMoveSummaryDetailDuration.
  ///
  /// In id, this message translates to:
  /// **'• Durasi: {hours} jam'**
  String fetalMoveSummaryDetailDuration(int hours);

  /// No description provided for @fetalMoveSummaryDetailTarget.
  ///
  /// In id, this message translates to:
  /// **'• Target minimal: 10 gerakan'**
  String get fetalMoveSummaryDetailTarget;

  /// No description provided for @fetalMoveSummaryDetailPattern.
  ///
  /// In id, this message translates to:
  /// **'• Pola: {pattern}'**
  String fetalMoveSummaryDetailPattern(String pattern);

  /// No description provided for @fetalMoveSummaryDetailCompare.
  ///
  /// In id, this message translates to:
  /// **'• Perbandingan: {compare}'**
  String fetalMoveSummaryDetailCompare(String compare);

  /// No description provided for @fetalMoveSummaryDetailComplaints.
  ///
  /// In id, this message translates to:
  /// **'• Keluhan: {complaints}'**
  String fetalMoveSummaryDetailComplaints(String complaints);

  /// No description provided for @fetalStatusIncomplete.
  ///
  /// In id, this message translates to:
  /// **'Data Belum Lengkap'**
  String get fetalStatusIncomplete;

  /// No description provided for @fetalStatusNormal.
  ///
  /// In id, this message translates to:
  /// **'Kondisi Normal'**
  String get fetalStatusNormal;

  /// No description provided for @fetalStatusMonitoring.
  ///
  /// In id, this message translates to:
  /// **'Perlu Pemantauan'**
  String get fetalStatusMonitoring;

  /// No description provided for @fetalStatusAttention.
  ///
  /// In id, this message translates to:
  /// **'Perlu Perhatian'**
  String get fetalStatusAttention;

  /// No description provided for @fetalStatusEmergency.
  ///
  /// In id, this message translates to:
  /// **'Perhatian Khusus'**
  String get fetalStatusEmergency;

  /// No description provided for @fetalMsgNormal.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin dalam batas normal ({count} gerakan dalam {hours} jam).'**
  String fetalMsgNormal(int count, int hours);

  /// No description provided for @fetalMsgMonitoring.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin {count} kali dalam {hours} jam. Tetap pantau secara rutin dan perhatikan perubahan gerakan.'**
  String fetalMsgMonitoring(int count, int hours);

  /// No description provided for @fetalMsgAttention.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin {count} kali dalam {hours} jam. Disarankan konsultasi dengan tenaga kesehatan.'**
  String fetalMsgAttention(int count, int hours);

  /// No description provided for @fetalMsgEmergency.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin hanya {count} kali dalam {hours} jam. Segera hubungi tenaga kesehatan.'**
  String fetalMsgEmergency(int count, int hours);

  /// No description provided for @fetalMsgIncomplete.
  ///
  /// In id, this message translates to:
  /// **'Lengkapi data pencatatan untuk analisis yang akurat.'**
  String get fetalMsgIncomplete;

  /// No description provided for @complaintNauseaVomiting.
  ///
  /// In id, this message translates to:
  /// **'Mual dan muntah'**
  String get complaintNauseaVomiting;

  /// No description provided for @complaintBloating.
  ///
  /// In id, this message translates to:
  /// **'Kembung'**
  String get complaintBloating;

  /// No description provided for @complaintHeartburn.
  ///
  /// In id, this message translates to:
  /// **'Maag / nyeri ulu hati'**
  String get complaintHeartburn;

  /// No description provided for @complaintHeadache.
  ///
  /// In id, this message translates to:
  /// **'Sakit kepala'**
  String get complaintHeadache;

  /// No description provided for @complaintFetalMovement.
  ///
  /// In id, this message translates to:
  /// **'Gerakan Janin'**
  String get complaintFetalMovement;

  /// No description provided for @complaintAbdominalCramp.
  ///
  /// In id, this message translates to:
  /// **'Kram perut'**
  String get complaintAbdominalCramp;

  /// No description provided for @complaintVaginalDischarge.
  ///
  /// In id, this message translates to:
  /// **'Keputihan'**
  String get complaintVaginalDischarge;

  /// No description provided for @complaintCravings.
  ///
  /// In id, this message translates to:
  /// **'Ngidam'**
  String get complaintCravings;

  /// No description provided for @complaintBleedingSpotting.
  ///
  /// In id, this message translates to:
  /// **'Pendarahan / bercak dari jalan lahir'**
  String get complaintBleedingSpotting;

  /// No description provided for @complaintSwelling.
  ///
  /// In id, this message translates to:
  /// **'Bengkak pada kaki / tangan / wajah'**
  String get complaintSwelling;

  /// No description provided for @complaintConstipation.
  ///
  /// In id, this message translates to:
  /// **'Sembelit'**
  String get complaintConstipation;

  /// No description provided for @complaintExcessiveFatigue.
  ///
  /// In id, this message translates to:
  /// **'Kelelahan berlebihan'**
  String get complaintExcessiveFatigue;

  /// No description provided for @complaintSleepyDizzy.
  ///
  /// In id, this message translates to:
  /// **'Ngantuk dan pusing'**
  String get complaintSleepyDizzy;

  /// No description provided for @complaintMoodChanges.
  ///
  /// In id, this message translates to:
  /// **'Perubahan mood'**
  String get complaintMoodChanges;

  /// No description provided for @complaintSleepProblems.
  ///
  /// In id, this message translates to:
  /// **'Masalah tidur'**
  String get complaintSleepProblems;

  /// No description provided for @complaintLossOfAppetite.
  ///
  /// In id, this message translates to:
  /// **'Hilang nafsu makan'**
  String get complaintLossOfAppetite;

  /// No description provided for @complaintFastHeartbeat.
  ///
  /// In id, this message translates to:
  /// **'Detak jantung cepat'**
  String get complaintFastHeartbeat;

  /// No description provided for @complaintBackPain.
  ///
  /// In id, this message translates to:
  /// **'Nyeri pinggang / punggung'**
  String get complaintBackPain;

  /// No description provided for @complaintShortnessOfBreath.
  ///
  /// In id, this message translates to:
  /// **'Sesak napas'**
  String get complaintShortnessOfBreath;

  /// No description provided for @complaintBlurredVision.
  ///
  /// In id, this message translates to:
  /// **'Pandangan kabur / berkunang-kunang'**
  String get complaintBlurredVision;

  /// No description provided for @complaintEarlyContractions.
  ///
  /// In id, this message translates to:
  /// **'Kontraksi dini (perut sering kencang sebelum waktunya)'**
  String get complaintEarlyContractions;

  /// No description provided for @pregnancyHistoryTitle.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Kehamilan & Persalinan'**
  String get pregnancyHistoryTitle;

  /// No description provided for @pregnancyHistorySubtitle.
  ///
  /// In id, this message translates to:
  /// **'Isilah sesuai dengan riwayat kehamilan dan persalinan sebelumnya'**
  String get pregnancyHistorySubtitle;

  /// No description provided for @pregnancyHistoryChildrenCountLabel.
  ///
  /// In id, this message translates to:
  /// **'Jumlah anak yang sudah lahir'**
  String get pregnancyHistoryChildrenCountLabel;

  /// No description provided for @pregnancyHistoryFirstPregnancyAgeLabel.
  ///
  /// In id, this message translates to:
  /// **'Usia bunda saat pertama kali hamil'**
  String get pregnancyHistoryFirstPregnancyAgeLabel;

  /// No description provided for @pregnancyHistoryPregnancyGapLabel.
  ///
  /// In id, this message translates to:
  /// **'Jarak kehamilan dengan anak sebelumnya'**
  String get pregnancyHistoryPregnancyGapLabel;

  /// No description provided for @pregnancyHistoryObstetricHistoryLabel.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Obstetrik atau riwayat kehamilan dan persalinan (riwayat keguguran, riwayat caesar, riwayat kelahiran prematur, riwayat hamil ektopik atau di luar kandungan, dll)'**
  String get pregnancyHistoryObstetricHistoryLabel;

  /// No description provided for @pregnancyHistoryDeliveryComplicationsLabel.
  ///
  /// In id, this message translates to:
  /// **'Riwayat komplikasi persalinan (perdarahan, tekanan darah tinggi saat hamil, dll.)'**
  String get pregnancyHistoryDeliveryComplicationsLabel;

  /// No description provided for @pregnancyHistoryBabyWeightHistoryLabel.
  ///
  /// In id, this message translates to:
  /// **'Riwayat bayi lahir (berat badan normal >=2.5 / besar >4 kg)'**
  String get pregnancyHistoryBabyWeightHistoryLabel;

  /// No description provided for @pregnancyHistoryPreviousPregnancyLabel.
  ///
  /// In id, this message translates to:
  /// **'Riwayat kehamilan sebelumnya (normal/bermasalah/janin meninggal)'**
  String get pregnancyHistoryPreviousPregnancyLabel;

  /// No description provided for @pregnancyHistoryExamplesTitle.
  ///
  /// In id, this message translates to:
  /// **'Contoh pengisian:'**
  String get pregnancyHistoryExamplesTitle;

  /// No description provided for @pregnancyHistoryExampleObstetricLabel.
  ///
  /// In id, this message translates to:
  /// **'• Riwayat obstetrik / kehamilan & persalinan sebelumnya'**
  String get pregnancyHistoryExampleObstetricLabel;

  /// No description provided for @pregnancyHistoryExampleComplicationLabel.
  ///
  /// In id, this message translates to:
  /// **'• Riwayat komplikasi persalinan'**
  String get pregnancyHistoryExampleComplicationLabel;

  /// No description provided for @pregnancyHistoryExampleObstetricValue.
  ///
  /// In id, this message translates to:
  /// **'• Riwayat obstetri: Pernah keguguran 1x, SC 1x'**
  String get pregnancyHistoryExampleObstetricValue;

  /// No description provided for @pregnancyHistoryExampleComplicationValue.
  ///
  /// In id, this message translates to:
  /// **'• Komplikasi: Perdarahan pasca persalinan'**
  String get pregnancyHistoryExampleComplicationValue;

  /// No description provided for @pregnancyHistoryExampleBabyWeightValue.
  ///
  /// In id, this message translates to:
  /// **'• Bayi lahir: Berat badan normal minimal 2.5 kg'**
  String get pregnancyHistoryExampleBabyWeightValue;

  /// No description provided for @validationRequiredChildrenCount.
  ///
  /// In id, this message translates to:
  /// **'Jumlah anak harus diisi'**
  String get validationRequiredChildrenCount;

  /// No description provided for @validationRequiredFirstPregnancyAge.
  ///
  /// In id, this message translates to:
  /// **'Usia pertama hamil harus diisi'**
  String get validationRequiredFirstPregnancyAge;

  /// No description provided for @validationInvalidNumber.
  ///
  /// In id, this message translates to:
  /// **'Masukkan angka yang valid'**
  String get validationInvalidNumber;

  /// No description provided for @unitYears.
  ///
  /// In id, this message translates to:
  /// **'tahun'**
  String get unitYears;

  /// No description provided for @unitMonths.
  ///
  /// In id, this message translates to:
  /// **'bulan'**
  String get unitMonths;

  /// No description provided for @healthHistoryTitle.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Kesehatan Bunda'**
  String get healthHistoryTitle;

  /// No description provided for @healthHistorySubtitle.
  ///
  /// In id, this message translates to:
  /// **'Informasi ini membantu tenaga kesehatan memahami kondisi Anda'**
  String get healthHistorySubtitle;

  /// No description provided for @healthHistoryDiseaseLabel.
  ///
  /// In id, this message translates to:
  /// **'Penyakit yang pernah/sedang diderita (tekanan darah tinggi, diabetes, jantung, dll.)'**
  String get healthHistoryDiseaseLabel;

  /// No description provided for @healthHistoryAllergyLabel.
  ///
  /// In id, this message translates to:
  /// **'Riwayat alergi (obat/makanan/bahan tertentu)'**
  String get healthHistoryAllergyLabel;

  /// No description provided for @healthHistorySurgeryLabel.
  ///
  /// In id, this message translates to:
  /// **'Riwayat operasi (selain SC)'**
  String get healthHistorySurgeryLabel;

  /// No description provided for @healthHistoryMedicationLabel.
  ///
  /// In id, this message translates to:
  /// **'Konsumsi obat-obatan rutin (termasuk vitamin/herbal)'**
  String get healthHistoryMedicationLabel;

  /// No description provided for @healthHistoryExamplesTitle.
  ///
  /// In id, this message translates to:
  /// **'Contoh pengisian:'**
  String get healthHistoryExamplesTitle;

  /// No description provided for @healthHistoryExampleDisease.
  ///
  /// In id, this message translates to:
  /// **'• Penyakit: tekanan darah tinggi sejak 2020'**
  String get healthHistoryExampleDisease;

  /// No description provided for @healthHistoryExampleAllergy.
  ///
  /// In id, this message translates to:
  /// **'• Alergi: Alergi antibiotik Amoxicillin'**
  String get healthHistoryExampleAllergy;

  /// No description provided for @healthHistoryExampleSurgery.
  ///
  /// In id, this message translates to:
  /// **'• Operasi: Usus buntu tahun 2018'**
  String get healthHistoryExampleSurgery;

  /// No description provided for @healthHistoryExampleMedication.
  ///
  /// In id, this message translates to:
  /// **'• Obat: Obat tekanan darah tinggi rutin, vitamin prenatal'**
  String get healthHistoryExampleMedication;

  /// No description provided for @commonInvalidNumber.
  ///
  /// In id, this message translates to:
  /// **'Masukkan angka yang valid'**
  String get commonInvalidNumber;

  /// No description provided for @physicalDataTitle.
  ///
  /// In id, this message translates to:
  /// **'Data Fisik Bunda'**
  String get physicalDataTitle;

  /// No description provided for @physicalDataSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Data ini digunakan untuk menghitung Indeks Massa Tubuh (IMT)'**
  String get physicalDataSubtitle;

  /// No description provided for @physicalDataHeightLabel.
  ///
  /// In id, this message translates to:
  /// **'Tinggi badan (cm)'**
  String get physicalDataHeightLabel;

  /// No description provided for @physicalDataWeightBeforeLabel.
  ///
  /// In id, this message translates to:
  /// **'Berat badan sebelum hamil (kg)'**
  String get physicalDataWeightBeforeLabel;

  /// No description provided for @physicalDataCurrentWeightLabel.
  ///
  /// In id, this message translates to:
  /// **'Berat badan saat ini (kg)'**
  String get physicalDataCurrentWeightLabel;

  /// No description provided for @physicalDataMuacLabel.
  ///
  /// In id, this message translates to:
  /// **'Lingkar lengan atas (LILA) (cm)'**
  String get physicalDataMuacLabel;

  /// No description provided for @physicalDataHeightRequired.
  ///
  /// In id, this message translates to:
  /// **'Tinggi badan harus diisi'**
  String get physicalDataHeightRequired;

  /// No description provided for @physicalDataWeightBeforeRequired.
  ///
  /// In id, this message translates to:
  /// **'Berat sebelum hamil harus diisi'**
  String get physicalDataWeightBeforeRequired;

  /// No description provided for @physicalDataCurrentWeightRequired.
  ///
  /// In id, this message translates to:
  /// **'Berat saat ini harus diisi'**
  String get physicalDataCurrentWeightRequired;

  /// No description provided for @physicalDataBmiValue.
  ///
  /// In id, this message translates to:
  /// **'Indeks Massa Tubuh (IMT): {value}'**
  String physicalDataBmiValue(String value);

  /// No description provided for @physicalDataBmiCategoryUnderweight.
  ///
  /// In id, this message translates to:
  /// **'Kategori: Kurus'**
  String get physicalDataBmiCategoryUnderweight;

  /// No description provided for @physicalDataBmiCategoryNormal.
  ///
  /// In id, this message translates to:
  /// **'Kategori: Normal'**
  String get physicalDataBmiCategoryNormal;

  /// No description provided for @physicalDataBmiCategoryOverweight.
  ///
  /// In id, this message translates to:
  /// **'Kategori: Kelebihan berat'**
  String get physicalDataBmiCategoryOverweight;

  /// No description provided for @physicalDataBmiCategoryObesity.
  ///
  /// In id, this message translates to:
  /// **'Kategori: Obesitas'**
  String get physicalDataBmiCategoryObesity;

  /// No description provided for @physicalDataNormalValuesTitle.
  ///
  /// In id, this message translates to:
  /// **'Nilai Normal:'**
  String get physicalDataNormalValuesTitle;

  /// No description provided for @physicalDataNormalBmi.
  ///
  /// In id, this message translates to:
  /// **'• IMT normal: 18.5 - 24.9'**
  String get physicalDataNormalBmi;

  /// No description provided for @physicalDataNormalMuac.
  ///
  /// In id, this message translates to:
  /// **'• LILA normal: ≥ 23.5 cm'**
  String get physicalDataNormalMuac;

  /// No description provided for @physicalDataBmiUnderweightInfo.
  ///
  /// In id, this message translates to:
  /// **'• IMT < 18.5: Kurus'**
  String get physicalDataBmiUnderweightInfo;

  /// No description provided for @physicalDataBmiOverweightInfo.
  ///
  /// In id, this message translates to:
  /// **'• IMT ≥ 25: Kelebihan berat'**
  String get physicalDataBmiOverweightInfo;

  /// No description provided for @physicalDataBmiObesityInfo.
  ///
  /// In id, this message translates to:
  /// **'• IMT ≥ 30: Obesitas'**
  String get physicalDataBmiObesityInfo;

  /// No description provided for @commonPickDate.
  ///
  /// In id, this message translates to:
  /// **'Pilih tanggal'**
  String get commonPickDate;

  /// No description provided for @menstrualTitle.
  ///
  /// In id, this message translates to:
  /// **'Data Haid & Kehamilan'**
  String get menstrualTitle;

  /// No description provided for @menstrualSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Informasi ini membantu menentukan usia kehamilan'**
  String get menstrualSubtitle;

  /// No description provided for @menstrualLmpLabel.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Hari Pertama Haid Terakhir (HPHT)*'**
  String get menstrualLmpLabel;

  /// No description provided for @menstrualLmpRequired.
  ///
  /// In id, this message translates to:
  /// **'Tanggal haid terakhir harus diisi'**
  String get menstrualLmpRequired;

  /// No description provided for @menstrualCycleLabel.
  ///
  /// In id, this message translates to:
  /// **'Siklus haid (teratur/tidak, berapa hari)'**
  String get menstrualCycleLabel;

  /// No description provided for @menstrualFetalMovementLabel.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin (sudah terasa/belum/berkurang)'**
  String get menstrualFetalMovementLabel;

  /// No description provided for @menstrualUltrasoundLabel.
  ///
  /// In id, this message translates to:
  /// **'Hasil pemeriksaan USG (jika sudah ada)'**
  String get menstrualUltrasoundLabel;

  /// No description provided for @menstrualPregnancyInfoTitle.
  ///
  /// In id, this message translates to:
  /// **'Informasi Kehamilan:'**
  String get menstrualPregnancyInfoTitle;

  /// No description provided for @menstrualEddLine.
  ///
  /// In id, this message translates to:
  /// **'• Perkiraan Hari Lahir (HPL): {date}'**
  String menstrualEddLine(String date);

  /// No description provided for @menstrualGestationalAgeLine.
  ///
  /// In id, this message translates to:
  /// **'• Usia kehamilan: {weeks} minggu'**
  String menstrualGestationalAgeLine(String weeks);

  /// No description provided for @menstrualImportantInfoTitle.
  ///
  /// In id, this message translates to:
  /// **'Informasi Penting:'**
  String get menstrualImportantInfoTitle;

  /// No description provided for @menstrualImportantBullet1.
  ///
  /// In id, this message translates to:
  /// **'• HPHT digunakan untuk menghitung usia kehamilan'**
  String get menstrualImportantBullet1;

  /// No description provided for @menstrualImportantBullet2.
  ///
  /// In id, this message translates to:
  /// **'• Gerakan janin biasanya terasa mulai minggu 18-20'**
  String get menstrualImportantBullet2;

  /// No description provided for @menstrualImportantBullet3.
  ///
  /// In id, this message translates to:
  /// **'• USG membantu memastikan usia kehamilan dan perkembangan janin'**
  String get menstrualImportantBullet3;

  /// No description provided for @lifestyleTitle.
  ///
  /// In id, this message translates to:
  /// **'Faktor Sosial & Gaya Hidup'**
  String get lifestyleTitle;

  /// No description provided for @lifestyleSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Informasi ini membantu memahami faktor risiko dari gaya hidup'**
  String get lifestyleSubtitle;

  /// No description provided for @lifestyleAgeLabel.
  ///
  /// In id, this message translates to:
  /// **'Usia bunda sekarang (tahun)'**
  String get lifestyleAgeLabel;

  /// No description provided for @lifestyleSmokingTitle.
  ///
  /// In id, this message translates to:
  /// **'Status merokok / paparan asap rokok'**
  String get lifestyleSmokingTitle;

  /// No description provided for @lifestyleAlcoholDrugTitle.
  ///
  /// In id, this message translates to:
  /// **'Konsumsi alkohol / obat-obatan terlarang'**
  String get lifestyleAlcoholDrugTitle;

  /// No description provided for @lifestylePhysicalActivityLabel.
  ///
  /// In id, this message translates to:
  /// **'Aktivitas fisik harian (aktif/ringan/banyak istirahat)'**
  String get lifestylePhysicalActivityLabel;

  /// No description provided for @lifestyleFamilySupportLabel.
  ///
  /// In id, this message translates to:
  /// **'Dukungan keluarga (ada/minim/tidak ada)'**
  String get lifestyleFamilySupportLabel;

  /// No description provided for @lifestyleRiskInfoTitle.
  ///
  /// In id, this message translates to:
  /// **'Faktor Risiko Penting:'**
  String get lifestyleRiskInfoTitle;

  /// No description provided for @lifestyleRiskBullet1.
  ///
  /// In id, this message translates to:
  /// **'• Usia <20 atau >35 tahun meningkatkan risiko'**
  String get lifestyleRiskBullet1;

  /// No description provided for @lifestyleRiskBullet2.
  ///
  /// In id, this message translates to:
  /// **'• Merokok/paparan asap rokok berisiko untuk janin'**
  String get lifestyleRiskBullet2;

  /// No description provided for @lifestyleRiskBullet3.
  ///
  /// In id, this message translates to:
  /// **'• Alkohol/obat terlarang sangat berbahaya untuk kehamilan'**
  String get lifestyleRiskBullet3;

  /// No description provided for @lifestyleRiskBullet4.
  ///
  /// In id, this message translates to:
  /// **'• Dukungan keluarga penting untuk kesehatan mental'**
  String get lifestyleRiskBullet4;

  /// No description provided for @lifestyleSmokingNone.
  ///
  /// In id, this message translates to:
  /// **'Tidak merokok'**
  String get lifestyleSmokingNone;

  /// No description provided for @lifestyleSmokingActive.
  ///
  /// In id, this message translates to:
  /// **'Merokok'**
  String get lifestyleSmokingActive;

  /// No description provided for @lifestyleSmokingPassive.
  ///
  /// In id, this message translates to:
  /// **'Terpapar asap rokok'**
  String get lifestyleSmokingPassive;

  /// No description provided for @lifestyleAlcoholNone.
  ///
  /// In id, this message translates to:
  /// **'Tidak mengonsumsi'**
  String get lifestyleAlcoholNone;

  /// No description provided for @lifestyleAlcoholYes.
  ///
  /// In id, this message translates to:
  /// **'Mengonsumsi alkohol'**
  String get lifestyleAlcoholYes;

  /// No description provided for @lifestyleDrugsYes.
  ///
  /// In id, this message translates to:
  /// **'Mengonsumsi obat terlarang'**
  String get lifestyleDrugsYes;

  /// No description provided for @errorAgeRequired.
  ///
  /// In id, this message translates to:
  /// **'Usia saat ini harus diisi'**
  String get errorAgeRequired;

  /// No description provided for @errorInvalidNumber.
  ///
  /// In id, this message translates to:
  /// **'Masukkan angka yang valid'**
  String get errorInvalidNumber;

  /// No description provided for @selfDetectionLoading.
  ///
  /// In id, this message translates to:
  /// **'Sedang menghitung risiko...'**
  String get selfDetectionLoading;

  /// No description provided for @selfDetectionResultTitle.
  ///
  /// In id, this message translates to:
  /// **'Hasil Deteksi Mandiri'**
  String get selfDetectionResultTitle;

  /// No description provided for @saveResultTooltip.
  ///
  /// In id, this message translates to:
  /// **'Simpan Hasil'**
  String get saveResultTooltip;

  /// No description provided for @totalRiskPointsLabel.
  ///
  /// In id, this message translates to:
  /// **'Total Poin Risiko:'**
  String get totalRiskPointsLabel;

  /// No description provided for @noSpecificRecommendation.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada rekomendasi spesifik'**
  String get noSpecificRecommendation;

  /// No description provided for @riskHigh.
  ///
  /// In id, this message translates to:
  /// **'Risiko Tinggi'**
  String get riskHigh;

  /// No description provided for @riskAttention.
  ///
  /// In id, this message translates to:
  /// **'Perlu Perhatian'**
  String get riskAttention;

  /// No description provided for @riskMonitoring.
  ///
  /// In id, this message translates to:
  /// **'Perlu Pemantauan'**
  String get riskMonitoring;

  /// No description provided for @riskNormal.
  ///
  /// In id, this message translates to:
  /// **'Normal'**
  String get riskNormal;

  /// No description provided for @unknown.
  ///
  /// In id, this message translates to:
  /// **'Tidak Diketahui'**
  String get unknown;

  /// No description provided for @identifiedRiskFactorsTitle.
  ///
  /// In id, this message translates to:
  /// **'Faktor Risiko yang Teridentifikasi'**
  String get identifiedRiskFactorsTitle;

  /// No description provided for @complaintEducationTitle.
  ///
  /// In id, this message translates to:
  /// **'Edukasi Keluhan'**
  String get complaintEducationTitle;

  /// No description provided for @riskEducationTitle.
  ///
  /// In id, this message translates to:
  /// **'Edukasi Risiko'**
  String get riskEducationTitle;

  /// No description provided for @healthyPregnancyTipsTitle.
  ///
  /// In id, this message translates to:
  /// **'Tips Kehamilan Sehat'**
  String get healthyPregnancyTipsTitle;

  /// No description provided for @recommendationTitle.
  ///
  /// In id, this message translates to:
  /// **'Rekomendasi'**
  String get recommendationTitle;

  /// No description provided for @fetalMovementRecordTitle.
  ///
  /// In id, this message translates to:
  /// **'Hasil Pencatatan Gerakan Janin'**
  String get fetalMovementRecordTitle;

  /// No description provided for @recordDetailTitle.
  ///
  /// In id, this message translates to:
  /// **'Detail Pencatatan:'**
  String get recordDetailTitle;

  /// No description provided for @movementCountLabel.
  ///
  /// In id, this message translates to:
  /// **'Jumlah Gerakan'**
  String get movementCountLabel;

  /// No description provided for @recordDurationLabel.
  ///
  /// In id, this message translates to:
  /// **'Durasi Pencatatan'**
  String get recordDurationLabel;

  /// No description provided for @movementsPerHourLabel.
  ///
  /// In id, this message translates to:
  /// **'Gerakan per Jam'**
  String get movementsPerHourLabel;

  /// No description provided for @comparisonWithYesterdayLabel.
  ///
  /// In id, this message translates to:
  /// **'Perbandingan dengan Kemarin'**
  String get comparisonWithYesterdayLabel;

  /// No description provided for @activityPatternLabel.
  ///
  /// In id, this message translates to:
  /// **'Pola Aktivitas'**
  String get activityPatternLabel;

  /// No description provided for @noData.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada data'**
  String get noData;

  /// No description provided for @timesSuffix.
  ///
  /// In id, this message translates to:
  /// **'kali'**
  String get timesSuffix;

  /// No description provided for @hoursSuffix.
  ///
  /// In id, this message translates to:
  /// **'jam'**
  String get hoursSuffix;

  /// No description provided for @movementsPerHourSuffix.
  ///
  /// In id, this message translates to:
  /// **'gerakan/jam'**
  String get movementsPerHourSuffix;

  /// No description provided for @fetalMovementNormalStandard.
  ///
  /// In id, this message translates to:
  /// **'Standar normal: minimal 10 gerakan dalam 12 jam ({value} gerakan/jam)'**
  String fetalMovementNormalStandard(Object value);

  /// No description provided for @fetalMovementIncompleteTitle.
  ///
  /// In id, this message translates to:
  /// **'Data Belum Lengkap'**
  String get fetalMovementIncompleteTitle;

  /// No description provided for @fetalMovementNormalTitle.
  ///
  /// In id, this message translates to:
  /// **'Kondisi Normal'**
  String get fetalMovementNormalTitle;

  /// No description provided for @fetalMovementMonitoringTitle.
  ///
  /// In id, this message translates to:
  /// **'Perlu Pemantauan'**
  String get fetalMovementMonitoringTitle;

  /// No description provided for @fetalMovementAttentionTitle.
  ///
  /// In id, this message translates to:
  /// **'Perlu Perhatian'**
  String get fetalMovementAttentionTitle;

  /// No description provided for @fetalMovementCriticalTitle.
  ///
  /// In id, this message translates to:
  /// **'Perhatian Khusus'**
  String get fetalMovementCriticalTitle;

  /// No description provided for @fetalMovementIncompleteMsg.
  ///
  /// In id, this message translates to:
  /// **'Data gerakan janin belum lengkap. Silakan lengkapi pencatatan.'**
  String get fetalMovementIncompleteMsg;

  /// No description provided for @fetalMovementNormalMsg.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin dalam batas normal ({count} gerakan dalam 12 jam).'**
  String fetalMovementNormalMsg(Object count);

  /// No description provided for @fetalMovementMonitoringMsg.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin {count} kali dalam 12 jam. Tetap pantau secara rutin dan perhatikan perubahan gerakan.'**
  String fetalMovementMonitoringMsg(Object count);

  /// No description provided for @fetalMovementAttentionMsg.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin {count} kali dalam 12 jam. Disarankan konsultasi dengan tenaga kesehatan.'**
  String fetalMovementAttentionMsg(Object count);

  /// No description provided for @fetalMovementCriticalMsg.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin hanya {count} kali dalam 12 jam. Segera hubungi tenaga kesehatan.'**
  String fetalMovementCriticalMsg(Object count);

  /// No description provided for @saveDetectionResultButton.
  ///
  /// In id, this message translates to:
  /// **'Simpan Hasil Deteksi'**
  String get saveDetectionResultButton;

  /// No description provided for @backToSelfDetectionButton.
  ///
  /// In id, this message translates to:
  /// **'Kembali ke Deteksi Mandiri'**
  String get backToSelfDetectionButton;

  /// No description provided for @saveResultDialogTitle.
  ///
  /// In id, this message translates to:
  /// **'Simpan Hasil Deteksi'**
  String get saveResultDialogTitle;

  /// No description provided for @saveResultDialogMessage.
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda ingin menyimpan hasil deteksi ini? Hasil akan disimpan dalam riwayat deteksi.'**
  String get saveResultDialogMessage;

  /// No description provided for @saveSuccessSnack.
  ///
  /// In id, this message translates to:
  /// **'Hasil deteksi berhasil disimpan!'**
  String get saveSuccessSnack;

  /// No description provided for @riskMsgHigh.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin sangat berkurang. Segera hubungi tenaga kesehatan.'**
  String get riskMsgHigh;

  /// No description provided for @riskMsgAttention.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin berkurang. Disarankan konsultasi dengan tenaga kesehatan.'**
  String get riskMsgAttention;

  /// No description provided for @riskMsgMonitoring.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin mendekati batas minimal. Pantau rutin dan perhatikan perubahan.'**
  String get riskMsgMonitoring;

  /// No description provided for @riskMsgNormal.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin dalam batas normal. Lanjutkan pemantauan rutin.'**
  String get riskMsgNormal;

  /// No description provided for @riskMsgUnknown.
  ///
  /// In id, this message translates to:
  /// **'Data belum lengkap atau tidak valid.'**
  String get riskMsgUnknown;

  /// No description provided for @historyTitle.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Deteksi'**
  String get historyTitle;

  /// No description provided for @historySectionTitle.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Deteksi Mandiri'**
  String get historySectionTitle;

  /// No description provided for @historyErrorTitle.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan'**
  String get historyErrorTitle;

  /// No description provided for @historyRetry.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get historyRetry;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada riwayat deteksi'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptySubtitle.
  ///
  /// In id, this message translates to:
  /// **'Hasil deteksi mandiri akan muncul di sini'**
  String get historyEmptySubtitle;

  /// No description provided for @historyStartDetectionNow.
  ///
  /// In id, this message translates to:
  /// **'Lakukan Self Detection Sekarang'**
  String get historyStartDetectionNow;

  /// No description provided for @historyUserDataUnavailable.
  ///
  /// In id, this message translates to:
  /// **'Data tidak tersedia'**
  String get historyUserDataUnavailable;

  /// No description provided for @historyPleaseRelogin.
  ///
  /// In id, this message translates to:
  /// **'Silakan login ulang'**
  String get historyPleaseRelogin;

  /// No description provided for @historyFetalMovementLabel.
  ///
  /// In id, this message translates to:
  /// **'Gerakan Janin'**
  String get historyFetalMovementLabel;

  /// No description provided for @historyDetailLabel.
  ///
  /// In id, this message translates to:
  /// **'Detail'**
  String get historyDetailLabel;

  /// No description provided for @historyStatusLabel.
  ///
  /// In id, this message translates to:
  /// **'Status'**
  String get historyStatusLabel;

  /// No description provided for @historyAgeYears.
  ///
  /// In id, this message translates to:
  /// **'{age} tahun'**
  String historyAgeYears(int age);

  /// No description provided for @historyDetailCount.
  ///
  /// In id, this message translates to:
  /// **'{count} faktor'**
  String historyDetailCount(int count);

  /// No description provided for @riskLevelHigh.
  ///
  /// In id, this message translates to:
  /// **'Risiko Tinggi'**
  String get riskLevelHigh;

  /// No description provided for @riskLevelNeedAttention.
  ///
  /// In id, this message translates to:
  /// **'Perlu Perhatian'**
  String get riskLevelNeedAttention;

  /// No description provided for @riskLevelNeedMonitoring.
  ///
  /// In id, this message translates to:
  /// **'Perlu Pemantauan'**
  String get riskLevelNeedMonitoring;

  /// No description provided for @riskLevelNormal.
  ///
  /// In id, this message translates to:
  /// **'Normal'**
  String get riskLevelNormal;

  /// No description provided for @riskLevelUnknown.
  ///
  /// In id, this message translates to:
  /// **'Tidak Diketahui'**
  String get riskLevelUnknown;

  /// No description provided for @riskStatusNeedsTreatment.
  ///
  /// In id, this message translates to:
  /// **'Perlu Penanganan'**
  String get riskStatusNeedsTreatment;

  /// No description provided for @riskStatusNeedsAttention.
  ///
  /// In id, this message translates to:
  /// **'Perlu Perhatian'**
  String get riskStatusNeedsAttention;

  /// No description provided for @riskStatusNeedsMonitoring.
  ///
  /// In id, this message translates to:
  /// **'Perlu Pemantauan'**
  String get riskStatusNeedsMonitoring;

  /// No description provided for @riskStatusSafe.
  ///
  /// In id, this message translates to:
  /// **'Aman'**
  String get riskStatusSafe;

  /// No description provided for @riskStatusUnknown.
  ///
  /// In id, this message translates to:
  /// **'Tidak Diketahui'**
  String get riskStatusUnknown;

  /// No description provided for @mothersListTitle.
  ///
  /// In id, this message translates to:
  /// **'Daftar Bunda'**
  String get mothersListTitle;

  /// No description provided for @searchNameOrUsernameHint.
  ///
  /// In id, this message translates to:
  /// **'Cari nama atau username...'**
  String get searchNameOrUsernameHint;

  /// No description provided for @noMotherData.
  ///
  /// In id, this message translates to:
  /// **'Belum ada data bunda'**
  String get noMotherData;

  /// No description provided for @notFoundTitle.
  ///
  /// In id, this message translates to:
  /// **'Tidak ditemukan'**
  String get notFoundTitle;

  /// No description provided for @noResultsForQuery.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada hasil untuk \'{query}\''**
  String noResultsForQuery(Object query);

  /// No description provided for @badgeMother.
  ///
  /// In id, this message translates to:
  /// **'Bunda'**
  String get badgeMother;

  /// No description provided for @yearsOldShort.
  ///
  /// In id, this message translates to:
  /// **'tahun'**
  String get yearsOldShort;

  /// No description provided for @languageTooltip.
  ///
  /// In id, this message translates to:
  /// **'Bahasa'**
  String get languageTooltip;

  /// No description provided for @languageIndonesia.
  ///
  /// In id, this message translates to:
  /// **'Indonesia'**
  String get languageIndonesia;

  /// No description provided for @languageEnglish.
  ///
  /// In id, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @logoutFailed.
  ///
  /// In id, this message translates to:
  /// **'Logout gagal'**
  String get logoutFailed;

  /// No description provided for @monitoringTitle.
  ///
  /// In id, this message translates to:
  /// **'Monitoring {name}'**
  String monitoringTitle(Object name);

  /// No description provided for @refreshDataTooltip.
  ///
  /// In id, this message translates to:
  /// **'Refresh Data'**
  String get refreshDataTooltip;

  /// No description provided for @tabDevelopment.
  ///
  /// In id, this message translates to:
  /// **'Perkembangan'**
  String get tabDevelopment;

  /// No description provided for @tabSelfDetection.
  ///
  /// In id, this message translates to:
  /// **'Self Detection'**
  String get tabSelfDetection;

  /// No description provided for @ageYears.
  ///
  /// In id, this message translates to:
  /// **'{age} tahun'**
  String ageYears(Object age);

  /// No description provided for @loadingPregnancyData.
  ///
  /// In id, this message translates to:
  /// **'Memuat data kehamilan...'**
  String get loadingPregnancyData;

  /// No description provided for @loadingDetectionHistory.
  ///
  /// In id, this message translates to:
  /// **'Memuat riwayat deteksi...'**
  String get loadingDetectionHistory;

  /// No description provided for @loadingDataGeneric.
  ///
  /// In id, this message translates to:
  /// **'Memuat data...'**
  String get loadingDataGeneric;

  /// No description provided for @noPregnancyDataTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum Ada Data Kehamilan'**
  String get noPregnancyDataTitle;

  /// No description provided for @noPregnancyDataSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Data kehamilan akan muncul di sini'**
  String get noPregnancyDataSubtitle;

  /// No description provided for @pregnancyNumber.
  ///
  /// In id, this message translates to:
  /// **'Kehamilan {n}'**
  String pregnancyNumber(Object n);

  /// No description provided for @activePregnancy.
  ///
  /// In id, this message translates to:
  /// **'Kehamilan Aktif'**
  String get activePregnancy;

  /// No description provided for @pregnancyHistory.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Kehamilan'**
  String get pregnancyHistory;

  /// No description provided for @activeLabel.
  ///
  /// In id, this message translates to:
  /// **'Aktif'**
  String get activeLabel;

  /// No description provided for @babyNameLabel.
  ///
  /// In id, this message translates to:
  /// **'👶 Nama Bayi'**
  String get babyNameLabel;

  /// No description provided for @babyNameNotSet.
  ///
  /// In id, this message translates to:
  /// **'Belum diberi nama'**
  String get babyNameNotSet;

  /// No description provided for @lmpLabel.
  ///
  /// In id, this message translates to:
  /// **'📅 HPHT'**
  String get lmpLabel;

  /// No description provided for @eddLabel.
  ///
  /// In id, this message translates to:
  /// **'🎯 Perkiraan Lahir'**
  String get eddLabel;

  /// No description provided for @cycleLabel.
  ///
  /// In id, this message translates to:
  /// **'🔄 Siklus'**
  String get cycleLabel;

  /// No description provided for @cycleDaysValue.
  ///
  /// In id, this message translates to:
  /// **'{n} hari'**
  String cycleDaysValue(Object n);

  /// No description provided for @pregnancyProgressTitle.
  ///
  /// In id, this message translates to:
  /// **'Perkembangan Kehamilan'**
  String get pregnancyProgressTitle;

  /// No description provided for @trimesterWithValue.
  ///
  /// In id, this message translates to:
  /// **'Trimester {value}'**
  String trimesterWithValue(Object value);

  /// No description provided for @gestationalAgeLabel.
  ///
  /// In id, this message translates to:
  /// **'Usia Kandungan'**
  String get gestationalAgeLabel;

  /// No description provided for @gestationalAgeValue.
  ///
  /// In id, this message translates to:
  /// **'{weeks} minggu {days} hari'**
  String gestationalAgeValue(Object weeks, Object days);

  /// No description provided for @daysToBirthLabel.
  ///
  /// In id, this message translates to:
  /// **'Hari Menuju Lahir'**
  String get daysToBirthLabel;

  /// No description provided for @daysValue.
  ///
  /// In id, this message translates to:
  /// **'{n} hari'**
  String daysValue(Object n);

  /// No description provided for @trimesterLabel.
  ///
  /// In id, this message translates to:
  /// **'Trimester'**
  String get trimesterLabel;

  /// No description provided for @timelineTitle.
  ///
  /// In id, this message translates to:
  /// **'Timeline Perkembangan'**
  String get timelineTitle;

  /// No description provided for @trimester1.
  ///
  /// In id, this message translates to:
  /// **'Trimester 1'**
  String get trimester1;

  /// No description provided for @trimester2.
  ///
  /// In id, this message translates to:
  /// **'Trimester 2'**
  String get trimester2;

  /// No description provided for @trimester3.
  ///
  /// In id, this message translates to:
  /// **'Trimester 3'**
  String get trimester3;

  /// No description provided for @weekRange1_13.
  ///
  /// In id, this message translates to:
  /// **'Minggu 1-13'**
  String get weekRange1_13;

  /// No description provided for @weekRange14_27.
  ///
  /// In id, this message translates to:
  /// **'Minggu 14-27'**
  String get weekRange14_27;

  /// No description provided for @weekRange28_40.
  ///
  /// In id, this message translates to:
  /// **'Minggu 28-40'**
  String get weekRange28_40;

  /// No description provided for @dataCreatedAt.
  ///
  /// In id, this message translates to:
  /// **'Data dibuat: {date}'**
  String dataCreatedAt(Object date);

  /// No description provided for @fetalMovementMonitoringHeader.
  ///
  /// In id, this message translates to:
  /// **'Pemantauan Gerakan Janin'**
  String get fetalMovementMonitoringHeader;

  /// No description provided for @selfDetectionHistoryHeader.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Self Detection'**
  String get selfDetectionHistoryHeader;

  /// No description provided for @fetalMovementHistoryHeader.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Gerakan Janin'**
  String get fetalMovementHistoryHeader;

  /// No description provided for @noSelfDetectionDataTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum Ada Data Self Detection'**
  String get noSelfDetectionDataTitle;

  /// No description provided for @noSelfDetectionDataSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Data deteksi mandiri akan muncul di sini'**
  String get noSelfDetectionDataSubtitle;

  /// No description provided for @noFetalMovementDataTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum Ada Data Gerakan Janin'**
  String get noFetalMovementDataTitle;

  /// No description provided for @noFetalMovementDataSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Data gerakan janin akan muncul di sini'**
  String get noFetalMovementDataSubtitle;

  /// No description provided for @fetalMovementStatsTitle.
  ///
  /// In id, this message translates to:
  /// **'Statistik Gerakan Janin'**
  String get fetalMovementStatsTitle;

  /// No description provided for @avgMovementsLabel.
  ///
  /// In id, this message translates to:
  /// **'Rata-rata Gerakan'**
  String get avgMovementsLabel;

  /// No description provided for @normalSessionsLabel.
  ///
  /// In id, this message translates to:
  /// **'Sesi Normal'**
  String get normalSessionsLabel;

  /// No description provided for @totalSessionsLabel.
  ///
  /// In id, this message translates to:
  /// **'Total Sesi'**
  String get totalSessionsLabel;

  /// No description provided for @latestRecordDetailTitle.
  ///
  /// In id, this message translates to:
  /// **'Detail Pencatatan Terbaru:'**
  String get latestRecordDetailTitle;

  /// No description provided for @durationLabel.
  ///
  /// In id, this message translates to:
  /// **'Durasi'**
  String get durationLabel;

  /// No description provided for @comparisonLabel.
  ///
  /// In id, this message translates to:
  /// **'Perbandingan'**
  String get comparisonLabel;

  /// No description provided for @complaintsLabel.
  ///
  /// In id, this message translates to:
  /// **'Keluhan'**
  String get complaintsLabel;

  /// No description provided for @activityPatternShortLabel.
  ///
  /// In id, this message translates to:
  /// **'Pola'**
  String get activityPatternShortLabel;

  /// No description provided for @comparisonShortLabel.
  ///
  /// In id, this message translates to:
  /// **'Perbandingan'**
  String get comparisonShortLabel;

  /// No description provided for @timesValue.
  ///
  /// In id, this message translates to:
  /// **'{n} kali'**
  String timesValue(Object n);

  /// No description provided for @hoursValue.
  ///
  /// In id, this message translates to:
  /// **'{n} jam'**
  String hoursValue(Object n);

  /// No description provided for @perHourValue.
  ///
  /// In id, this message translates to:
  /// **'{value}/jam'**
  String perHourValue(Object value);

  /// No description provided for @fetalMovementStandardTitle.
  ///
  /// In id, this message translates to:
  /// **'Standar normal: minimal 10 gerakan dalam 12 jam'**
  String get fetalMovementStandardTitle;

  /// No description provided for @fetalMovementStandardPerHour.
  ///
  /// In id, this message translates to:
  /// **'({value} gerakan per jam)'**
  String fetalMovementStandardPerHour(Object value);

  /// No description provided for @movementsCountText.
  ///
  /// In id, this message translates to:
  /// **'{n} gerakan'**
  String movementsCountText(Object n);

  /// No description provided for @pointsValue.
  ///
  /// In id, this message translates to:
  /// **'{n} poin'**
  String pointsValue(Object n);

  /// No description provided for @detailLabel.
  ///
  /// In id, this message translates to:
  /// **'Detail'**
  String get detailLabel;

  /// No description provided for @statusLabel.
  ///
  /// In id, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @fetalMovementLabel.
  ///
  /// In id, this message translates to:
  /// **'Gerakan Janin'**
  String get fetalMovementLabel;

  /// No description provided for @recordedLabel.
  ///
  /// In id, this message translates to:
  /// **'Tercatat'**
  String get recordedLabel;

  /// No description provided for @factorsCount.
  ///
  /// In id, this message translates to:
  /// **'{n} faktor'**
  String factorsCount(Object n);

  /// No description provided for @riskNeedTreatment.
  ///
  /// In id, this message translates to:
  /// **'Perlu Penanganan'**
  String get riskNeedTreatment;

  /// No description provided for @riskNeedAttention.
  ///
  /// In id, this message translates to:
  /// **'Perlu Perhatian'**
  String get riskNeedAttention;

  /// No description provided for @riskSafe.
  ///
  /// In id, this message translates to:
  /// **'Aman'**
  String get riskSafe;

  /// No description provided for @errorOccurredTitle.
  ///
  /// In id, this message translates to:
  /// **'Terjadi Kesalahan'**
  String get errorOccurredTitle;

  /// No description provided for @fetalMovementStatusIncomplete.
  ///
  /// In id, this message translates to:
  /// **'Data Belum Lengkap'**
  String get fetalMovementStatusIncomplete;

  /// No description provided for @fetalMovementStatusNormal.
  ///
  /// In id, this message translates to:
  /// **'Kondisi Normal'**
  String get fetalMovementStatusNormal;

  /// No description provided for @fetalMovementStatusMonitor.
  ///
  /// In id, this message translates to:
  /// **'Perlu Pemantauan'**
  String get fetalMovementStatusMonitor;

  /// No description provided for @fetalMovementStatusAttention.
  ///
  /// In id, this message translates to:
  /// **'Perlu Perhatian'**
  String get fetalMovementStatusAttention;

  /// No description provided for @fetalMovementStatusUrgent.
  ///
  /// In id, this message translates to:
  /// **'Perhatian Khusus'**
  String get fetalMovementStatusUrgent;

  /// No description provided for @fetalMovementMsgIncomplete.
  ///
  /// In id, this message translates to:
  /// **'Data gerakan janin belum lengkap. Silakan lengkapi pencatatan.'**
  String get fetalMovementMsgIncomplete;

  /// No description provided for @fetalMovementMsgNormal.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin dalam batas normal ({count} gerakan dalam 12 jam).'**
  String fetalMovementMsgNormal(Object count);

  /// No description provided for @fetalMovementMsgMonitor.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin {count} kali dalam 12 jam. Tetap pantau secara rutin dan perhatikan perubahan gerakan.'**
  String fetalMovementMsgMonitor(Object count);

  /// No description provided for @fetalMovementMsgAttention.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin {count} kali dalam 12 jam. Disarankan konsultasi dengan tenaga kesehatan.'**
  String fetalMovementMsgAttention(Object count);

  /// No description provided for @fetalMovementMsgUrgent.
  ///
  /// In id, this message translates to:
  /// **'Gerakan janin hanya {count} kali dalam 12 jam. Segera hubungi tenaga kesehatan.'**
  String fetalMovementMsgUrgent(Object count);

  /// No description provided for @deleteTooltip.
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get deleteTooltip;

  /// No description provided for @deleteBundaTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus Data Bunda'**
  String get deleteBundaTitle;

  /// No description provided for @deleteBundaMessage.
  ///
  /// In id, this message translates to:
  /// **'Yakin ingin menghapus data {name}? Semua riwayat kehamilan & self detection akan ikut terhapus.'**
  String deleteBundaMessage(Object name);

  /// No description provided for @delete.
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get delete;

  /// No description provided for @deleteSuccess.
  ///
  /// In id, this message translates to:
  /// **'Data berhasil dihapus'**
  String get deleteSuccess;

  /// No description provided for @deleteFailed.
  ///
  /// In id, this message translates to:
  /// **'Gagal menghapus: {error}'**
  String deleteFailed(Object error);

  /// No description provided for @signupHospitalLabel.
  ///
  /// In id, this message translates to:
  /// **'Rumah Sakit'**
  String get signupHospitalLabel;

  /// No description provided for @signupHospitalHint.
  ///
  /// In id, this message translates to:
  /// **'Pilih rumah sakit'**
  String get signupHospitalHint;

  /// No description provided for @signupHospitalRequired.
  ///
  /// In id, this message translates to:
  /// **'Rumah sakit wajib dipilih'**
  String get signupHospitalRequired;

  /// No description provided for @hospitalRsudKisaDepok.
  ///
  /// In id, this message translates to:
  /// **'RSUD Kisa Depok'**
  String get hospitalRsudKisaDepok;

  /// No description provided for @hospitalRsiSultanAgung.
  ///
  /// In id, this message translates to:
  /// **'RSI Sultan Agung'**
  String get hospitalRsiSultanAgung;

  /// No description provided for @complaintsCustomHint.
  ///
  /// In id, this message translates to:
  /// **'Tulis keluhan lain...'**
  String get complaintsCustomHint;

  /// No description provided for @complaintsAddButton.
  ///
  /// In id, this message translates to:
  /// **'Tambah'**
  String get complaintsAddButton;

  /// No description provided for @complaintsDuplicateError.
  ///
  /// In id, this message translates to:
  /// **'Keluhan sudah ada'**
  String get complaintsDuplicateError;

  /// No description provided for @complaintsEmptyError.
  ///
  /// In id, this message translates to:
  /// **'Keluhan tidak boleh kosong'**
  String get complaintsEmptyError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
