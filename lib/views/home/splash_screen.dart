import 'package:bhatt_brahman_var_vadhu/services/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/text_style.dart';
import '../../services/notification_service.dart';
import 'home_page.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
    FcmService.firebaseInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      if (isLoggedIn) {
        Get.off(() => const HomePage());
      } else {
        Get.off(() => const WelcomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.01,
          ),
          child: Column(
            children: [
              const Spacer(flex: 1),
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: screenSize.width * 0.8,
                    maxHeight: screenSize.height * 0.4,
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      "assets/brahmanlogo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.005,
                ),
                child: Text(
                  "Created By Mobisoftseo Technologies",
                  style: customTextStyle(
                    fontSize: isSmallScreen ? 12 : 14,
                    color: const Color(0xFF666666),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
