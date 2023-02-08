import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mrmilu/src/interfaces/notifications_service.dart';
import 'package:flutter_mrmilu/src/models/notifications_service.dart';

class NotificationsService implements INotificationsService {
  late bool _initialized;
  late final StreamController<CustomNotification> _streamController;
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  StreamSubscription<RemoteMessage>? _onForegroundMessage;
  StreamSubscription<RemoteMessage>? _onBackgroundMessage;

  NotificationsService() {
    _streamController = StreamController<CustomNotification>.broadcast();
    _initialized = false;
  }

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_importance_channel", // id
    "High Importance Notifications", // title
    description: "This channel is used for important notifications.",
    importance: Importance.max,
  );

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
    if (_initialized) return;

    // Sets up apple foreground notification presentation options
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert:
          foregroundNotification, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    if (Platform.isAndroid && foregroundNotification) {
      await _initAndroidLocalNotifications(onForegroundAndroidNotificationOpen);
    }

    _onForegroundMessage =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // This shows notifications in foreground for Android
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null &&
          android != null &&
          onForegroundAndroidNotificationOpen != null) {
        _flutterLocalNotificationsPlugin?.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
              ),
            ));
      }
      final customNotification = _customNotificationFromRemoteMessage(message);
      log("Notification on foreground: ${customNotification.title} - ${customNotification.body}");
      _streamController.add(customNotification);
    });

    _onBackgroundMessage = FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) async {
      final customNotification = _customNotificationFromRemoteMessage(message);
      log("Notification on background: ${customNotification.title} - ${customNotification.body}");
      _streamController.add(customNotification);
    });

    if (onBackgroundMessage != null) {
      FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    }

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final customNotification =
            _customNotificationFromRemoteMessage(message);
        log("Initial notification: ${customNotification.title} - ${customNotification.body}");
        _streamController.add(customNotification);
      }
    });

    _initialized = true;
  }

  Future<void> _initAndroidLocalNotifications(
    AndroidForegroundNotificationOpenCallback
        onForegroundAndroidNotificationOpen,
  ) async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("ic_launcher_foreground");
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin!.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          onForegroundAndroidNotificationOpen,
    );
    _flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  @override
  Future<NotificationPermissionStatus> requestNotificationPermissions() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return NotificationPermissionStatus.values
        .byName(settings.authorizationStatus.name);
  }

  @override
  Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken();
  }

  CustomNotification _customNotificationFromRemoteMessage(
      RemoteMessage message) {
    return CustomNotification(
      data: message.data,
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
    );
  }

  @override
  Future<NotificationPermissionStatus>
      getCurrentNotificationPermissions() async {
    final currentSettings =
        await FirebaseMessaging.instance.getNotificationSettings();
    return NotificationPermissionStatus.values
        .byName(currentSettings.authorizationStatus.name);
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
    _onForegroundMessage?.cancel();
    _onBackgroundMessage?.cancel();
    _streamController.close();
    _initialized = false;
  }
}
