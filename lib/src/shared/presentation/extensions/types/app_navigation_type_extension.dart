import 'package:flutter/cupertino.dart';

import '../../../domain/types/app_navigation_type.dart';
import '../buildcontext_extensions.dart';

extension AppNavigationTypeExtension on AppNavigationType {
  String toTranslate(BuildContext context) {
    switch (this) {
      case AppNavigationType.home:
        return context.cl.translate('navigation.home');
      case AppNavigationType.ente:
        return context.cl.translate('navigation.ente');
      case AppNavigationType.invoices:
        return context.cl.translate('navigation.invoices');
      case AppNavigationType.efforts:
        return context.cl.translate('navigation.efforts');
    }
  }
}
