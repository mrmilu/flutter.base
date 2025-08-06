import 'package:flutter/material.dart';

import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';

enum AppLanguageType {
  en,
  es;

  String toTranslate(BuildContext context) {
    switch (this) {
      case AppLanguageType.en:
        return context.cl.translate('languages.en');
      case AppLanguageType.es:
        return context.cl.translate('languages.es');
    }
  }
}
