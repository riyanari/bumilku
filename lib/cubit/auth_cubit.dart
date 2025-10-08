import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';
import '../services/auth_services.dart';
import '../services/user_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthServices().signIn(
        email: email,
        password: password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String role,
    required String alamat,
    required DateTime tglLahir,
  }) async {
    try {
      emit(AuthLoading());
      print("[AuthCubit] Starting sign up process...");

      UserModel user = await AuthServices().signUp(
        email: email,
        password: password,
        name: name,
        role: role,
        alamat: alamat,
        tglLahir: tglLahir,
      );

      print("[AuthCubit] Sign up successful, emitting AuthEmailVerificationRequired");

      // 👇 STATE YANG BENAR
      emit(AuthEmailVerificationRequired(
        user: user,
        email: email,
      ));

    } catch (e) {
      print("[AuthCubit] Sign up failed: $e");
      emit(AuthFailed(e.toString()));
    }
  }

  // METHOD UNTUK KIRIM ULANG VERIFIKASI EMAIL
  Future<void> sendEmailVerification() async {
    try {
      emit(AuthLoading());
      await AuthServices().sendEmailVerification();
      emit(AuthEmailVerificationSent());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

// DAN METHOD checkEmailVerification JUGA
  Future<void> checkEmailVerification() async {
    try {
      emit(AuthLoading());
      bool isVerified = await AuthServices().checkEmailVerification();
      if (isVerified) {
        // JIKA SUDAH TERVERIFIKASI, AMBIL DATA USER TERBARU
        User? firebaseUser = AuthServices().getCurrentUser();
        if (firebaseUser != null) {
          UserModel user = await UserServices().getUserById(firebaseUser.uid);
          emit(AuthSuccess(user));
        } else {
          emit(AuthFailed("User tidak ditemukan"));
        }
      } else {
        emit(AuthEmailNotVerified());
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  // METHOD UNTUK LUPA PASSWORD
  void resetPassword(String email) async {
    try {
      emit(AuthLoading());
      await AuthServices().resetPassword(email);
      emit(AuthPasswordResetSent());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  // TAMBAHKAN METHOD UPDATE PROFILE
  void updateProfile({
    required String userId,
    required String name,
    required String alamat,
    required DateTime tglLahir,
  }) async {
    try {
      emit(AuthLoading());

      UserModel updatedUser = await AuthServices().updateProfile(
        userId: userId,
        name: name,
        alamat: alamat,
        tglLahir: tglLahir,
      );

      emit(AuthSuccess(updatedUser));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthServices().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      UserModel user = await UserServices().getUserById(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
