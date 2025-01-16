import 'dart:developer';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bhatt_brahman_var_vadhu/views/pages/notification_page.dart';
import '../main.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Request notification permissions
  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
      criticalAlert: true,
    );

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        log("User granted notification permissions.");
        break;
      case AuthorizationStatus.provisional:
        log("User granted provisional notification permissions.");
        break;
      case AuthorizationStatus.denied:
        log("User denied notification permissions.");
        Future.delayed(const Duration(seconds: 1), () {
          AppSettings.openAppSettings(type: AppSettingsType.notification);
        });
        break;
      default:
        log("Notification permission status: ${settings.authorizationStatus}");
    }
  }

  // Retrieve device token
  Future<String?> getDeviceToken() async {
    try {
      String? token = await _messaging.getToken();
      log("Device Token: $token");
      return token;
    } catch (e) {
      log("Error retrieving device token: $e");
      return null;
    }
  }

  // Initialize local notifications
  Future<void> initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    const androidSettings = AndroidInitializationSettings("ic_notification");
    const iosSettings = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        handleMessage(context, message);
      },
    );
  }

  // Firebase message listener
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;

      if (notification != null) {
        log("Notification received: ${notification.title}, ${notification.body}");

        // Initialize local notification
        initLocalNotification(context, message);

        // Show notification for both Android and iOS
        showNotification(message);
      }
    });
  }

  // Show notification
  Future<void> showNotification(RemoteMessage message) async {
    final androidDetails = AndroidNotificationDetails(
        message.notification?.android?.channelId ?? "default_channel",
        "Notifications",
        channelDescription: "Bhatt Brahman Var Vadhu Notifications",
        icon: 'ic_notification',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        colorized: true,
        color: const Color(0xffffffff));

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotificationsPlugin.show(
      0,
      message.notification?.title ?? "No Title",
      message.notification?.body ?? "No Body",
      notificationDetails,
    );
  }

  // Setup message interactions for background and terminated states
  Future<void> setupInteractMessage(BuildContext context) async {
    // Handle when app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });

    // Handle when app is in terminated state
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }
  }

  // Handle navigation on notification tap
  Future<void> handleMessage(
      BuildContext context, RemoteMessage message) async {
    // log("Navigating to Notification Page due to notification tap.");
    if (message.notification == null) {
      // log("Notification data is null. Skipping navigation.");
      return;
    }

    // log("Navigate to notification screen. Handling message: ${message.data}");
    navigatorKey.currentState?.push(
      MaterialPageRoute(
          builder: (context) => NotificationPage(message: message)),
    );
  }

  // iOS foreground message handling
  Future<void> iosForegroundMessage() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
