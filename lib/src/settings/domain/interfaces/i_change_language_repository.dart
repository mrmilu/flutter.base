import 'package:flutter_jungle_core/flutter_jungle_core.dart';

import '../failures/change_language_failure.dart';

abstract class IChangeLanguageRepository {
  Future<ResultOr<ChangeLanguageFailure>> changeLanguage(String languageCode);
}
