import 'package:targetly/data/models/activity_model.dart';

abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivitySuccess extends ActivityState {
  final List<ActivityModel> activities;
  ActivitySuccess(this.activities);
}

class ActivityFailure extends ActivityState {
  final String message;
  ActivityFailure(this.message);
}
