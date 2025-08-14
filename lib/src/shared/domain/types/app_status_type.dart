import 'package:flutter/material.dart';

import '../../presentation/extensions/buildcontext_extensions.dart';

enum AppStatusType {
  open,
  close,
  maintenance;

  const AppStatusType();

  R map<R>({
    required R Function() open,
    required R Function() close,
    required R Function() maintenance,
  }) {
    switch (this) {
      case AppStatusType.open:
        return open();
      case AppStatusType.close:
        return close();
      case AppStatusType.maintenance:
        return maintenance();
    }
  }

  static AppStatusType fromString(String status) {
    switch (status) {
      case 'OPEN':
        return AppStatusType.open;
      case 'CLOSE':
        return AppStatusType.close;
      case 'MAINTENANCE':
        return AppStatusType.maintenance;
      default:
        return AppStatusType.open;
    }
  }

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
