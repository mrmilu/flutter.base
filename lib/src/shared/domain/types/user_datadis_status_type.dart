import 'package:flutter/material.dart';

import '../../presentation/utils/extensions/buildcontext_extensions.dart';

enum UserDatadisStatusType {
  authorized,
  connected,
  notConnected;

  const UserDatadisStatusType();

  R map<R>({
    required R Function() authorized,
    required R Function() connected,
    required R Function() notConnected,
  }) {
    switch (this) {
      case UserDatadisStatusType.authorized:
        return authorized();
      case UserDatadisStatusType.connected:
        return connected();
      case UserDatadisStatusType.notConnected:
        return notConnected();
    }
  }

  @override
  String toString() {
    switch (this) {
      case UserDatadisStatusType.authorized:
        return 'AUTHORIZED';
      case UserDatadisStatusType.connected:
        return 'CONNECTED';
      case UserDatadisStatusType.notConnected:
        return 'NOT_CONNECTED';
    }
  }

  static UserDatadisStatusType fromString(String status) {
    switch (status) {
      case 'AUTHORIZED':
        return UserDatadisStatusType.authorized;
      case 'CONNECTED':
        return UserDatadisStatusType.connected;
      case 'NOT_CONNECTED':
        return UserDatadisStatusType.notConnected;
      default:
        return UserDatadisStatusType.notConnected;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case UserDatadisStatusType.authorized:
        return context.cl.translate('enums.UserDatadisStatusType.authorized');
      case UserDatadisStatusType.connected:
        return context.cl.translate('enums.UserDatadisStatusType.connected');
      case UserDatadisStatusType.notConnected:
        return context.cl.translate('enums.UserDatadisStatusType.notConnected');
    }
  }
}
