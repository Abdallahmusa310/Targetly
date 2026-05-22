import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:targetly/data/hive/hive_manager.dart';

part 'thems_state.dart';

class ThemsCubit extends Cubit<ThemsState> {
  ThemsCubit()
    : super(
        ThemsInitial(HiveManager.getTheme() ? ThemeMode.dark : ThemeMode.light),
      );

  ThemeMode get currentTheme {
    final s = state;
    if (s is ThemsInitial) return s.themeMode;
    if (s is ThemsChanged) return s.themeMode;
    return ThemeMode.light;
  }

  void toggleTheme() {
    final isDark = currentTheme == ThemeMode.dark;
    HiveManager.saveTheme(!isDark);
    emit(ThemsChanged(!isDark ? ThemeMode.dark : ThemeMode.light));
  }
}
