import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'views/home/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return GetMaterialApp(
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
