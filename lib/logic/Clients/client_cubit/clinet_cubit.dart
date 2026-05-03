import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/data/models/activity_model.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';

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

  Future<void> addClient(
    ClinetModel client,
    ActivityCubit activityCubit,
  ) async {
    try {
      emit(Clinetloading());
      await HiveManager.clients.add(client);

      await HiveManager.activitybox.add(
        ActivityModel(
          text: "New client: ${client.clinetname}",
          date: DateTime.now(),
        ),
      );
      await activityCubit.fetchActivities();
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
            client.clinetphone.toLowerCase().contains(query.toLowerCase()) ||
            client.clinetname.toLowerCase().contains(query.toLowerCase());
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

  Future<void> clearClients() async {
    try {
      await HiveManager.clients.clear();

      await fetchClients();
    } catch (e) {
      emit(Clinetfailed(e.toString()));
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
