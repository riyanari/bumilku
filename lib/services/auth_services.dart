import 'package:bumilku_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String _getUserFriendlyError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('user-not-found') ||
        errorString.contains('invalid-credential')) {
      return 'Username tidak ditemukan. Periksa kembali username atau password Anda.';
    } else if (errorString.contains('wrong-password')) {
      return 'Password yang dimasukkan salah. Silakan coba lagi.';
    } else if (errorString.contains('network-request-failed')) {
      return 'Koneksi internet terputus. Periksa koneksi Anda.';
    } else if (errorString.contains('too-many-requests')) {
      return 'Terlalu banyak percobaan login. Tunggu beberapa saat lagi.';
    } else if (errorString.contains('email-already-in-use')) {
      return 'Username sudah digunakan. Silakan pilih username lain.';
    } else if (errorString.contains('weak-password')) {
      return 'Password terlalu lemah. Gunakan minimal 6 karakter.';
    } else {
      return 'Terjadi kesalahan. Silakan coba lagi.';
    }
  }

  Future<UserModel> signIn({
    required String username,
    required String password,
  }) async {
    String email = "$username@bumilku.com";
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = await UserServices().getUserById(
        userCredential.user!.uid,
      );
      return user;
    } catch (e) {
      throw Exception(_getUserFriendlyError(e));
    }
  }

  Future<UserModel> signUp({
    required String username,
    required String name,
    required String password,
    required String role,
    required String alamat,
    required DateTime tglLahir,
  }) async {
    try {
      String email = "$username@bumilku.com";
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        username: username,
        name: name,
        role: role,
        alamat: alamat,
        tglLahir: tglLahir,
      );

      await UserServices().setUser(user);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  // TAMBAHKAN METHOD UPDATE PROFILE
  Future<UserModel> updateProfile({
    required String userId,
    required String name,
    required String alamat,
    required DateTime tglLahir,
  }) async {
    try {
      UserModel updatedUser = await UserServices().updateUser(
        userId: userId,
        name: name,
        alamat: alamat,
        tglLahir: tglLahir,
      );

      return updatedUser;
    } catch (e) {
      throw Exception(_getUserFriendlyError(e));
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
