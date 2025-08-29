abstract class IThemeModeRepository {
  Future<void> saveThemeMode(bool isDarkMode);
  Future<bool> isDarkMode();
}
