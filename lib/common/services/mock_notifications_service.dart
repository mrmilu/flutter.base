import 'dart:async';

import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_base/common/interfaces/notifications_service.dart';
import 'package:flutter_base/common/models/notifications_service.dart';
import 'package:flutter_base/core/app/domain/models/environments_list.dart';
import 'package:injectable/injectable.dart';

FutureOr disposeNotificationsService(INotificationsService instance) {
  instance.dispose();
}

@LazySingleton(
  as: INotificationsService,
  dispose: disposeNotificationsService,
  env: localEnvironment,
)
class MockNotificationsService implements INotificationsService {
  final _faker = Faker.instance;
  late bool _initialized;
  late final StreamController<CustomNotification> _streamController;

  MockNotificationsService() {
    _streamController = StreamController<CustomNotification>.broadcast();
    _initialized = false;
  }

  @override
  Stream<CustomNotification> get notificationStream => _streamController.stream;

  @override
  bool get isInitialized => _initialized;

  @override
  Future<void> init({
    AndroidForegroundNotificationOpenCallback
        onForegroundAndroidNotificationOpen,
    BackgroundMessageCallback onBackgroundMessage,
    bool foregroundNotification = false,
  }) async {
    _initialized = true;
  }

  @override
  Future<NotificationPermissionStatus> requestNotificationPermissions() async {
    return NotificationPermissionStatus.authorized;
  }

  @override
  Future<String?> getToken() async {
    return _faker.datatype.uuid();
  }

  @override
  Future<NotificationPermissionStatus>
      getCurrentNotificationPermissions() async {
    return NotificationPermissionStatus.authorized;
  }

  @override
  bool hasPermissionsEnabled(NotificationPermissionStatus status) {
    return [
      NotificationPermissionStatus.authorized,
      NotificationPermissionStatus.provisional,
    ].contains(status);
  }

  @override
  void dispose() {
    _streamController.close();
    _initialized = false;
  }
}
