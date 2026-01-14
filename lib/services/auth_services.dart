import 'package:bumilku_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // String _getUserFriendlyError(dynamic error) {
  //   final errorString = error.toString().toLowerCase();
  //
  //   if (errorString.contains('user-not-found') ||
  //       errorString.contains('invalid-credential')) {
  //     return 'Email tidak ditemukan. Periksa kembali email atau password Anda.';
  //   } else if (errorString.contains('wrong-password')) {
  //     return 'Password yang dimasukkan salah. Silakan coba lagi.';
  //   } else if (errorString.contains('network-request-failed')) {
  //     return 'Koneksi internet terputus. Periksa koneksi Anda.';
  //   } else if (errorString.contains('too-many-requests')) {
  //     return 'Terlalu banyak percobaan login. Tunggu beberapa saat lagi.';
  //   } else if (errorString.contains('email-already-in-use')) {
  //     return 'Email sudah digunakan. Silakan pilih email lain.';
  //   } else if (errorString.contains('weak-password')) {
  //     return 'Password terlalu lemah. Gunakan minimal 6 karakter.';
  //   } else if (errorString.contains('invalid-email')) {
  //     return 'Format email tidak valid.';
  //   } else if (errorString.contains('user-disabled')) {
  //     return 'Akun ini telah dinonaktifkan.';
  //   } else {
  //     return 'Terjadi kesalahan. Silakan coba lagi.';
  //   }
  // }

  String _getUserFriendlyError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    // 👇 TANGANI ERROR EMAIL BELUM TERVERIFIKASI SECARA KHUSUS
    if (errorString.contains('email_not_verified')) {
      final parts = error.toString().split(':');
      if (parts.length >= 3) {
        final userId = parts[1];
        final userEmail = parts[2];
        return 'EMAIL_NOT_VERIFIED:$userId:$userEmail';
      }
      return 'Email belum terverifikasi. Silakan cek email Anda untuk verifikasi.';
    }

    if (errorString.contains('user-not-found') ||
        errorString.contains('invalid-credential')) {
      return 'Email tidak ditemukan. Periksa kembali email atau password Anda.';
    } else if (errorString.contains('wrong-password')) {
      return 'Password yang dimasukkan salah. Silakan coba lagi.';
    } else if (errorString.contains('network-request-failed')) {
      return 'Koneksi internet terputus. Periksa koneksi Anda.';
    } else if (errorString.contains('too-many-requests')) {
      return 'Terlalu banyak percobaan login. Tunggu beberapa saat lagi.';
    } else if (errorString.contains('email-already-in-use')) {
      return 'Email sudah digunakan. Silakan pilih email lain.';
    } else if (errorString.contains('weak-password')) {
      return 'Password terlalu lemah. Gunakan minimal 6 karakter.';
    } else if (errorString.contains('invalid-email')) {
      return 'Format email tidak valid.';
    } else if (errorString.contains('user-disabled')) {
      return 'Akun ini telah dinonaktifkan.';
    } else {
      return 'Terjadi kesalahan. Silakan coba lagi.';
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // CEK APAKAH EMAIL SUDAH TERVERIFIKASI
      if (!userCredential.user!.emailVerified) {
        // JANGAN LOGOUT, lempar exception khusus
        throw Exception('EMAIL_NOT_VERIFIED:${userCredential.user!.uid}:${userCredential.user!.email}');
      }

      UserModel user = await UserServices().getUserById(
        userCredential.user!.uid,
      );
      return user;
    } catch (e) {
      throw Exception(_getUserFriendlyError(e));
    }
  }

  Future<UserModel> signUp({
    required String email,
    required String name,
    required String password,
    required String role,
    required String hospitalId,
    required String alamat,
    required DateTime tglLahir,
  }) async {
    try {
      // Register dengan email
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
          email: email.trim(),
          password: password
      );

      // Kirim email verifikasi
      await userCredential.user!.sendEmailVerification();

      // 👇 LOGOUT USER SETELAH SIGN UP - INI PENTING!
      // await _auth.signOut();

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email.trim(),
        name: name,
        role: role,
        hospitalId: hospitalId,
        alamat: alamat,
        tglLahir: tglLahir,
        emailVerified: false,
      );

      await UserServices().setUser(user);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  // METHOD UNTUK KIRIM ULANG EMAIL VERIFIKASI
  Future<void> sendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
      } else {
        throw Exception('Tidak ada user yang login');
      }
    } catch (e) {
      throw Exception('Gagal mengirim email verifikasi: $e');
    }
  }

  // METHOD UNTUK CEK STATUS VERIFIKASI EMAIL
  Future<bool> checkEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // RELOAD USER UNTUK MENDAPATKAN STATUS TERBARU
        await user.reload();
        user = _auth.currentUser;
        return user?.emailVerified ?? false;
      }
      return false;
    } catch (e) {
      throw Exception('Gagal memeriksa verifikasi email: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      throw Exception(_getUserFriendlyError(e));
    }
  }

  // METHOD UNTUK UPDATE EMAIL
  Future<void> updateEmail(String newEmail) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.verifyBeforeUpdateEmail(newEmail.trim());
      } else {
        throw Exception('Tidak ada user yang login');
      }
    } catch (e) {
      throw Exception(_getUserFriendlyError(e));
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

  // GET CURRENT USER DARI FIREBASE AUTH
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
