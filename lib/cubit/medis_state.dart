part of 'medis_cubit.dart';

abstract class MedisState extends Equatable {
  const MedisState();

  @override
  List<Object> get props => [];
}

class MedisInitial extends MedisState {}

class MedisLoading extends MedisState {}

class MedisSuccess extends MedisState {
  final MedisModel? activeMedis;
  final List<MedisModel> medisHistory;

  const MedisSuccess({this.activeMedis, required this.medisHistory});

  @override
  List<Object> get props => [medisHistory];
}

class MedisFailed extends MedisState {
  final String error;

  const MedisFailed(this.error);

  @override
  List<Object> get props => [error];
}