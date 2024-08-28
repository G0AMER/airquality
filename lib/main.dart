import 'dart:async';

import 'package:emailjs/emailjs.dart' as EmailJS;
import 'package:emailjs/emailjs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import 'SplashScreen.dart';
import 'controller/authcontroller.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> initNotifications() async {
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await _initializeNotifications();
  await initNotifications();
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

void sendEmail(String customerName, String clientEmail, double co2value) async {
  try {
    await EmailJS.send(
      'service_nng7pc7',
      'template_nx82vyj',
      {
        'customer_name': customerName,
        'client_email': clientEmail,
        'co2value': co2value.toString(),
      },
      const Options(
        publicKey: '2Tgf8fa4cu8rnU_cC',
        privateKey: 'TAnRj-iSyjm_ECLSZxj9t',
      ),
    );
    print('SUCCESS!');
  } catch (error) {
    if (error is EmailJSResponseStatus) {
      print('ERROR... ${error.status}: ${error.text}');
    }
    print(error.toString());
  }
}
