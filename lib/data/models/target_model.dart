import 'package:hive/hive.dart';

part 'target_model.g.dart';

@HiveType(typeId: 0)
class ClinetModel extends HiveObject {
  @HiveField(0)
  final String target;
  @HiveField(1)
  final String comission;

  ClinetModel({required this.target, required this.comission});
}
