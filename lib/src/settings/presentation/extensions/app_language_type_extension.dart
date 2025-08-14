import 'package:flutter/material.dart';

import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../domain/types/app_language_type.dart';

extension AppLanguageTypeExtension on AppLanguageType {
  String toTranslate(BuildContext context) {
    switch (this) {
      case AppLanguageType.en:
        return context.cl.translate('languages.en');
      case AppLanguageType.es:
        return context.cl.translate('languages.es');
    }
  }
}
