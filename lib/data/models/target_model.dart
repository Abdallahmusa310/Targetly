import 'package:hive/hive.dart';

part 'target_model.g.dart';

@HiveType(typeId: 1)
class TargetModel extends HiveObject {
  @HiveField(0)
  double target;
  @HiveField(1)
  double commission;
  @HiveField(2)
  DateTime startDate;
  @HiveField(3)
  DateTime endDate;

  TargetModel({
    required this.target,
    required this.commission,
    required this.startDate,
    required this.endDate,
  });
}
