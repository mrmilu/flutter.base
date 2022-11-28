import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_base/common/interfaces/notifications_service.dart';

class MockNotificationService extends INotificationsService {
  final _faker = Faker.instance;
  @override
  void clean() {}

  @override
  Future<String?> getToken() {
    return Future.value(_faker.datatype.uuid());
  }

  @override
  Future<void> init({
    required void Function(String? payload) onLocalAndroidNotificationOpen,
  }) async {}

  @override
  void onBackgroundMessage(
    Future<void> Function(Map<String, dynamic> messageData) handler,
  ) {}

  @override
  void onMessageOpen(void Function(Map<String, dynamic> messageData) handler) {}

  @override
  void onTerminatedStateMessage(
    Future<void> Function(Map<String, dynamic> messageData) handler,
  ) {}

  @override
  Future<bool> requestApplePermissions() {
    return Future.value(true);
  }
}
