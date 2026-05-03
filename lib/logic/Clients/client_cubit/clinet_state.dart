part of 'clinet_cubit.dart';

@immutable
sealed class Clientstate {
  final List<ClinetModel>? clinet;
  const Clientstate({this.clinet});
}

final class ClientInitial extends Clientstate {
  ClientInitial() : super(clinet: []);
}

final class Clientsucsess extends Clientstate {
  const Clientsucsess(List<ClinetModel>? clinets) : super(clinet: clinets);
}

final class Clientloading extends Clientstate {
  const Clientloading() : super(clinet: null);
}

final class Clientfailed extends Clientstate {
  final String errormesaage;
  const Clientfailed(this.errormesaage) : super(clinet: const []);
}
