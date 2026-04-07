import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/data/models/target_model.dart';

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

  /// ➕ / ✏️ add or update
  Future<void> setTarget({
    required double target,
    required double commission,
  }) async {
    try {
      emit(TargetLoading());

      if (HiveManager.settingsbox.isEmpty) {
        /// أول مرة
        final newTarget = TargetModel(target: target, commission: commission);

        await HiveManager.settingsbox.add(newTarget);
        targetModel = newTarget;
      } else {
        /// تعديل
        final existing = HiveManager.settingsbox.getAt(0);

        existing!.target = target;
        existing.commission = commission;

        await existing.save();

        targetModel = existing;
      }

      emit(TargetSuccess(targetModel));
    } catch (e) {
      emit(TargetFailure(e.toString()));
    }
  }

  /// 🗑️ reset target (اختياري)
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
