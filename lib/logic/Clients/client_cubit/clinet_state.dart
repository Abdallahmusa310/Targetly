part of 'clinet_cubit.dart';

@immutable
sealed class ClinetState {
  final List<ClinetModel>? clinet;
  const ClinetState({this.clinet});
}

final class ClinetInitial extends ClinetState {
  ClinetInitial() : super(clinet: []);
}

final class Clinetsucsess extends ClinetState {
  const Clinetsucsess(List<ClinetModel>? clinets) : super(clinet: clinets);
}

final class Clinetloading extends ClinetState {
  const Clinetloading() : super(clinet: const []);
}

final class Clinetfailed extends ClinetState {
  final String errormesaage;
  const Clinetfailed(this.errormesaage) : super(clinet: const []);
}
