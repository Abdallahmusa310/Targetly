import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:targetly/data/hive/hive_manager.dart';

part 'thems_state.dart';

class ThemsCubit extends Cubit<ThemsState> {
  ThemsCubit() : super(ThemsInitial(ThemeMode.light)); // ← default light

  ThemeMode get currentTheme {
    final s = state;
    if (s is ThemsInitial) return s.themeMode;
    if (s is ThemsChanged) return s.themeMode;
    return ThemeMode.light;
  }

  void loadTheme() {
    try {
      final isDark = HiveManager.getTheme();
      emit(ThemsInitial(isDark ? ThemeMode.dark : ThemeMode.light));
    } catch (e) {
      emit(ThemsInitial(ThemeMode.light));
    }
  }

  void toggleTheme() {
    final isDark = currentTheme == ThemeMode.dark;
    try {
      HiveManager.saveTheme(!isDark);
    } catch (e) {
      print('saveTheme error: $e');
    }
    emit(ThemsChanged(!isDark ? ThemeMode.dark : ThemeMode.light));
  }
}
