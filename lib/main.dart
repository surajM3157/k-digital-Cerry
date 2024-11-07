import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:piwotapp/route/route_names.dart';
import 'package:piwotapp/route/route_pages.dart';
import 'package:piwotapp/services/notification_service.dart';
import 'constants/firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Load the .env file
  try {
    await dotenv.load(fileName: '.env');
    print("Successfully loaded .env file.");
  } catch (e) {
    print("Error loading .env file: $e");
    return; // Stop execution if .env loading fails
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Locks the app to portrait mode
    // DeviceOrientation.landscapeLeft, // Uncomment this line to lock to landscape mode
    // DeviceOrientation.landscapeRight,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService fcmService = NotificationService();
  fcmService.setupBackgroundHandler();
  await fcmService.initialize();
  fcmService.setupForegroundMessageHandler();
  configLoading();
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: getPages,
        builder : EasyLoading.init()
    );
  }
}

