import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_notifications_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class NotificationsNotifier extends AutoDisposeNotifier<void> {
  late final INotificationsService _notificationsService =
      GetIt.I.get<INotificationsService>();
  Timer? _notificationsDialogTimer;

  @override
  void build() {
    _init();

    ref.onDispose(() {
      debugPrintStack(label: 'disposed notifications provider');
      _notificationsDialogTimer?.cancel();
      GetIt.I.resetLazySingleton<INotificationsService>();
    });

    return;
  }

  Future<void> initPushNotifications() async {
    if (_notificationsService.isInitialized) return;

    final status = await _notificationsService.requestNotificationPermissions();
    if (_notificationsService.hasPermissionsEnabled(status)) {
      await _notificationsService.init(
        onBackgroundMessage: NotificationsNotifier._backgroundMessageHandler,
      );
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _backgroundMessageHandler(
    RemoteMessage notificationResponse,
  ) async {
    debugPrintStack(
      label:
          'notification opened on background: ${notificationResponse.toString()}',
    );
  }

  Future _init() async {
    final currentNotificationPermission =
        await _notificationsService.getCurrentNotificationPermissions();
    if (_notificationsService
        .hasPermissionsEnabled(currentNotificationPermission)) {
      initPushNotifications();
    }
    debugPrintStack(label: 'Notifications enabled');
  }
}

final notificationsProvider =
    AutoDisposeNotifierProvider<NotificationsNotifier, void>(
  NotificationsNotifier.new,
);
