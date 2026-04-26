import 'package:hive_flutter/hive_flutter.dart';
part 'activity_model.g.dart';

@HiveType(typeId: 2)
class ActivityModel extends HiveObject {
  @HiveField(0)
  String text;
  @HiveField(1)
  DateTime? date;

  ActivityModel({required this.text, required this.date});
}
