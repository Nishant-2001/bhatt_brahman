import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'views/home/splash_screen.dart';
import 'services/notification_service.dart'; // Add this import

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final notificationService = NotificationService(); // Add this line

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

  // Add Notification Service initialization
  await notificationService.requestNotificationPermission();
  
  

   await SystemChrome.setEnabledSystemUIMode(

    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );




   await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  const platform = MethodChannel('app_channel');
  try {
    await platform.invokeMethod('setSecureScreen');
  } catch (e) {
    print('Secure screen setting error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize notifications after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationService.initLocalNotification(context, RemoteMessage());
      notificationService.firebaseInit(context);
      notificationService.setupInteractMessage(context);
    });

    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Bhatt Brahman Var Vadhu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}