import 'package:hive/hive.dart';

part 'target_model.g.dart';

@HiveType(typeId: 1)
class TargetModel extends HiveObject {
  @HiveField(0)
  double target;
  @HiveField(1)
  double commission;

  TargetModel({required this.target, required this.commission});
}
