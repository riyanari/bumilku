class MedisModel {
  final String id;            // doc id di Firestore
  final String userId;        // relasi ke user
  final int cycleLength;
  final DateTime selectedLmp;
  final DateTime edd;
  final bool isCompleted;
  final DateTime? deliveredAt;
  final DateTime createdAt;
  final String? babyName;     // nama bayi (opsional)
  final int? pregnancyOrder;  // urutan kehamilan

  MedisModel({
    required this.id,
    required this.userId,
    required this.cycleLength,
    required this.selectedLmp,
    required this.edd,
    this.isCompleted = false,
    this.deliveredAt,
    required this.createdAt,
    this.babyName,
    this.pregnancyOrder,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'cycleLength': cycleLength,
      'selectedLmp': selectedLmp.toIso8601String(),
      'edd': edd.toIso8601String(),
      'isCompleted': isCompleted,
      'deliveredAt': deliveredAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'babyName': babyName,
      'pregnancyOrder': pregnancyOrder,
    };
  }

  factory MedisModel.fromJson(Map<String, dynamic> json) {
    return MedisModel(
      id: json['id'],
      userId: json['userId'],
      cycleLength: json['cycleLength'],
      selectedLmp: DateTime.parse(json['selectedLmp']),
      edd: DateTime.parse(json['edd']),
      isCompleted: json['isCompleted'] ?? false,
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      babyName: json['babyName'],
      pregnancyOrder: json['pregnancyOrder'],
    );
  }
}