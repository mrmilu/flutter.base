import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_base/common/interfaces/notifications_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ignore: unused_import
import 'package:injectable/injectable.dart';

// @Singleton(as: INotificationsService)
class NotificationsService implements INotificationsService {
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_importance_channel", // id
    "High Importance Notifications", // title
    description: "This channel is used for important notifications.",
    importance: Importance.max,
  );

  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  StreamSubscription<RemoteMessage>? _onMessageSubscription;
  StreamSubscription<RemoteMessage>? _onMessageOpenedAppSubscription;

  @override
  Future<void> init(
      {required void Function(String? payload)
          onLocalAndroidNotificationOpen}) async {
    // Sets up apple foreground notification presentation options
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    if (Platform.isAndroid) {
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings("ic_launcher_foreground");
      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      await _flutterLocalNotificationsPlugin!.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            (NotificationResponse details) =>
                onLocalAndroidNotificationOpen(details.payload),
      );

      await _flutterLocalNotificationsPlugin!
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    // This shows notifications in foreground for Android
    _onMessageSubscription =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
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
    });
  }

  @override
  void clean() {
    _onMessageSubscription?.cancel();
    _onMessageOpenedAppSubscription?.cancel();
  }

  @override
  Future<NotificationSettings> requestApplePermissions() {
    return FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  void onMessageOpen(void Function(Map<String, dynamic> messageData) handler) {
    _onMessageOpenedAppSubscription = FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) async {
      handler(message.data);
    });
  }

  @override
  void onBackgroundMessage(
      Future<void> Function(Map<String, dynamic> messageData) handler) {
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
      return handler(message.data);
    });
  }

  @override
  Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken();
  }

  @override
  void onTerminatedStateMessage(
      Future<void> Function(Map<String, dynamic> messageData) handler) async {
    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) handler(notification.data);
  }
}
