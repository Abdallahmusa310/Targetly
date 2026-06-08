import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:targetly/data/models/activity_model.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/data/models/target_model.dart';
import 'package:targetly/data/models/user_model.dart';

class HiveManager {
  static const String appSettingsBoxName = 'app_settings';
  static String get userBoxName => 'user_box_$_userId';

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
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox(appSettingsBoxName);
  }

  static Future<void> openUserBoxes() async {
    try {
      if (!Hive.isBoxOpen(userBoxName)) {
        await Hive.openBox<UserModel>(userBoxName); // ← أضفها
      }
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
      if (Hive.isBoxOpen(userBoxName)) {
        await Hive.box<UserModel>(userBoxName).close(); // ← أضفها
      }
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

  static Box<UserModel> get userBox => Hive.box<UserModel>(userBoxName);
  static Box get appSettingsBox => Hive.box(appSettingsBoxName);

  static Box<ClinetModel> get clients => Hive.box<ClinetModel>(_clientsBoxName);
  static Box<TargetModel> get settingsbox =>
      Hive.box<TargetModel>(_settingsBoxName);
  static Box<ActivityModel> get activitybox =>
      Hive.box<ActivityModel>(_activityBoxName);

  // App Settings methods
  static bool isFirstTime() =>
      appSettingsBox.get('is_first_time', defaultValue: true);

  static void setNotFirstTime() => appSettingsBox.put('is_first_time', false);

  // User methods
  static void saveUser({required String username, required String jobTitle}) {
    if (userBox.isEmpty) {
      userBox.add(UserModel(username: username, jobTitle: jobTitle));
    } else {
      final user = userBox.getAt(0)!;
      user.username = username;
      user.jobTitle = jobTitle;
      user.save();
    }
  }

  static UserModel? getUser() => userBox.isNotEmpty ? userBox.getAt(0) : null;
  static String getUsername() => getUser()?.username ?? 'User';
  static String getJobTitle() => getUser()?.jobTitle ?? 'Sales Manager';

  static void clearUser() {
    try {
      if (Hive.isBoxOpen(userBoxName) && userBox.isNotEmpty) {
        userBox.clear();
      }
    } catch (e) {
      print('clearUser error: $e');
    }
  }

  static void saveTheme(bool isDark) {
    if (userBox.isNotEmpty) {
      final user = userBox.getAt(0)!;
      user.isDark = isDark;
      user.save();
    }
  }

  static bool getTheme() => getUser()?.isDark ?? false;
}
