import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';

part 'clinet_state.dart';

class ClinetCubit extends Cubit<Clientstate> {
  ClinetCubit() : super(ClientInitial());
  List<ClinetModel> allClients = [];
  List<ClinetModel> filteredClients = [];

  Future<void> fetchClients() async {
    try {
      emit(Clientloading());
      allClients = HiveManager.clients.values.toList();
      filteredClients = allClients;
      emit(Clientsucsess(filteredClients));
    } catch (e) {
      emit(Clientfailed(e.toString()));
    }
  }

  Future<void> addclient({
    required String name,
    required String phone,
    required String fees,
    required String id,
    required ActivityCubit activityCubit,
  }) async {
    try {
      final newClient = ClinetModel(
        clinetname: name,
        clinetphone: phone,
        clinetfees: fees,
        clinetid: id,
        createdAt: DateTime.now(),
      );
      await activityCubit.fetchActivities();
      await HiveManager.clients.add(newClient);
      fetchClients();
    } catch (e) {
      emit(Clientfailed(e.toString()));
    }
  }

  void searchClients(String query) {
    if (query.isEmpty) {
      filteredClients = allClients;
    } else {
      filteredClients = allClients.where((client) {
        return client.clinetid.toLowerCase().contains(query.toLowerCase()) ||
            client.clinetphone.toLowerCase().contains(query.toLowerCase()) ||
            client.clinetname.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    emit(Clientsucsess(filteredClients));
  }

  Future<void> deleteClient(ClinetModel client) async {
    try {
      await client.delete();

      await fetchClients();
    } catch (e) {
      emit(Clientfailed(e.toString()));
    }
  }

  double getTotalFees() {
    return allClients.fold(
      0,
      (sum, client) => sum + (double.tryParse(client.clinetfees) ?? 0),
    );
  }

  ({double achieved, int totalClients}) getStatsInRange(
    DateTime start,
    DateTime end,
  ) {
    double achieved = 0;
    int count = 0;

    for (var client in allClients) {
      final date = client.createdAt;

      if (date == null) continue;

      final inRange = !date.isBefore(start) && !date.isAfter(end);

      if (inRange) {
        count++;
        achieved += double.tryParse(client.clinetfees) ?? 0;
      }
    }

    return (achieved: achieved, totalClients: count);
  }

  ({double achieved, int totalClients}) getTodayStats() {
    final now = DateTime.now();

    double achieved = 0;
    int count = 0;

    for (var client in allClients) {
      final date = client.createdAt;
      if (date == null) continue;

      final isToday =
          date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      if (isToday) {
        count++;
        achieved += double.tryParse(client.clinetfees) ?? 0;
      }
    }

    return (achieved: achieved, totalClients: count);
  }

  int getClientsCount() => allClients.length;
}
