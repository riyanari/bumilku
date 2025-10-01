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
  });

  factory SelfDetectionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
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
    };
  }
}
