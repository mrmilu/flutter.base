enum NotificationPermissionStatus {
  authorized,
  denied,
  notDetermined,
  provisional,
}

class CustomNotification {
  final Map<String, dynamic> data;
  final String title;
  final String body;

  CustomNotification({
    this.data = const {},
    this.body = '',
    this.title = '',
  });
}
