import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/medis_model.dart';
import '../services/medis_service.dart';

part 'medis_state.dart';

class MedisCubit extends Cubit<MedisState> {
  final MedisServices _medisServices;

  MedisCubit() : _medisServices = MedisServices(), super(MedisInitial());

  Future<void> addMedis({
    required String userId,
    required int cycleLength,
    required DateTime selectedLmp,
    required DateTime edd,
    String? babyName,
  }) async {
    try {
      print("=== [MedisCubit] addMedis start ===");
      emit(MedisLoading());

      await _medisServices.addMedis(
        userId: userId,
        cycleLength: cycleLength,
        selectedLmp: selectedLmp,
        edd: edd,
        babyName: babyName,
      );

      // Setelah sukses, ambil semua data medis user
      print("=== [MedisCubit] addMedis sukses, panggil _loadUserMedis ===");
      await _loadUserMedis(userId);
    } catch (e) {
      print("!!! [MedisCubit] ERROR addMedis: $e");
      emit(MedisFailed(e.toString()));
    }
  }

  void markAsCompleted(String medisId, DateTime deliveredAt, {String? babyName}) async {
    try {
      emit(MedisLoading());

      await _medisServices.markAsCompleted(medisId, deliveredAt, babyName: babyName);

      // Cari userId dari state saat ini untuk reload data
      if (state is MedisSuccess) {
        final currentState = state as MedisSuccess;
        final medis = currentState.medisHistory.firstWhere((m) => m.id == medisId);
        await _loadUserMedis(medis.userId);
      }
    } catch (e) {
      emit(MedisFailed(e.toString()));
    }
  }

  Future<void> getUserMedis(String userId) async {
    try {
      emit(MedisLoading());
      await _loadUserMedis(userId);
    } catch (e) {
      emit(MedisFailed(e.toString()));
    }
  }

  void deleteMedis(String medisId) async {
    try {
      emit(MedisLoading());

      // Cari userId dari data yang akan dihapus
      final medisToDelete = await _medisServices.getMedisById(medisId);

      await _medisServices.deleteMedis(medisId);

      // Reload data setelah hapus
      await _loadUserMedis(medisToDelete.userId);
    } catch (e) {
      emit(MedisFailed(e.toString()));
    }
  }

  // Helper method untuk load data user
  Future<void> _loadUserMedis(String userId) async {
    try {
      print("=== [MedisCubit] _loadUserMedis userId=$userId ===");
      final medisHistory = await _medisServices.getMedisByUserId(userId);
      final activeMedis = await _medisServices.getActiveMedis(userId);

      print("MedisHistory count: ${medisHistory.length}");
      print("ActiveMedis: ${activeMedis?.id}");

      emit(MedisSuccess(
        activeMedis: activeMedis,
        medisHistory: medisHistory,
      ));
      print("=== [MedisCubit] emit MedisSuccess ===");
    } catch (e) {
      print("!!! [MedisCubit] ERROR _loadUserMedis: $e");
      emit(MedisFailed(e.toString()));
    }
  }
}