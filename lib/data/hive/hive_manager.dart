import 'package:hive_flutter/hive_flutter.dart';
import 'package:targetly/data/models/activity_model.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/data/models/target_model.dart';

class HiveManager {
  static const String settingsBoxName = 'settings_box';
  static const String clientsBoxName = 'clients_box';
  static const String activityBoxName = 'activity_box';
  static const String userBoxName = 'user_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ClinetModelAdapter());
    Hive.registerAdapter(TargetModelAdapter());
    Hive.registerAdapter(ActivityModelAdapter());

    await Hive.openBox<TargetModel>(settingsBoxName);
    await Hive.openBox<ClinetModel>(clientsBoxName);
    await Hive.openBox<ActivityModel>(activityBoxName);
    await Hive.openBox(userBoxName);
  }

  static Box<ClinetModel> get clients => Hive.box<ClinetModel>(clientsBoxName);

  static Box<TargetModel> get settingsbox =>
      Hive.box<TargetModel>(settingsBoxName);
  static Box<ActivityModel> get activitybox =>
      Hive.box<ActivityModel>(activityBoxName);

  static Box get user => Hive.box(userBoxName);

  static void saveUsername(String name) {
    user.put('username', name);
  }

  static String getUsername() {
    return user.get('username') ?? "User";
  }

  static void clearUser() {
    user.delete('username');
  }
}
