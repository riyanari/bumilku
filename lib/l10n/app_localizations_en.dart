// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'BUMILKU';

  @override
  String get selfDetection => 'Self Detection';

  @override
  String get selfDetectionDesc => 'Detect your pregnancy condition now';

  @override
  String get checkHistory => 'Checkup History';

  @override
  String get checkHistoryDesc =>
      'This history is generated from self detection';

  @override
  String get maternalNursingTitle => 'What is Maternal Nursing?';

  @override
  String get maternalNursingDesc =>
      'Maternal nursing focuses on maternal health';

  @override
  String get faqTitle => 'Frequently Asked Questions';

  @override
  String get faqDesc => 'Read common questions often asked during pregnancy';

  @override
  String get noPregnancyData => 'No pregnancy data yet';

  @override
  String get addPregnancy => 'Add Pregnancy';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get medicalDataNotAvailable => 'Medical data is not available';

  @override
  String get addFirstPregnancy => 'Add First Pregnancy';

  @override
  String get logoutConfirmTitle => 'Logout Confirmation';

  @override
  String get logoutConfirmDesc =>
      'Are you sure you want to log out from BUMILKU?';

  @override
  String get cancel => 'Cancel';

  @override
  String get logout => 'Logout';

  @override
  String get addPregnancyNewTitle => 'Add New Pregnancy';

  @override
  String get addPregnancyNewDesc => 'Do you want to add new pregnancy data?';

  @override
  String get add => 'Add';

  @override
  String get pregnancyCalendarTitle => 'Pregnancy Calendar';

  @override
  String get edit => 'Edit';

  @override
  String get lastPeriodLabel => 'Last period (LMP)';

  @override
  String get dueDateLabel => 'Estimated due date';

  @override
  String get setPeriodInfoTitle => 'Menstrual Information';

  @override
  String get setPeriodInfoDesc =>
      'Last Menstrual Period (LMP) is the first day of your last period. This information is used to calculate gestational age and estimate your due date.';

  @override
  String get lmpDateLabel => 'LMP Date';

  @override
  String get cycleLengthLabel => 'Cycle Length';

  @override
  String get daysUnit => 'days';

  @override
  String get save => 'Save';

  @override
  String pregnancyWeekInfo(int weeks) {
    return 'You are entering week $weeks of pregnancy';
  }

  @override
  String get selfDetectionTitle => 'Self Pregnancy Check';

  @override
  String get detectionHistory => 'Detection History';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get calculateRisk => 'Calculate Risk';

  @override
  String get completeStepData => 'Please complete the data on this step.';

  @override
  String get signUpNewAccountTitle => 'Create New Account';

  @override
  String get emailHint => 'Email';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Invalid email format';

  @override
  String get passwordHint => 'Password';

  @override
  String get confirmPasswordHint => 'Confirm Password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMin6 => 'Password must be at least 6 characters';

  @override
  String get confirmPasswordRequired => 'Confirm password is required';

  @override
  String get passwordNotMatch => 'Passwords do not match';

  @override
  String get passwordStrengthLabel => 'Password strength:';

  @override
  String get passwordStrengthWeak => 'Weak';

  @override
  String get passwordStrengthFair => 'Fair';

  @override
  String get passwordStrengthGood => 'Good';

  @override
  String get passwordStrengthStrong => 'Strong';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get signUpButton => 'Sign up';

  @override
  String get signingUpLoading => 'Signing up...';

  @override
  String get signupWelcomeTitle => 'Welcome! 👋';

  @override
  String get signupWelcomeDesc =>
      'Before we start, let’s get to know you first';

  @override
  String get signupNameLabel => 'Your Name';

  @override
  String get signupNameHint => 'Enter your name';

  @override
  String get signupNameEmpty => 'Name cannot be empty';

  @override
  String get signupNameMin2 => 'Name must be at least 2 characters';

  @override
  String get signupNameMax30 => 'Name must be at most 30 characters';

  @override
  String get signupAddressLabel => 'Address';

  @override
  String get signupAddressHint => 'Enter your full address';

  @override
  String get signupAddressEmpty => 'Address cannot be empty';

  @override
  String get signupDobLabel => 'Date of Birth';

  @override
  String get signupDobHint => 'Select date of birth';

  @override
  String get signupDobRequired => 'Date of birth is required';

  @override
  String get vitalTitle => 'Vital Signs';

  @override
  String get vitalSystolicLabel => 'Systolic (mmHg)';

  @override
  String get vitalDiastolicLabel => 'Diastolic (mmHg)';

  @override
  String get vitalTempLabel => 'Body temperature (°C)';

  @override
  String get vitalPulseLabel => 'Pulse (beats/min)';

  @override
  String get vitalRespLabel => 'Respiratory rate (breaths/min)';

  @override
  String get vitalSystolicRequired => 'Systolic is required';

  @override
  String get vitalDiastolicRequired => 'Diastolic is required';

  @override
  String get vitalTempRequired => 'Temperature is required';

  @override
  String get vitalPulseRequired => 'Pulse is required';

  @override
  String get vitalRespRequired => 'Respiratory rate is required';

  @override
  String get vitalValidNumber => 'Please enter a valid number';

  @override
  String get vitalNormalTitle => 'Normal Values:';

  @override
  String get vitalNormalBpMain => '• Blood pressure: 90/60 - 139/89 mmHg';

  @override
  String get vitalNormalBpSys => '   - Systolic (upper): 90-139 mmHg';

  @override
  String get vitalNormalBpDia => '   - Diastolic (lower): 60-89 mmHg';

  @override
  String get vitalNormalTemp => '• Body temperature: 36 - 37.5°C';

  @override
  String get vitalNormalPulse => '• Pulse: 60 - 100 beats/min';

  @override
  String get vitalNormalResp => '• Respiratory rate: 16 - 20 breaths/min';

  @override
  String get complaintsTitle => 'Reported Complaints';

  @override
  String get complaintsLegendTitle => 'Legend:';

  @override
  String get complaintsLegendHigh => 'High-risk complaint';

  @override
  String get complaintsLegendMedium => 'Needs attention';

  @override
  String get complaintsLegendNormal => 'Normal complaint';

  @override
  String get complaintsPickInstruction =>
      'Select the complaints you are experiencing:';

  @override
  String complaintsSelectedCount(int count) {
    return '$count complaint(s) selected';
  }

  @override
  String get fetalMoveTitle => 'Fetal Movement Tracking';

  @override
  String get fetalMoveImportantInfoTitle => 'Important Information';

  @override
  String fetalMoveImportantInfoDesc(int hours) {
    return 'Fetal movement tracking is performed for $hours hours. Normal fetal movement: at least 10 movements within $hours hours. Record all movements you feel during this $hours-hour period.';
  }

  @override
  String get fetalMoveMainParams => 'Main Tracking Parameters';

  @override
  String get fetalMoveMotherSubjective => 'Mother’s Subjective Condition';

  @override
  String get fetalMoveStartDateTimeLabel => 'Start Date & Time';

  @override
  String get fetalMovePickDateTime => 'Select date & time';

  @override
  String fetalMoveCountLabel(int hours) {
    return 'Total Movements in $hours Hours';
  }

  @override
  String fetalMoveCountHint(int hours) {
    return 'Enter total movements in $hours hours';
  }

  @override
  String get fetalMoveTimesSuffix => 'times';

  @override
  String get fetalMoveTargetHint => 'Target: at least 10 movements in 12 hours';

  @override
  String fetalMoveDurationInfo(int hours) {
    return 'Tracking Duration: $hours Hours';
  }

  @override
  String get fetalMoveActivityPatternLabel => 'Fetal Activity Pattern';

  @override
  String get fetalMoveComparisonLabel => 'Compared to the Previous Day';

  @override
  String get fetalMoveOtherComplaintsLabel => 'Other Complaints';

  @override
  String get fetalPatternMorning => 'More active in the morning';

  @override
  String get fetalPatternAfternoon => 'More active in the afternoon';

  @override
  String get fetalPatternNight => 'More active at night';

  @override
  String get fetalPatternNoPattern => 'No specific pattern';

  @override
  String get fetalCompareMoreActive => 'More active';

  @override
  String get fetalCompareSame => 'About the same';

  @override
  String get fetalCompareLess => 'Less active';

  @override
  String get fetalComplaintDizzyWeak => 'Dizzy/weak';

  @override
  String get fetalComplaintAbdominalPain => 'Abdominal pain';

  @override
  String get fetalComplaintNone => 'None';

  @override
  String get fetalMoveErrorRequired => 'Movement count is required';

  @override
  String get fetalMoveErrorInvalidNumber => 'Enter a valid number';

  @override
  String get fetalMoveErrorNegative => 'Cannot be negative';

  @override
  String get fetalMoveSummaryEmpty => 'Enter movement count to see the summary';

  @override
  String fetalMoveSummaryMoves(int count, int hours, double perHour) {
    return 'Movements: $count in $hours hours ($perHour movements/hour)';
  }

  @override
  String get fetalMoveSummaryDetailTitle => 'Tracking Details:';

  @override
  String fetalMoveSummaryDetailCount(int count) {
    return '• Total movements: $count';
  }

  @override
  String fetalMoveSummaryDetailDuration(int hours) {
    return '• Duration: $hours hours';
  }

  @override
  String get fetalMoveSummaryDetailTarget => '• Minimum target: 10 movements';

  @override
  String fetalMoveSummaryDetailPattern(String pattern) {
    return '• Pattern: $pattern';
  }

  @override
  String fetalMoveSummaryDetailCompare(String compare) {
    return '• Comparison: $compare';
  }

  @override
  String fetalMoveSummaryDetailComplaints(String complaints) {
    return '• Complaints: $complaints';
  }

  @override
  String get fetalStatusIncomplete => 'Incomplete Data';

  @override
  String get fetalStatusNormal => 'Normal';

  @override
  String get fetalStatusMonitoring => 'Needs Monitoring';

  @override
  String get fetalStatusAttention => 'Needs Attention';

  @override
  String get fetalStatusEmergency => 'Urgent Attention';

  @override
  String fetalMsgNormal(int count, int hours) {
    return 'Fetal movement is within the normal range ($count movements in $hours hours).';
  }

  @override
  String fetalMsgMonitoring(int count, int hours) {
    return 'Fetal movement is $count in $hours hours. Keep monitoring regularly and watch for changes.';
  }

  @override
  String fetalMsgAttention(int count, int hours) {
    return 'Fetal movement is $count in $hours hours. Consider consulting a healthcare professional.';
  }

  @override
  String fetalMsgEmergency(int count, int hours) {
    return 'Fetal movement is only $count in $hours hours. Contact a healthcare professional immediately.';
  }

  @override
  String get fetalMsgIncomplete =>
      'Complete the tracking data for an accurate analysis.';

  @override
  String get complaintNauseaVomiting => 'Nausea and vomiting';

  @override
  String get complaintBloating => 'Bloating';

  @override
  String get complaintHeartburn => 'Heartburn';

  @override
  String get complaintHeadache => 'Headache';

  @override
  String get complaintFetalMovement => 'Fetal movement';

  @override
  String get complaintAbdominalCramp => 'Abdominal cramps';

  @override
  String get complaintVaginalDischarge => 'Vaginal discharge';

  @override
  String get complaintCravings => 'Cravings';

  @override
  String get complaintBleedingSpotting => 'Bleeding / spotting';

  @override
  String get complaintSwelling => 'Swelling (hands/feet/face)';

  @override
  String get complaintConstipation => 'Constipation';

  @override
  String get complaintExcessiveFatigue => 'Excessive fatigue';

  @override
  String get complaintSleepyDizzy => 'Dizziness / sleepiness';

  @override
  String get complaintMoodChanges => 'Mood changes';

  @override
  String get complaintSleepProblems => 'Sleep problems';

  @override
  String get complaintLossOfAppetite => 'Loss of appetite';

  @override
  String get complaintFastHeartbeat => 'Fast heartbeat';

  @override
  String get complaintBackPain => 'Back pain';

  @override
  String get complaintShortnessOfBreath => 'Shortness of breath';

  @override
  String get complaintBlurredVision => 'Blurred vision';

  @override
  String get complaintEarlyContractions => 'Early contractions';

  @override
  String get pregnancyHistoryTitle => 'Pregnancy & Delivery History';

  @override
  String get pregnancyHistorySubtitle =>
      'Fill in based on your previous pregnancy and delivery history';

  @override
  String get pregnancyHistoryChildrenCountLabel =>
      'Number of children already born';

  @override
  String get pregnancyHistoryFirstPregnancyAgeLabel =>
      'Your age at first pregnancy';

  @override
  String get pregnancyHistoryPregnancyGapLabel =>
      'Gap from the previous pregnancy';

  @override
  String get pregnancyHistoryObstetricHistoryLabel =>
      'Obstetric history (miscarriage, C-section, preterm birth, ectopic pregnancy, etc.)';

  @override
  String get pregnancyHistoryDeliveryComplicationsLabel =>
      'Delivery complications history (bleeding, high blood pressure during pregnancy, etc.)';

  @override
  String get pregnancyHistoryBabyWeightHistoryLabel =>
      'Baby birth history (normal weight ≥2.5 kg / large >4 kg)';

  @override
  String get pregnancyHistoryPreviousPregnancyLabel =>
      'Previous pregnancy outcome (normal/complicated/stillbirth)';

  @override
  String get pregnancyHistoryExamplesTitle => 'Example:';

  @override
  String get pregnancyHistoryExampleObstetricLabel =>
      '• Obstetric / previous pregnancy & delivery history';

  @override
  String get pregnancyHistoryExampleComplicationLabel =>
      '• Delivery complications history';

  @override
  String get pregnancyHistoryExampleObstetricValue =>
      '• Obstetric history: 1 miscarriage, 1 C-section';

  @override
  String get pregnancyHistoryExampleComplicationValue =>
      '• Complications: Postpartum hemorrhage';

  @override
  String get pregnancyHistoryExampleBabyWeightValue =>
      '• Baby birth: Normal weight at least 2.5 kg';

  @override
  String get validationRequiredChildrenCount =>
      'Number of children is required';

  @override
  String get validationRequiredFirstPregnancyAge =>
      'Age at first pregnancy is required';

  @override
  String get validationInvalidNumber => 'Please enter a valid number';

  @override
  String get unitYears => 'years';

  @override
  String get unitMonths => 'months';

  @override
  String get healthHistoryTitle => 'Mother’s Health History';

  @override
  String get healthHistorySubtitle =>
      'This information helps healthcare providers understand your condition';

  @override
  String get healthHistoryDiseaseLabel =>
      'Past/current illnesses (high blood pressure, diabetes, heart disease, etc.)';

  @override
  String get healthHistoryAllergyLabel =>
      'Allergy history (medications/foods/other substances)';

  @override
  String get healthHistorySurgeryLabel =>
      'Surgery history (excluding C-section)';

  @override
  String get healthHistoryMedicationLabel =>
      'Regular medications (including vitamins/herbal supplements)';

  @override
  String get healthHistoryExamplesTitle => 'Example:';

  @override
  String get healthHistoryExampleDisease =>
      '• Illness: high blood pressure since 2020';

  @override
  String get healthHistoryExampleAllergy =>
      '• Allergy: Amoxicillin antibiotic allergy';

  @override
  String get healthHistoryExampleSurgery => '• Surgery: appendectomy in 2018';

  @override
  String get healthHistoryExampleMedication =>
      '• Medications: regular blood pressure meds, prenatal vitamins';

  @override
  String get commonInvalidNumber => 'Enter a valid number';

  @override
  String get physicalDataTitle => 'Mother’s Physical Data';

  @override
  String get physicalDataSubtitle =>
      'This data is used to calculate Body Mass Index (BMI)';

  @override
  String get physicalDataHeightLabel => 'Height (cm)';

  @override
  String get physicalDataWeightBeforeLabel => 'Pre-pregnancy weight (kg)';

  @override
  String get physicalDataCurrentWeightLabel => 'Current weight (kg)';

  @override
  String get physicalDataMuacLabel => 'Mid-upper arm circumference (MUAC) (cm)';

  @override
  String get physicalDataHeightRequired => 'Height is required';

  @override
  String get physicalDataWeightBeforeRequired =>
      'Pre-pregnancy weight is required';

  @override
  String get physicalDataCurrentWeightRequired => 'Current weight is required';

  @override
  String physicalDataBmiValue(String value) {
    return 'Body Mass Index (BMI): $value';
  }

  @override
  String get physicalDataBmiCategoryUnderweight => 'Category: Underweight';

  @override
  String get physicalDataBmiCategoryNormal => 'Category: Normal';

  @override
  String get physicalDataBmiCategoryOverweight => 'Category: Overweight';

  @override
  String get physicalDataBmiCategoryObesity => 'Category: Obesity';

  @override
  String get physicalDataNormalValuesTitle => 'Normal values:';

  @override
  String get physicalDataNormalBmi => '• Normal BMI: 18.5 - 24.9';

  @override
  String get physicalDataNormalMuac => '• Normal MUAC: ≥ 23.5 cm';

  @override
  String get physicalDataBmiUnderweightInfo => '• BMI < 18.5: Underweight';

  @override
  String get physicalDataBmiOverweightInfo => '• BMI ≥ 25: Overweight';

  @override
  String get physicalDataBmiObesityInfo => '• BMI ≥ 30: Obesity';

  @override
  String get commonPickDate => 'Select a date';

  @override
  String get menstrualTitle => 'Menstrual & Pregnancy Data';

  @override
  String get menstrualSubtitle =>
      'This information helps determine gestational age';

  @override
  String get menstrualLmpLabel => 'First Day of Last Menstrual Period (LMP)*';

  @override
  String get menstrualLmpRequired => 'Last menstrual period date is required';

  @override
  String get menstrualCycleLabel =>
      'Menstrual cycle (regular/irregular, how many days)';

  @override
  String get menstrualFetalMovementLabel =>
      'Fetal movement (felt/not yet/reduced)';

  @override
  String get menstrualUltrasoundLabel => 'Ultrasound result (if available)';

  @override
  String get menstrualPregnancyInfoTitle => 'Pregnancy Information:';

  @override
  String menstrualEddLine(String date) {
    return '• Estimated Due Date (EDD): $date';
  }

  @override
  String menstrualGestationalAgeLine(String weeks) {
    return '• Gestational age: $weeks weeks';
  }

  @override
  String get menstrualImportantInfoTitle => 'Important Information:';

  @override
  String get menstrualImportantBullet1 =>
      '• LMP is used to estimate gestational age';

  @override
  String get menstrualImportantBullet2 =>
      '• Fetal movement is usually felt starting around weeks 18–20';

  @override
  String get menstrualImportantBullet3 =>
      '• Ultrasound helps confirm gestational age and fetal development';

  @override
  String get lifestyleTitle => 'Social & Lifestyle Factors';

  @override
  String get lifestyleSubtitle =>
      'This information helps identify lifestyle-related risk factors';

  @override
  String get lifestyleAgeLabel => 'Your current age (years)';

  @override
  String get lifestyleSmokingTitle =>
      'Smoking status / secondhand smoke exposure';

  @override
  String get lifestyleAlcoholDrugTitle => 'Alcohol / illegal drug use';

  @override
  String get lifestylePhysicalActivityLabel =>
      'Daily physical activity (active/light/mostly resting)';

  @override
  String get lifestyleFamilySupportLabel =>
      'Family support (good/limited/none)';

  @override
  String get lifestyleRiskInfoTitle => 'Key Risk Factors:';

  @override
  String get lifestyleRiskBullet1 => '• Age <20 or >35 increases risk';

  @override
  String get lifestyleRiskBullet2 =>
      '• Smoking/secondhand smoke can harm the baby';

  @override
  String get lifestyleRiskBullet3 =>
      '• Alcohol/illegal drugs are very dangerous in pregnancy';

  @override
  String get lifestyleRiskBullet4 =>
      '• Family support is important for mental health';

  @override
  String get lifestyleSmokingNone => 'Non-smoker';

  @override
  String get lifestyleSmokingActive => 'Smoker';

  @override
  String get lifestyleSmokingPassive => 'Exposed to secondhand smoke';

  @override
  String get lifestyleAlcoholNone => 'None';

  @override
  String get lifestyleAlcoholYes => 'Uses alcohol';

  @override
  String get lifestyleDrugsYes => 'Uses illegal drugs';

  @override
  String get errorAgeRequired => 'Current age is required';

  @override
  String get errorInvalidNumber => 'Please enter a valid number';

  @override
  String get selfDetectionLoading => 'Calculating risk...';

  @override
  String get selfDetectionResultTitle => 'Self-Detection Result';

  @override
  String get saveResultTooltip => 'Save Result';

  @override
  String get totalRiskPointsLabel => 'Total Risk Points:';

  @override
  String get noSpecificRecommendation => 'No specific recommendation';

  @override
  String get riskHigh => 'High Risk';

  @override
  String get riskAttention => 'Needs Attention';

  @override
  String get riskMonitoring => 'Needs Monitoring';

  @override
  String get riskNormal => 'Normal';

  @override
  String get unknown => 'Unknown';

  @override
  String get identifiedRiskFactorsTitle => 'Identified Risk Factors';

  @override
  String get complaintEducationTitle => 'Complaint Education';

  @override
  String get riskEducationTitle => 'Risk Education';

  @override
  String get healthyPregnancyTipsTitle => 'Healthy Pregnancy Tips';

  @override
  String get recommendationTitle => 'Recommendation';

  @override
  String get fetalMovementRecordTitle => 'Fetal Movement Recording Result';

  @override
  String get recordDetailTitle => 'Recording Details:';

  @override
  String get movementCountLabel => 'Movement Count';

  @override
  String get recordDurationLabel => 'Recording Duration';

  @override
  String get movementsPerHourLabel => 'Movements / Hour';

  @override
  String get comparisonWithYesterdayLabel => 'Compared to Yesterday';

  @override
  String get activityPatternLabel => 'Activity Pattern';

  @override
  String get noData => 'No data';

  @override
  String get timesSuffix => 'times';

  @override
  String get hoursSuffix => 'hours';

  @override
  String get movementsPerHourSuffix => 'moves/hour';

  @override
  String fetalMovementNormalStandard(Object value) {
    return 'Normal standard: at least 10 movements in 12 hours ($value moves/hour)';
  }

  @override
  String get fetalMovementIncompleteTitle => 'Incomplete Data';

  @override
  String get fetalMovementNormalTitle => 'Normal';

  @override
  String get fetalMovementMonitoringTitle => 'Needs Monitoring';

  @override
  String get fetalMovementAttentionTitle => 'Needs Attention';

  @override
  String get fetalMovementCriticalTitle => 'Critical';

  @override
  String get fetalMovementIncompleteMsg =>
      'Fetal movement data is incomplete. Please complete the recording.';

  @override
  String fetalMovementNormalMsg(Object count) {
    return 'Fetal movements are within normal limits ($count movements in 12 hours).';
  }

  @override
  String fetalMovementMonitoringMsg(Object count) {
    return 'Fetal movements are $count in 12 hours. Monitor regularly and watch for changes.';
  }

  @override
  String fetalMovementAttentionMsg(Object count) {
    return 'Fetal movements are $count in 12 hours. Consultation with a healthcare provider is recommended.';
  }

  @override
  String fetalMovementCriticalMsg(Object count) {
    return 'Fetal movements are only $count in 12 hours. Contact a healthcare provider immediately.';
  }

  @override
  String get saveDetectionResultButton => 'Save Detection Result';

  @override
  String get backToSelfDetectionButton => 'Back to Self-Detection';

  @override
  String get saveResultDialogTitle => 'Save Result';

  @override
  String get saveResultDialogMessage =>
      'Do you want to save this result? It will be stored in your detection history.';

  @override
  String get saveSuccessSnack => 'Result saved successfully!';

  @override
  String get riskMsgHigh =>
      'Fetal movements are very low. Contact a healthcare provider immediately.';

  @override
  String get riskMsgAttention =>
      'Fetal movements are reduced. Consultation with a healthcare provider is recommended.';

  @override
  String get riskMsgMonitoring =>
      'Fetal movements are close to the minimum. Monitor regularly and watch for changes.';

  @override
  String get riskMsgNormal =>
      'Fetal movements are within normal limits. Continue regular monitoring.';

  @override
  String get riskMsgUnknown => 'Data is incomplete or invalid.';

  @override
  String get historyTitle => 'Detection History';

  @override
  String get historySectionTitle => 'Self-Detection History';

  @override
  String get historyErrorTitle => 'Something went wrong';

  @override
  String get historyRetry => 'Try Again';

  @override
  String get historyEmptyTitle => 'No detection history yet';

  @override
  String get historyEmptySubtitle =>
      'Your self-detection results will appear here';

  @override
  String get historyStartDetectionNow => 'Start Self Detection Now';

  @override
  String get historyUserDataUnavailable => 'Data is not available';

  @override
  String get historyPleaseRelogin => 'Please sign in again';

  @override
  String get historyFetalMovementLabel => 'Fetal Movements';

  @override
  String get historyDetailLabel => 'Details';

  @override
  String get historyStatusLabel => 'Status';

  @override
  String historyAgeYears(int age) {
    return '$age years old';
  }

  @override
  String historyDetailCount(int count) {
    return '$count factors';
  }

  @override
  String get riskLevelHigh => 'High Risk';

  @override
  String get riskLevelNeedAttention => 'Needs Attention';

  @override
  String get riskLevelNeedMonitoring => 'Needs Monitoring';

  @override
  String get riskLevelNormal => 'Normal';

  @override
  String get riskLevelUnknown => 'Unknown';

  @override
  String get riskStatusNeedsTreatment => 'Needs Treatment';

  @override
  String get riskStatusNeedsAttention => 'Needs Attention';

  @override
  String get riskStatusNeedsMonitoring => 'Needs Monitoring';

  @override
  String get riskStatusSafe => 'Safe';

  @override
  String get riskStatusUnknown => 'Unknown';

  @override
  String get mothersListTitle => 'Mothers List';

  @override
  String get searchNameOrUsernameHint => 'Search name or username...';

  @override
  String get noMotherData => 'No mother data yet';

  @override
  String get notFoundTitle => 'Not found';

  @override
  String noResultsForQuery(Object query) {
    return 'No results for \'$query\'';
  }

  @override
  String get badgeMother => 'Mother';

  @override
  String get yearsOldShort => 'years';

  @override
  String get languageTooltip => 'Language';

  @override
  String get languageIndonesia => 'Indonesia';

  @override
  String get languageEnglish => 'English';

  @override
  String get logoutFailed => 'Logout failed';

  @override
  String monitoringTitle(Object name) {
    return 'Monitoring $name';
  }

  @override
  String get refreshDataTooltip => 'Refresh Data';

  @override
  String get tabDevelopment => 'Development';

  @override
  String get tabSelfDetection => 'Self Detection';

  @override
  String ageYears(Object age) {
    return '$age years';
  }

  @override
  String get loadingPregnancyData => 'Loading pregnancy data...';

  @override
  String get loadingDetectionHistory => 'Loading detection history...';

  @override
  String get loadingDataGeneric => 'Loading data...';

  @override
  String get noPregnancyDataTitle => 'No Pregnancy Data';

  @override
  String get noPregnancyDataSubtitle => 'Pregnancy data will appear here';

  @override
  String pregnancyNumber(Object n) {
    return 'Pregnancy $n';
  }

  @override
  String get activePregnancy => 'Active Pregnancy';

  @override
  String get pregnancyHistory => 'Pregnancy History';

  @override
  String get activeLabel => 'Active';

  @override
  String get babyNameLabel => '👶 Baby Name';

  @override
  String get babyNameNotSet => 'Not set';

  @override
  String get lmpLabel => '📅 LMP';

  @override
  String get eddLabel => '🎯 Due Date';

  @override
  String get cycleLabel => '🔄 Cycle';

  @override
  String cycleDaysValue(Object n) {
    return '$n days';
  }

  @override
  String get pregnancyProgressTitle => 'Pregnancy Progress';

  @override
  String trimesterWithValue(Object value) {
    return 'Trimester $value';
  }

  @override
  String get gestationalAgeLabel => 'Gestational Age';

  @override
  String gestationalAgeValue(Object weeks, Object days) {
    return '$weeks weeks $days days';
  }

  @override
  String get daysToBirthLabel => 'Days to Due Date';

  @override
  String daysValue(Object n) {
    return '$n days';
  }

  @override
  String get trimesterLabel => 'Trimester';

  @override
  String get timelineTitle => 'Development Timeline';

  @override
  String get trimester1 => 'Trimester 1';

  @override
  String get trimester2 => 'Trimester 2';

  @override
  String get trimester3 => 'Trimester 3';

  @override
  String get weekRange1_13 => 'Weeks 1-13';

  @override
  String get weekRange14_27 => 'Weeks 14-27';

  @override
  String get weekRange28_40 => 'Weeks 28-40';

  @override
  String dataCreatedAt(Object date) {
    return 'Created at: $date';
  }

  @override
  String get fetalMovementMonitoringHeader => 'Fetal Movement Monitoring';

  @override
  String get selfDetectionHistoryHeader => 'Self Detection History';

  @override
  String get fetalMovementHistoryHeader => 'Fetal Movement History';

  @override
  String get noSelfDetectionDataTitle => 'No Self Detection Data';

  @override
  String get noSelfDetectionDataSubtitle =>
      'Self detection records will appear here';

  @override
  String get noFetalMovementDataTitle => 'No Fetal Movement Data';

  @override
  String get noFetalMovementDataSubtitle =>
      'Fetal movement records will appear here';

  @override
  String get fetalMovementStatsTitle => 'Fetal Movement Statistics';

  @override
  String get avgMovementsLabel => 'Average Movements';

  @override
  String get normalSessionsLabel => 'Normal Sessions';

  @override
  String get totalSessionsLabel => 'Total Sessions';

  @override
  String get latestRecordDetailTitle => 'Latest Record Details:';

  @override
  String get durationLabel => 'Duration';

  @override
  String get comparisonLabel => 'Comparison';

  @override
  String get complaintsLabel => 'Complaints';

  @override
  String get activityPatternShortLabel => 'Pattern';

  @override
  String get comparisonShortLabel => 'Comparison';

  @override
  String timesValue(Object n) {
    return '$n times';
  }

  @override
  String hoursValue(Object n) {
    return '$n hours';
  }

  @override
  String perHourValue(Object value) {
    return '$value/hr';
  }

  @override
  String get fetalMovementStandardTitle =>
      'Normal standard: at least 10 movements in 12 hours';

  @override
  String fetalMovementStandardPerHour(Object value) {
    return '($value movements per hour)';
  }

  @override
  String movementsCountText(Object n) {
    return '$n movements';
  }

  @override
  String pointsValue(Object n) {
    return '$n points';
  }

  @override
  String get detailLabel => 'Detail';

  @override
  String get statusLabel => 'Status';

  @override
  String get fetalMovementLabel => 'Fetal Movement';

  @override
  String get recordedLabel => 'Recorded';

  @override
  String factorsCount(Object n) {
    return '$n factors';
  }

  @override
  String get riskNeedTreatment => 'Needs Treatment';

  @override
  String get riskNeedAttention => 'Needs Attention';

  @override
  String get riskSafe => 'Safe';

  @override
  String get errorOccurredTitle => 'An error occurred';

  @override
  String get fetalMovementStatusIncomplete => 'Incomplete Data';

  @override
  String get fetalMovementStatusNormal => 'Normal';

  @override
  String get fetalMovementStatusMonitor => 'Monitor';

  @override
  String get fetalMovementStatusAttention => 'Needs Attention';

  @override
  String get fetalMovementStatusUrgent => 'Urgent';

  @override
  String get fetalMovementMsgIncomplete =>
      'Fetal movement data is incomplete. Please complete the record.';

  @override
  String fetalMovementMsgNormal(Object count) {
    return 'Fetal movement is within the normal range ($count movements in 12 hours).';
  }

  @override
  String fetalMovementMsgMonitor(Object count) {
    return '$count movements in 12 hours. Keep monitoring regularly and watch for changes.';
  }

  @override
  String fetalMovementMsgAttention(Object count) {
    return '$count movements in 12 hours. It is recommended to consult a health professional.';
  }

  @override
  String fetalMovementMsgUrgent(Object count) {
    return 'Only $count movements in 12 hours. Contact a health professional immediately.';
  }

  @override
  String get deleteTooltip => 'Delete';

  @override
  String get deleteBundaTitle => 'Delete Mother Data';

  @override
  String deleteBundaMessage(Object name) {
    return 'Are you sure you want to delete $name\'s data? All pregnancy and self detection history will also be deleted.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get deleteSuccess => 'Data deleted successfully';

  @override
  String deleteFailed(Object error) {
    return 'Failed to delete: $error';
  }

  @override
  String get signupHospitalLabel => 'Hospital';

  @override
  String get signupHospitalHint => 'Select a hospital';

  @override
  String get signupHospitalRequired => 'Hospital is required';

  @override
  String get hospitalRsudKisaDepok => 'RSUD Kisa Depok';

  @override
  String get hospitalRsiSultanAgung => 'RSI Sultan Agung';
}
