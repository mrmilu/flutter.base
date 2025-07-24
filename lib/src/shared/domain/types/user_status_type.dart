import 'package:flutter/material.dart';

import '../../../shared/helpers/extensions.dart';

enum UserStatusType {
  client,
  noClient,
  pending,
  suspended;

  const UserStatusType();

  R map<R>({
    required R Function() client,
    required R Function() noClient,
    required R Function() pending,
    required R Function() suspended,
  }) {
    switch (this) {
      case UserStatusType.client:
        return client();
      case UserStatusType.noClient:
        return noClient();
      case UserStatusType.pending:
        return pending();
      case UserStatusType.suspended:
        return suspended();
    }
  }

  @override
  String toString() {
    switch (this) {
      case UserStatusType.client:
        return 'CLIENT';
      case UserStatusType.noClient:
        return 'NO_CLIENT';
      case UserStatusType.pending:
        return 'PENDING';
      case UserStatusType.suspended:
        return 'SUSPENDED';
    }
  }

  static UserStatusType fromString(String status) {
    switch (status) {
      case 'CLIENT':
        return UserStatusType.client;
      case 'NO_CLIENT':
        return UserStatusType.noClient;
      case 'PENDING':
        return UserStatusType.pending;
      case 'SUSPENDED':
        return UserStatusType.suspended;
      default:
        return UserStatusType.noClient;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case UserStatusType.client:
        return context.cl.translate('enums.UserStatusType.client');
      case UserStatusType.noClient:
        return context.cl.translate('enums.UserStatusType.noClient');
      case UserStatusType.pending:
        return context.cl.translate('enums.UserStatusType.pending');
      case UserStatusType.suspended:
        return context.cl.translate('enums.UserStatusType.suspended');
    }
  }
}
