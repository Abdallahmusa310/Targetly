import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/data/models/client_model.dart';

part 'clinet_state.dart';

class ClinetCubit extends Cubit<ClinetState> {
  ClinetCubit() : super(ClinetInitial());

  Future<void> fetchClients() async {
    try {
      emit(Clinetloading());

      final clients = HiveManager.clients.values.toList();

      emit(Clinetsucsess(clients));
    } catch (e) {
      emit(Clinetfailed(e.toString()));
    }
  }

  Future<void> addClient(ClinetModel client) async {
    try {
      emit(Clinetloading());

      await HiveManager.clients.add(client);

      final clients = HiveManager.clients.values.toList();

      emit(Clinetsucsess(clients));
    } catch (e) {
      emit(Clinetfailed(e.toString()));
    }
  }
}
