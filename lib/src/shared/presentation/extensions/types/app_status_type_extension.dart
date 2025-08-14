import 'package:flutter/cupertino.dart';

import '../../../domain/types/app_status_type.dart';
import '../buildcontext_extensions.dart';

extension AppStatusTypeExtension on AppStatusType {
  String toTranslate(BuildContext context) {
    switch (this) {
      case AppStatusType.open:
        return context.cl.translate('enums.AppStatusType.open');
      case AppStatusType.close:
        return context.cl.translate('enums.AppStatusType.close');
      case AppStatusType.maintenance:
        return context.cl.translate('enums.AppStatusType.maintenance');
    }
  }
}
