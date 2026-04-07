import 'package:hive_flutter/hive_flutter.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/data/models/target_model.dart';

class HiveManager {
  static const String settingsBox = 'settings_box';
  static const String clientsBox = 'clients_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ClinetModelAdapter());
    Hive.registerAdapter(TargetModelAdapter());

    await Hive.openBox<TargetModel>(settingsBox);
    await Hive.openBox<ClinetModel>(clientsBox); // مهم
  }

  static Box<ClinetModel> get clients => Hive.box<ClinetModel>(clientsBox);

  static Box<TargetModel> get settingsbox => Hive.box<TargetModel>(settingsBox);
}
