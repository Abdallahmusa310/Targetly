import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:targetly/data/models/activity_model.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/data/models/target_model.dart';

class HiveManager {
  static const String userBoxName = 'user_box';

  static String get _userId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'guest';

  static String get _clientsBoxName => 'clients_$_userId';
  static String get _settingsBoxName => 'settings_$_userId';
  static String get _activityBoxName => 'activity_$_userId';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ClinetModelAdapter());
    Hive.registerAdapter(TargetModelAdapter());
    Hive.registerAdapter(ActivityModelAdapter());

    await Hive.openBox(userBoxName);
  }

  static Future<void> openUserBoxes() async {
    try {
      if (!Hive.isBoxOpen(_clientsBoxName)) {
        await Hive.openBox<ClinetModel>(_clientsBoxName);
      }
      if (!Hive.isBoxOpen(_settingsBoxName)) {
        await Hive.openBox<TargetModel>(_settingsBoxName);
      }
      if (!Hive.isBoxOpen(_activityBoxName)) {
        await Hive.openBox<ActivityModel>(_activityBoxName);
      }
    } catch (e) {
      print('openUserBoxes error: $e');
    }
  }

  static Future<void> closeUserBoxes() async {
    try {
      if (Hive.isBoxOpen(_clientsBoxName)) {
        await Hive.box<ClinetModel>(_clientsBoxName).close();
      }
      if (Hive.isBoxOpen(_settingsBoxName)) {
        await Hive.box<TargetModel>(_settingsBoxName).close();
      }
      if (Hive.isBoxOpen(_activityBoxName)) {
        await Hive.box<ActivityModel>(_activityBoxName).close();
      }
    } catch (e) {
      print('closeUserBoxes error: $e');
    }
  }

  static Box<ClinetModel> get clients => Hive.box<ClinetModel>(_clientsBoxName);

  static Box<TargetModel> get settingsbox =>
      Hive.box<TargetModel>(_settingsBoxName);

  static Box<ActivityModel> get activitybox =>
      Hive.box<ActivityModel>(_activityBoxName);

  static Box get user => Hive.box(userBoxName);

  static void saveUsername(String name) => user.put('username', name);
  static String getUsername() => user.get('username') ?? 'User';
  static void clearUser() => user.delete('username');
}
