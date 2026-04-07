part of 'target_cubit.dart';

@immutable
sealed class TargetState {}

final class TargetInitial extends TargetState {}

final class TargetLoading extends TargetState {}

final class TargetSuccess extends TargetState {
  final TargetModel? target;
  TargetSuccess(this.target);
}

class TargetFailure extends TargetState {
  final String error;

  TargetFailure(this.error);
}
