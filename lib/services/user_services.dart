import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserServices {
  final CollectionReference _userReference = FirebaseFirestore.instance
      .collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'role': user.role,
        'alamat': user.alamat,
        'tglLahir': user.tglLahir,
        'emailVerified': user.emailVerified, // TAMBAHKAN STATUS VERIFIKASI
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
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
        email: data['email'],
        name: data['name'],
        role: data['role'],
        alamat: data['alamat'],
        tglLahir: (data['tglLahir'] as Timestamp).toDate(),
        emailVerified: data['emailVerified'] ?? false,
        createdAt: data['createdAt'] != null
            ? (data['createdAt'] as Timestamp).toDate()
            : null,
        updatedAt: data['updatedAt'] != null
            ? (data['updatedAt'] as Timestamp).toDate()
            : null,
      );
    } catch (e) {
      throw Exception('Gagal mengupdate profile: $e');
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      if (!snapshot.exists) {
        throw Exception('User tidak ditemukan');
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      return UserModel(
        id: id,
        email: data['email'] ?? '', // TAMBAHKAN EMAIL
        name: data['name'],
        role: data['role'],
        alamat: data['alamat'],
        tglLahir: data['tglLahir'] != null
            ? (data['tglLahir'] as Timestamp).toDate()
            : DateTime.now(),
        emailVerified: data['emailVerified'] ?? false,
        createdAt: data['createdAt'] != null
            ? (data['createdAt'] as Timestamp).toDate()
            : null,
        updatedAt: data['updatedAt'] != null
            ? (data['updatedAt'] as Timestamp).toDate()
            : null,
      );
    } catch (e) {
      rethrow;
    }
  }
}
