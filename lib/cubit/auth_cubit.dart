import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    required String username,
    required String password,
    required String role,
    required String alamat,
    required DateTime tglLahir,
  }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthServices().signUp(
        username: username,
        password: password,
        name: name,
        role: role,
        alamat: alamat,
        tglLahir: tglLahir,
      );

      emit(AuthSuccess(user));
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
