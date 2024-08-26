import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
//import 'package:agri_app/view/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:smart_srrigation/SplashScreen.dart';
import 'package:smart_srrigation/controller/authcontroller.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true);

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('A bg message just showed up :  ${message.messageId}');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await _initializeNotifications();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDlCUHmfaG1rJUYSQh6hg5fzlCB7pY_c6w",
            authDomain: "myproject-334f7.firebaseapp.com",
            databaseURL: "https://myproject-334f7-default-rtdb.firebaseio.com",
            projectId: "myproject-334f7",
            storageBucket: "myproject-334f7.appspot.com",
            messagingSenderId: "772702756793",
            appId: "1:772702756793:web:9b5e94307feb0a9f3f2068",
            measurementId: "G-BQG56PECEF"));
  } else {
    await Firebase.initializeApp();
  }

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  Get.put(AuthController()); // Initialisation du contrôleur AuthController
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AirQuality',
        theme: ThemeData(
          //useMaterial3: true,
          scaffoldBackgroundColor: const Color.fromARGB(255, 250, 254, 250),
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          )),
        ),
        home: const Splashscreen(),
      ),
    );
  }
}
