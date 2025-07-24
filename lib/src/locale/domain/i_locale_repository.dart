abstract class ILocaleRepository {
  Future<void> changeLanguageCode(String languageCode);
  Future<String?> findLanguageCode();
}
