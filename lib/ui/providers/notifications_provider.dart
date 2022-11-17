import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_base/common/interfaces/notifications_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class NotificationsProvider {
  String? deviceToken;
  final INotificationsService _iNotificationsService =
      GetIt.I.get<INotificationsService>();

  NotificationsProvider() : super() {
    _iNotificationsService.requestApplePermissions();
    _iNotificationsService.init(
      onLocalAndroidNotificationOpen: (_) => _onOpenNotification(),
    );
    _iNotificationsService
        .onMessageOpen((messageData) => _onOpenNotification());
    _iNotificationsService
        .onTerminatedStateMessage((messageData) => _onOpenNotification());

    // Gets device token
    _iNotificationsService.getToken().then(_registerDevice);

    // Background actions (not needed yet)
    _iNotificationsService
        .onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _onOpenNotification() async {
    // Here redirect to notifications tab
    log('notification opened');
  }

  void cancelSubscriptions() {
    _iNotificationsService.clean();
  }

  Future<void> _registerDevice(String? deviceToken) async {
    if (deviceToken == null) return;
    this.deviceToken = deviceToken;
    log(deviceToken);
    // here register device token in backend
  }
}

Future<void> _firebaseMessagingBackgroundHandler(
  Map<String, dynamic> messageData,
) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

final notificationsProvider = AutoDisposeProvider((ref) {
  final notificationsProvider = NotificationsProvider();
  ref.onDispose(() {
    notificationsProvider.cancelSubscriptions();
  });
  return notificationsProvider;
});
