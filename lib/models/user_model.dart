import 'package:equatable/equatable.dart';

class UserModel extends Equatable{

  final String id;
  final String email;
  final String name;
  final String role;
  final String alamat;
  final DateTime tglLahir;
  final bool emailVerified;

  final String hospitalId;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.alamat,
    required this.tglLahir,
    required this.hospitalId,
    this.emailVerified = false, // DEFAULT FALSE
    this.createdAt,
    this.updatedAt,
});

  // COPY WITH METHOD UNTUK UPDATE DATA
  UserModel copyWith({
    String? name,
    String? alamat,
    DateTime? tglLahir,
    bool? emailVerified,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id,
      email: email,
      name: name ?? this.name,
      role: role,
      alamat: alamat ?? this.alamat,
      tglLahir: tglLahir ?? this.tglLahir,
      hospitalId: hospitalId,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email, // TAMBAHKAN EMAIL KE PROPS
    name,
    role,
    alamat,
    tglLahir,
    hospitalId,
    emailVerified,
    createdAt,
    updatedAt,
  ];

}