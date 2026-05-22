part of 'thems_cubit.dart';

abstract class ThemsState {}

class ThemsInitial extends ThemsState {
  final ThemeMode themeMode;
  ThemsInitial(this.themeMode);
}

class ThemsChanged extends ThemsState {
  final ThemeMode themeMode;
  ThemsChanged(this.themeMode);
}
