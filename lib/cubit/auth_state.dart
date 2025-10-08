part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {

  final UserModel user;

  const AuthSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];

}

class AuthFailed extends AuthState {

  final String error;

  const AuthFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];

}

class AuthEmailVerificationRequired extends AuthState {
  final UserModel user;
  final String email;
  const AuthEmailVerificationRequired({required this.user, required this.email});

  @override
  List<Object> get props => [user, email];
}

// TAMBAHKAN STATE BARU UNTUK EMAIL VERIFIKASI
class AuthEmailVerificationSent extends AuthState {}

class AuthEmailNotVerified extends AuthState {}

class AuthPasswordResetSent extends AuthState {}