import 'package:shared_preferences/shared_preferences.dart';

import '../domain/i_theme_mode_repository.dart';

class ThemeModeRepositoryImpl implements IThemeModeRepository {
  final String _isDarkModeKey = 'isDarkMode';

  @override
  Future<bool> isDarkMode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_isDarkModeKey) ?? false;
  }

  @override
  Future<void> saveThemeMode(bool isDarkMode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_isDarkModeKey, isDarkMode);
  }
}
