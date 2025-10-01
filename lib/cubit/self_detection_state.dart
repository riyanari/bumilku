// self_detection_state.dart
part of 'self_detection_cubit.dart';

abstract class SelfDetectionState extends Equatable {
  const SelfDetectionState();

  @override
  List<Object> get props => [];
}

class SelfDetectionInitial extends SelfDetectionState {}

class SelfDetectionLoading extends SelfDetectionState {}

class SelfDetectionSuccess extends SelfDetectionState {
  final String message;

  const SelfDetectionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SelfDetectionHistoryLoaded extends SelfDetectionState {
  final List<SelfDetectionModel> detectionHistory;

  const SelfDetectionHistoryLoaded(this.detectionHistory);

  @override
  List<Object> get props => [detectionHistory];
}

class SelfDetectionFailed extends SelfDetectionState {
  final String error;

  const SelfDetectionFailed(this.error);

  @override
  List<Object> get props => [error];
}