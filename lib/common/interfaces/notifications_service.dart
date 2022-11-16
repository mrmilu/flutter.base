import 'package:firebase_messaging/firebase_messaging.dart';

abstract class INotificationsService {
  Future<void> init({
    required void Function(String? payload) onLocalAndroidNotificationOpen,
  });

  void clean();

  Future<NotificationSettings> requestApplePermissions();

  void onMessageOpen(void Function(Map<String, dynamic> messageData) handler);

  void onBackgroundMessage(
    Future<void> Function(Map<String, dynamic> messageData) handler,
  );

  void onTerminatedStateMessage(
    Future<void> Function(Map<String, dynamic> messageData) handler,
  );

  Future<String?> getToken();
}
