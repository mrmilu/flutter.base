import 'package:flutter/material.dart';

import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';

enum AppLanguageType {
  en,
  es,
  ca,
  eu,
  gl;

  String toTranslate(BuildContext context) {
    switch (this) {
      case AppLanguageType.en:
        return context.cl.translate('languages.en');
      case AppLanguageType.es:
        return context.cl.translate('languages.es');
      case AppLanguageType.ca:
        return context.cl.translate('languages.ca');
      case AppLanguageType.eu:
        return context.cl.translate('languages.eu');
      case AppLanguageType.gl:
        return context.cl.translate('languages.gl');
    }
  }
}
