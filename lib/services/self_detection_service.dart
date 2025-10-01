// self_detection_service.dart (tambahan method)
import 'package:cloud_firestore/cloud_firestore.dart';

class SelfDetectionService {
  final CollectionReference _detectionRef =
  FirebaseFirestore.instance.collection('self_detections');

  Future<void> saveDetectionResult({
    required String userId,
    required Map<String, dynamic> riskResult,
  }) async {
    try {
      await _detectionRef.add({
        'userId': userId,
        'date': DateTime.now().toIso8601String(),
        'riskLevel': riskResult['riskLevel'] ?? 'unknown',
        'score': riskResult['score'] ?? 0,
        'details': riskResult['details'] ?? [],
        'recommendation': riskResult['recommendation'] ?? '',
        'riskEducation': riskResult['riskEducation'],
        'generalTips': riskResult['generalTips'],
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("❌ Error saving to Firestore: $e");
      rethrow;
    }
  }

  // self_detection_service.dart - gunakan query dengan createdAt
  Future<List<Map<String, dynamic>>> getDetectionHistory(String userId) async {
    try {
      print("🔍 Fetching detection history for user: $userId with createdAt sorting");

      // Sekarang index sudah tersedia, gunakan query yang optimal
      final snapshot = await _detectionRef
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      print("📊 Found ${snapshot.docs.length} detection records");

      final results = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        // Handle Timestamp untuk createdAt
        Timestamp? createdAtTimestamp = data['createdAt'] as Timestamp?;
        DateTime? createdAt = createdAtTimestamp?.toDate();

        // Handle string untuk date
        DateTime date;
        try {
          date = DateTime.parse(data['date'] ?? '');
        } catch (e) {
          date = DateTime.now();
        }

        final result = {
          "id": doc.id,
          "userId": data['userId'] ?? '',
          "riskLevel": data['riskLevel'] ?? 'unknown',
          "score": data['score'] ?? 0,
          "details": List<String>.from(data['details'] ?? []),
          "recommendation": data['recommendation'] ?? '',
          "riskEducation": data['riskEducation'] as Map<String, dynamic>?,
          "generalTips": data['generalTips'] as List<dynamic>?,
          "date": date.toIso8601String(),
          "createdAt": createdAt?.toIso8601String(),
        };

        print("📝 Detection: ${result['date']} - ${result['riskLevel']} - Created: ${result['createdAt']}");
        return result;
      }).toList();

      return results;
    } catch (e) {
      print("❌ Error fetching history with createdAt: $e");
      rethrow;
    }
  }

  // Tambahan method untuk delete (opsional)
  Future<void> deleteDetection(String detectionId) async {
    try {
      await _detectionRef.doc(detectionId).delete();
    } catch (e) {
      print("❌ Error deleting detection: $e");
      rethrow;
    }
  }

  // Method untuk get by ID (opsional)
  Future<Map<String, dynamic>?> getDetectionById(String detectionId) async {
    try {
      final doc = await _detectionRef.doc(detectionId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          "id": doc.id,
          ...data,
        };
      }
      return null;
    } catch (e) {
      print("❌ Error fetching detection by ID: $e");
      rethrow;
    }
  }
}