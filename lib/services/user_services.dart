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

  // TAMBAHKAN METHOD UPDATE USER
  Future<UserModel> updateUser({
    required String userId,
    required String name,
    required String alamat,
    required DateTime tglLahir,
  }) async {
    try {
      await _userReference.doc(userId).update({
        'name': name,
        'alamat': alamat,
        'tglLahir': tglLahir,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Get updated user data
      DocumentSnapshot snapshot = await _userReference.doc(userId).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      return UserModel(
        id: snapshot.id,
        username: data['username'],
        name: data['name'],
        role: data['role'],
        alamat: data['alamat'],
        tglLahir: (data['tglLahir'] as Timestamp).toDate(),
      );
    } catch (e) {
      throw Exception('Gagal mengupdate profile: $e');
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
