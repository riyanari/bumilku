import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserServices {
  final CollectionReference _userReference = FirebaseFirestore.instance
      .collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'username': user.username,
        'name': user.name,
        'role': user.role,
        'alamat': user.alamat,
        'tglLahir': user.tglLahir,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
        id: id,
        username: snapshot['username'],
        name: snapshot['name'],
        role: snapshot['role'],
        alamat: snapshot['alamat'],
        tglLahir: snapshot['tglLahir'] != null
            ? (snapshot['tglLahir'] as Timestamp).toDate()
            : DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
