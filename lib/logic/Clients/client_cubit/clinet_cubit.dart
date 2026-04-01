import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/data/models/client_model.dart';

part 'clinet_state.dart';

class ClinetCubit extends Cubit<ClinetState> {
  ClinetCubit() : super(ClinetInitial());
  List<ClinetModel> allClients = [];
  List<ClinetModel> filteredClients = [];

  Future<void> fetchClients() async {
    try {
      emit(Clinetloading());

      allClients = HiveManager.clients.values.toList();
      filteredClients = allClients;

      emit(Clinetsucsess(filteredClients));
    } catch (e) {
      emit(Clinetfailed(e.toString()));
    }
  }

  Future<void> addClient(ClinetModel client) async {
    try {
      await HiveManager.clients.add(client);
      await fetchClients();
    } catch (e) {
      emit(Clinetfailed(e.toString()));
    }
  }

  void searchClients(String query) {
    if (query.isEmpty) {
      filteredClients = allClients;
    } else {
      filteredClients = allClients.where((client) {
        return client.clinetid.toLowerCase().contains(query.toLowerCase()) ||
            client.clinetphone.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    emit(Clinetsucsess(filteredClients));
  }

  Future<void> deleteClient(ClinetModel client) async {
    try {
      await client.delete();

      await fetchClients();
    } catch (e) {
      emit(Clinetfailed(e.toString()));
    }
  }
}
