// self_detection_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/self_detection_model.dart';
import '../services/self_detection_service.dart';

part 'self_detection_state.dart';

class SelfDetectionCubit extends Cubit<SelfDetectionState> {
  final SelfDetectionService _selfDetectionService;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SelfDetectionCubit()
      : _selfDetectionService = SelfDetectionService(),
        super(SelfDetectionInitial());

  // Simpan hasil deteksi ke Firebase
  Future<void> saveDetectionResult({
    required String userId,
    required Map<String, dynamic> riskResult,
  }) async {
    try {
      emit(SelfDetectionLoading());

      // DEBUG: Print data sebelum save
      print("💾 CUBIT: Saving detection result with fetal movement data:");
      print("   hasFetalMovementData: ${riskResult['hasFetalMovementData']}");
      print("   fetalMovementCount: ${riskResult['fetalMovementCount']}");
      print("   fetalMovementDuration: ${riskResult['fetalMovementDuration']}");

      await _selfDetectionService.saveDetectionResult(
        userId: userId,
        riskResult: riskResult,
      );

      emit(SelfDetectionSuccess('Hasil deteksi berhasil disimpan'));

      // Otomatis reload history setelah save
      await getDetectionHistory(userId);
    } catch (e) {
      emit(SelfDetectionFailed('Gagal menyimpan hasil deteksi: $e'));
    }
  }

  // Ambil riwayat deteksi dari Firebase
  Future<void> getDetectionHistory(String userId) async {
    try {
      emit(SelfDetectionLoading());

      final history = await _selfDetectionService.getDetectionHistory(userId);

      // Convert ke SelfDetectionModel - ✅ PERBAIKI DI SINI!
      final detectionHistory = history.map((data) {
        // DEBUG: Print data dari service
        print("🔄 CUBIT: Converting data to SelfDetectionModel:");
        print("   ID: ${data['id']}");
        print("   hasFetalMovementData: ${data['hasFetalMovementData']}");
        print("   fetalMovementCount: ${data['fetalMovementCount']}");

        return SelfDetectionModel(
          id: data['id'] ?? '',
          userId: data['userId'] ?? '',
          riskLevel: data['riskLevel'] ?? 'unknown',
          score: (data['score'] as num?)?.toInt() ?? 0,
          details: List<String>.from(data['details'] ?? []),
          recommendation: data['recommendation'] ?? '',
          riskEducation: data['riskEducation'] as Map<String, dynamic>?,
          generalTips: data['generalTips'] as List<dynamic>?,
          date: DateTime.tryParse(data['date'] ?? '') ?? DateTime.now(),
          createdAt: data['createdAt'] != null
              ? DateTime.tryParse(data['createdAt'])
              : null,

          // ✅ TAMBAHKAN DATA GERAKAN JANIN DI SINI!
          hasFetalMovementData: data['hasFetalMovementData'] == true,
          fetalMovementCount: (data['fetalMovementCount'] as num?)?.toInt(),
          fetalMovementDuration: (data['fetalMovementDuration'] as num?)?.toInt(),
          movementsPerHour: (data['movementsPerHour'] as num?)?.toDouble(),
          fetalMovementStatus: data['fetalMovementStatus'] as Map<String, dynamic>?,
          movementComparison: data['movementComparison'] as String?,
          fetalActivityPattern: data['fetalActivityPattern'] as String?,
          fetalAdditionalComplaints: data['fetalAdditionalComplaints'] as List<dynamic>?,
          fetalMovementDateTime: data['fetalMovementDateTime'] as String?,
        );
      }).toList();

      emit(SelfDetectionHistoryLoaded(detectionHistory));
    } catch (e) {
      emit(SelfDetectionFailed('Gagal mengambil riwayat deteksi: $e'));
    }
  }

  // Hapus riwayat deteksi
  Future<void> deleteDetection(String detectionId) async {
    try {
      emit(SelfDetectionLoading());

      await _selfDetectionService.deleteDetection(detectionId);

      emit(SelfDetectionSuccess('Riwayat deteksi berhasil dihapus'));

      // Reload history setelah delete - gunakan current user dari FirebaseAuth
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        await getDetectionHistory(currentUser.uid);
      }
    } catch (e) {
      emit(SelfDetectionFailed('Gagal menghapus riwayat deteksi: $e'));
    }
  }

  // Clear state
  void clearState() {
    emit(SelfDetectionInitial());
  }
}