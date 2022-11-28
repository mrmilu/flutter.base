abstract class INotificationsService {
  Future<void> init({
    required void Function(String? payload) onLocalAndroidNotificationOpen,
  });

  void clean();

  Future<bool> requestApplePermissions();

  void onMessageOpen(void Function(Map<String, dynamic> messageData) handler);

  void onBackgroundMessage(
    Future<void> Function(Map<String, dynamic> messageData) handler,
  );

  void onTerminatedStateMessage(
    Future<void> Function(Map<String, dynamic> messageData) handler,
  );

  Future<String?> getToken();
}
