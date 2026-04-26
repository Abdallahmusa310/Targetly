// activity_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/data/models/activity_model.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitial());

  List<ActivityModel> activities = [];

  Future<void> fetchActivities() async {
    try {
      emit(ActivityLoading());
      final all = HiveManager.activitybox.values.toList();
      activities = all.reversed.take(5).toList();
      emit(ActivitySuccess(activities));
    } catch (e) {
      emit(ActivityFailure(e.toString()));
    }
  }

  Future<void> clearActivities() async {
    try {
      await HiveManager.activitybox.clear();
      activities = [];
      emit(ActivitySuccess(activities));
    } catch (e) {
      emit(ActivityFailure(e.toString()));
    }
  }
}
