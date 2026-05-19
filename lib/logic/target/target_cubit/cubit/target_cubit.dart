import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/data/models/activity_model.dart';
import 'package:targetly/data/models/target_model.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';

part 'target_state.dart';

class TargetCubit extends Cubit<TargetState> {
  TargetCubit() : super(TargetInitial());

  TargetModel? targetModel;

  Future<void> fetchTarget() async {
    try {
      emit(TargetLoading());

      if (HiveManager.settingsbox.isNotEmpty) {
        targetModel = HiveManager.settingsbox.getAt(0);
      }

      emit(TargetSuccess(targetModel));
    } catch (e) {
      emit(TargetFailure(e.toString()));
    }
  }

  Future<void> setTarget({
    required double target,
    required double commission,
    required DateTime startDate,
    required DateTime endDate,
    required ActivityCubit activityCubit,
  }) async {
    try {
      emit(TargetLoading());
      if (HiveManager.settingsbox.isEmpty) {
        final newTarget = TargetModel(
          target: target,
          commission: commission,
          startDate: startDate,
          endDate: endDate.add(const Duration(days: 1)),
        );
        await activityCubit.fetchActivities();
        await HiveManager.settingsbox.add(newTarget);
        targetModel = newTarget;
      } else {
        final existing = HiveManager.settingsbox.getAt(0);

        existing!.target = target;
        existing.commission = commission;
        existing.startDate = startDate;
        existing.endDate = endDate.add(const Duration(days: 1));

        await existing.save();

        targetModel = existing;
        await HiveManager.activitybox.add(
          ActivityModel(
            text: "target_updated:$target", // ← حفظ key مع القيمة
            date: DateTime.now(),
          ),
        );
        fetchTarget();
        await activityCubit.fetchActivities();
      }

      emit(TargetSuccess(targetModel));
    } catch (e) {
      emit(TargetFailure(e.toString()));
    }
  }

  Future<void> clearTarget() async {
    try {
      emit(TargetLoading());

      await HiveManager.settingsbox.clear();
      targetModel = null;

      emit(TargetSuccess(null));
    } catch (e) {
      emit(TargetFailure(e.toString()));
    }
  }
}
