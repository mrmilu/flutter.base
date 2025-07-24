import '../../../shared/helpers/result_or.dart';
import '../failures/change_language_failure.dart';

abstract class IChangeLanguageRepository {
  Future<ResultOr<ChangeLanguageFailure>> changeLanguage(String languageCode);
}
