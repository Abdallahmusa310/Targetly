import 'package:bloc/bloc.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/data/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void loadUser() {
    final user = HiveManager.getUser();
    emit(UserLoaded(user));
  }

  void saveUser({required String username, required String jobTitle}) {
    HiveManager.saveUser(username: username, jobTitle: jobTitle);
    loadUser();
  }
}
