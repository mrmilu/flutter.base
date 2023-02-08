import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/common/interfaces/notifications_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class NotificationsProvider extends AutoDisposeNotifier<void> {
  INotificationsService? _notificationsService;
  Timer? _notificationsDialogTimer;

  @override
  void build() {
    _notificationsService = GetIt.I.get<INotificationsService>();
    _init();

    ref.onDispose(() {
      debugPrint('disposed notifications provider');
      _notificationsDialogTimer?.cancel();
      GetIt.I.resetLazySingleton<INotificationsService>();
    });

    return;
  }

  Future _init() async {
    final currentNotificationPermission =
        await _notificationsService!.getCurrentNotificationPermissions();
    if (_notificationsService!
        .hasPermissionsEnabled(currentNotificationPermission)) {
      initPushNotifications();
    }
    debugPrint('$runtimeType - Notifications enabled');
  }

  Future<void> initPushNotifications() async {
    if (_notificationsService!.isInitialized) return;

    final status =
        await _notificationsService!.requestNotificationPermissions();
    if (_notificationsService!.hasPermissionsEnabled(status)) {
      await _notificationsService!.init(
        onBackgroundMessage: NotificationsProvider._backgroundMessageHandler,
      );
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _backgroundMessageHandler(
    RemoteMessage notificationResponse,
  ) async {
    debugPrint('notification opened on background');
  }
}

final notificationsProvider =
    AutoDisposeNotifierProvider<NotificationsProvider, void>(
  NotificationsProvider.new,
);
