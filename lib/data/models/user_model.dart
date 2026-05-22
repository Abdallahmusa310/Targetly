import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3)
class UserModel extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String jobTitle;
  @HiveField(2)
  bool isDark;

  UserModel({
    required this.username,
    required this.jobTitle,
    this.isDark = false,
  });
}
