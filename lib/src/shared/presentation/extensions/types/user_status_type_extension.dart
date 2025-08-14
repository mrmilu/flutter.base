import 'package:flutter/cupertino.dart';

import '../../../domain/types/user_status_type.dart';
import '../buildcontext_extensions.dart';

extension UserStatusTypeExtension on UserStatusType {
  String toTranslate(BuildContext context) {
    switch (this) {
      case UserStatusType.active:
        return context.cl.translate('enums.UserStatusType.active');
      case UserStatusType.inactive:
        return context.cl.translate('enums.UserStatusType.inactive');
      case UserStatusType.suspended:
        return context.cl.translate('enums.UserStatusType.suspended');
    }
  }
}
