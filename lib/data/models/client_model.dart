import 'package:hive/hive.dart';

part 'client_model.g.dart';

@HiveType(typeId: 0)
class ClinetModel extends HiveObject {
  @HiveField(0)
  final String clinetname;
  @HiveField(1)
  final String clinetphone;
  @HiveField(2)
  final String clinetid;
  @HiveField(3)
  final String clinetfees;

  ClinetModel({
    required this.clinetname,
    required this.clinetphone,
    required this.clinetid,
    required this.clinetfees,
  });
}
