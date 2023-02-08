import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mrmilu/src/models/notifications_service.dart';

typedef AndroidForegroundNotificationOpenCallback = void Function(
    NotificationResponse notificationResponse)?;

typedef BackgroundMessageCallback = Future<void> Function(
    RemoteMessage message)?;

abstract class INotificationsService {
  bool get isInitialized;

  Stream<CustomNotification> get notificationStream;

  Future<void> init({
    AndroidForegroundNotificationOpenCallback
        onForegroundAndroidNotificationOpen,
    BackgroundMessageCallback onBackgroundMessage,
  });

  Future<NotificationPermissionStatus> requestNotificationPermissions();

  Future<NotificationPermissionStatus> getCurrentNotificationPermissions();

  Future<String?> getToken();

  bool hasPermissionsEnabled(NotificationPermissionStatus status);

  void dispose();
}
