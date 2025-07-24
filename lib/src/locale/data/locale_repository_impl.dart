import 'package:shared_preferences/shared_preferences.dart';

import '../domain/i_locale_repository.dart';

class LocaleRepositoryImpl implements ILocaleRepository {
  final String _languageCodeKey = 'languageCode';

  @override
  Future<void> changeLanguageCode(String languageCode) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(_languageCodeKey, languageCode);
  }

  @override
  Future<String?> findLanguageCode() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (!sharedPreferences.containsKey(_languageCodeKey)) {
      return null;
    }

    return sharedPreferences.getString(_languageCodeKey);
  }
}
