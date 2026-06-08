part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final UserModel? user;
  UserLoaded(this.user);
}
