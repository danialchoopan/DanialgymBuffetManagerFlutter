import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final Box _settingsBox;

  ThemeCubit()
      : _settingsBox = Hive.box('settings'),
        super(_getInitialThemeMode());

  static ThemeMode _getInitialThemeMode() {
    final box = Hive.box('settings');
    final themeIndex = box.get('themeMode', defaultValue: 0) as int;
    return ThemeMode.values[themeIndex];
  }

  void toggleTheme() {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode(newMode);
    emit(newMode);
  }

  void setThemeMode(ThemeMode mode) {
    _saveThemeMode(mode);
    emit(mode);
  }

  void _saveThemeMode(ThemeMode mode) {
    _settingsBox.put('themeMode', mode.index);
  }

  bool get isDarkMode => state == ThemeMode.dark;
  ThemeMode get currentThemeMode => state;
}