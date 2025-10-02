import 'package:cloud_firestore/cloud_firestore.dart';

class SelfDetectionModel {
  final String id;
  final String userId;
  final String riskLevel;
  final int score;
  final List<String> details;
  final String recommendation;
  final Map<String, dynamic>? riskEducation;
  final List<dynamic>? generalTips;
  final DateTime date;
  final DateTime? createdAt;

  // DATA GERAKAN JANIN - TAMBAHKAN FIELD BARU
  final bool hasFetalMovementData;
  final int? fetalMovementCount;
  final int? fetalMovementDuration;
  final double? movementsPerHour;
  final Map<String, dynamic>? fetalMovementStatus;
  final String? movementComparison;
  final String? fetalActivityPattern;
  final List<dynamic>? fetalAdditionalComplaints;
  final String? fetalMovementDateTime;

  SelfDetectionModel({
    required this.id,
    required this.userId,
    required this.riskLevel,
    required this.score,
    required this.details,
    required this.recommendation,
    this.riskEducation,
    this.generalTips,
    required this.date,
    this.createdAt,

    // TAMBAHKAN PARAMETER BARU
    this.hasFetalMovementData = false,
    this.fetalMovementCount,
    this.fetalMovementDuration,
    this.movementsPerHour,
    this.fetalMovementStatus,
    this.movementComparison,
    this.fetalActivityPattern,
    this.fetalAdditionalComplaints,
    this.fetalMovementDateTime,
  });

  factory SelfDetectionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // PARSE DATA GERAKAN JANIN DARI FIRESTORE
    final hasFetalMovementData = data['hasFetalMovementData'] == true;
    final fetalMovementCount = data['fetalMovementCount'] as int?;
    final fetalMovementDuration = data['fetalMovementDuration'] as int?;
    final movementsPerHour = data['movementsPerHour'] as double?;

    // Handle dynamic type untuk fetalMovementStatus
    final dynamic fetalMovementStatusDynamic = data['fetalMovementStatus'];
    final Map<String, dynamic>? fetalMovementStatus =
    fetalMovementStatusDynamic is Map ? Map<String, dynamic>.from(fetalMovementStatusDynamic) : null;

    final movementComparison = data['movementComparison'] as String?;
    final fetalActivityPattern = data['fetalActivityPattern'] as String?;
    final fetalAdditionalComplaints = data['fetalAdditionalComplaints'] as List<dynamic>?;
    final fetalMovementDateTime = data['fetalMovementDateTime'] as String?;

    return SelfDetectionModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      riskLevel: data['riskLevel'] ?? 'unknown',
      score: data['score'] ?? 0,
      details: List<String>.from(data['details'] ?? []),
      recommendation: data['recommendation'] ?? '',
      riskEducation: data['riskEducation'] as Map<String, dynamic>?,
      generalTips: data['generalTips'] as List<dynamic>?,
      date: DateTime.tryParse(data['date'] ?? '') ?? DateTime.now(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),

      // TAMBAHKAN DATA GERAKAN JANIN
      hasFetalMovementData: hasFetalMovementData,
      fetalMovementCount: fetalMovementCount,
      fetalMovementDuration: fetalMovementDuration,
      movementsPerHour: movementsPerHour,
      fetalMovementStatus: fetalMovementStatus,
      movementComparison: movementComparison,
      fetalActivityPattern: fetalActivityPattern,
      fetalAdditionalComplaints: fetalAdditionalComplaints,
      fetalMovementDateTime: fetalMovementDateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String(),
      'riskLevel': riskLevel,
      'score': score,
      'details': details,
      'recommendation': recommendation,
      'riskEducation': riskEducation,
      'generalTips': generalTips,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),

      // TAMBAHKAN DATA GERAKAN JANIN KE JSON
      'hasFetalMovementData': hasFetalMovementData,
      'fetalMovementCount': fetalMovementCount,
      'fetalMovementDuration': fetalMovementDuration,
      'movementsPerHour': movementsPerHour,
      'fetalMovementStatus': fetalMovementStatus,
      'movementComparison': movementComparison,
      'fetalActivityPattern': fetalActivityPattern,
      'fetalAdditionalComplaints': fetalAdditionalComplaints,
      'fetalMovementDateTime': fetalMovementDateTime,
    };
  }

  // METHOD COPYWITH UNTUK UPDATE DATA (OPTIONAL)
  SelfDetectionModel copyWith({
    String? id,
    String? userId,
    String? riskLevel,
    int? score,
    List<String>? details,
    String? recommendation,
    Map<String, dynamic>? riskEducation,
    List<dynamic>? generalTips,
    DateTime? date,
    DateTime? createdAt,
    bool? hasFetalMovementData,
    int? fetalMovementCount,
    int? fetalMovementDuration,
    double? movementsPerHour,
    Map<String, dynamic>? fetalMovementStatus,
    String? movementComparison,
    String? fetalActivityPattern,
    List<dynamic>? fetalAdditionalComplaints,
    String? fetalMovementDateTime,
  }) {
    return SelfDetectionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      riskLevel: riskLevel ?? this.riskLevel,
      score: score ?? this.score,
      details: details ?? this.details,
      recommendation: recommendation ?? this.recommendation,
      riskEducation: riskEducation ?? this.riskEducation,
      generalTips: generalTips ?? this.generalTips,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      hasFetalMovementData: hasFetalMovementData ?? this.hasFetalMovementData,
      fetalMovementCount: fetalMovementCount ?? this.fetalMovementCount,
      fetalMovementDuration: fetalMovementDuration ?? this.fetalMovementDuration,
      movementsPerHour: movementsPerHour ?? this.movementsPerHour,
      fetalMovementStatus: fetalMovementStatus ?? this.fetalMovementStatus,
      movementComparison: movementComparison ?? this.movementComparison,
      fetalActivityPattern: fetalActivityPattern ?? this.fetalActivityPattern,
      fetalAdditionalComplaints: fetalAdditionalComplaints ?? this.fetalAdditionalComplaints,
      fetalMovementDateTime: fetalMovementDateTime ?? this.fetalMovementDateTime,
    );
  }
}