import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/medis_model.dart';

class MedisServices {
  final CollectionReference _medisReference =
  FirebaseFirestore.instance.collection('medis');

  Future<void> addMedis({
    required String userId,
    required int cycleLength,
    required DateTime selectedLmp,
    required DateTime edd,
    String? babyName,
  }) async {
    try {
      print("=== [MedisServices] addMedis dipanggil ===");
      print("userId: $userId");
      print("cycleLength: $cycleLength");
      print("selectedLmp: $selectedLmp");
      print("edd: $edd");
      print("babyName: $babyName");

      // Generate ID unik untuk setiap kehamilan
      String medisId = _medisReference.doc().id;

      // Hitung urutan kehamilan
      int pregnancyOrder = await _getNextPregnancyOrder(userId);
      print("Generated medisId: $medisId, pregnancyOrder: $pregnancyOrder");

      MedisModel medis = MedisModel(
        id: medisId,
        userId: userId,
        cycleLength: cycleLength,
        selectedLmp: selectedLmp,
        edd: edd,
        babyName: babyName,
        pregnancyOrder: pregnancyOrder,
        createdAt: DateTime.now(),
      );

      await setMedis(medis);
      print("=== [MedisServices] Data berhasil disimpan ke Firestore ===");
    } catch (e) {
      print("!!! [MedisServices] ERROR addMedis: $e");
      rethrow;
    }
  }

  /// Dapatkan urutan kehamilan berikutnya
  Future<int> _getNextPregnancyOrder(String userId) async {
    try {
      final query = await _medisReference
          .where('userId', isEqualTo: userId)
          .orderBy('pregnancyOrder', descending: true)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        return 1; // Kehamilan pertama
      }

      final lastMedis = query.docs.first;
      final lastOrder = lastMedis['pregnancyOrder'] as int?;
      return (lastOrder ?? 0) + 1;
    } catch (e) {
      rethrow;
    }
  }

  /// Simpan data medis
  Future<void> setMedis(MedisModel medis) async {
    try {
      await _medisReference.doc(medis.id).set(medis.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markAsCompleted(String medisId, DateTime deliveredAt, {String? babyName}) async {
    try {
      await _medisReference.doc(medisId).update({
        'isCompleted': true,
        'deliveredAt': deliveredAt.toIso8601String(),
        if (babyName != null) 'babyName': babyName,
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Ambil data medis berdasarkan ID medis
  Future<MedisModel> getMedisById(String medisId) async {
    try {
      DocumentSnapshot snapshot = await _medisReference.doc(medisId).get();
      if (!snapshot.exists) {
        throw Exception('Data medis tidak ditemukan');
      }
      return MedisModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Ambil semua riwayat kehamilan user
  Future<List<MedisModel>> getMedisByUserId(String userId) async {
    try {
      QuerySnapshot snapshot = await _medisReference
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return MedisModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Ambil kehamilan aktif (yang belum selesai)
  Future<MedisModel?> getActiveMedis(String userId) async {
    try {
      QuerySnapshot snapshot = await _medisReference
          .where('userId', isEqualTo: userId)
          .where('isCompleted', isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      return MedisModel.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Hapus data medis
  Future<void> deleteMedis(String medisId) async {
    try {
      await _medisReference.doc(medisId).delete();
    } catch (e) {
      rethrow;
    }
  }
}