import 'package:equatable/equatable.dart';

class UserModel extends Equatable{

  final String id;
  final String username;
  final String name;
  final String role;
  final String alamat;
  final DateTime tglLahir;

  const UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.role,
    required this.alamat,
    required this.tglLahir,
});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, role, alamat, tglLahir];

}