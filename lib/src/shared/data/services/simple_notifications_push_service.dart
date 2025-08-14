import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../presentation/extensions/iterable_extension.dart';

enum NotificationType {
  none,
}

String notificationType = '';
String notificationId = '';
String userNotificationId = '';

@pragma('vm:entry-point')
class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messagesStreamController =
      StreamController.broadcast();
  static Stream<String> get messagesStream => _messagesStreamController.stream;

  @pragma('vm:entry-point')
  static Future _backgroundHandler(RemoteMessage message) async {
    debugPrint('app cerrada viva, ${message.data}');
    notificationType = message.data['type'] as String? ?? '';
    notificationId = message.data['id'] as String? ?? '';
    userNotificationId = message.data['user_notification_id'] as String? ?? '';
  }

  @pragma('vm:entry-point')
  static Future _onMessageHandler(RemoteMessage message) async {
    debugPrint('app abierta, ${message.data}');
    final String type = message.data['type'] as String? ?? '';
    final String id = message.data['id'] as String? ?? '';
    final String notificId =
        message.data['user_notification_id'] as String? ?? '';

    if (Platform.isAndroid && message.notification?.title != null) {
      final String title = message.notification?.title ?? '';
      final String body = message.notification?.body ?? '';
      await showNotification(
        title: title,
        body: body,
        payload: jsonEncode({
          'id': id,
          'type': type,
          'user_notification_id': notificId,
        }),
      );
    }
  }

  @pragma('vm:entry-point')
  static Future _onMessageOpenApp(RemoteMessage message) async {
    debugPrint('onMessageOpenApp, ${message.data}');
    notificationType = message.data['type'] as String? ?? '';
    notificationId = message.data['id'] as String? ?? '';
    userNotificationId = message.data['user_notification_id'] as String? ?? '';
  }

  static Future initialize() async {
    try {
      await messaging.requestPermission();
      //Push notifications
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      //Handlers
      FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
      FirebaseMessaging.onMessage.listen(_onMessageHandler);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

      //Local notifications
      if (Platform.isAndroid) {
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('ic_notification');

        const InitializationSettings initializationSettings =
            InitializationSettings(
              android: initializationSettingsAndroid,
            );

        FlutterLocalNotificationsPlugin().initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: onSelectNotification,
          onDidReceiveBackgroundNotificationResponse: onSelectNotification,
        );
      }

      //Get token
      token = await messaging.getToken();
      debugPrint('Firebase Messaging Token: $token');
    } catch (e) {
      debugPrint('Error initializing PushNotificationService: $e');
    }
  }

  static Future<void> onSelectNotification(
    NotificationResponse notificationResponse,
  ) async {
    try {
      final payloadMap =
          jsonDecode(notificationResponse.payload ?? '{}')
              as Map<String, dynamic>;

      final id = int.tryParse(payloadMap['id'] ?? '') ?? -1;
      final type = payloadMap['type'] ?? '';

      redirectForNotificationPush(type: type, id: id);
      return;
    } catch (e) {
      debugPrint('Error onSelectNotification, $e');
    }
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await FlutterLocalNotificationsPlugin().show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.max,
          icon: '@drawable/ic_notification',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  static void closeStreams() {
    _messagesStreamController.close();
  }

  Future<void> addSubscriptionTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
  }

  Future<void> removeSubscriptionTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
  }
}

void redirectForNotificationPush({
  required String type,
  required int id,
}) {
  final typeEnum = NotificationType.values.firstWhereOrNull(
    (element) => element.toString().contains(type),
  );
  if (typeEnum == null) return;
}
