import 'package:bumilku_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

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
      rethrow;
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

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
