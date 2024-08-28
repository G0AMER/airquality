import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
//import '../model/currentask.dart' as model;
import 'package:logger/logger.dart';
import 'package:smart_srrigation/constants.dart';
import 'package:smart_srrigation/model/User.dart';

import '../main.dart';

class HomeController extends GetxController {
  final databaseRef =
      FirebaseDatabase.instance.ref(); // Firebase Database reference
  RxList<Map<String, dynamic>> latestdata = <Map<String, dynamic>>[].obs;

  //final Rx<List<model.CropTask>> _task = Rx<List<model.CropTask>>([]);
  //List<model.CropTask> get task => _task.value;
  // var username = "".obs;
  var name = "".obs;

  List<Map<String, dynamic>> latestData = [];
  List<Map<String, dynamic>> systemData = [];

  // String get Username => username.value;
  var logger = Logger();

  void _startListeningToDataChanges() {
    databaseRef.child('Senor').onValue.listen((event) {
      final data = event.snapshot.value as Map<String, dynamic>;
      latestdata.add(data);
      update(); // Notify listeners of the update
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // fetchusername();
    getusername();
    fetchSystemData();
    getemail();
    //storedata();
    // ever(waterneed, storedata());

    super.onInit();
    // print("krishna");
  }

  @override
  void onReady() {
    // TODO: implement onReady
    //fetchtaskdata();
    super.onReady();
  }

  getusername() async {
    var uid = firebaseAuth.currentUser!.uid;
    var c = await firestore.collection('users').doc(uid).get();
    User us = User.fromSnap(c);
    username.value = us.name;
    //   print('${username}+username');
  }

  getemail() async {
    var uid = firebaseAuth.currentUser!.uid;
    var c = await firestore.collection('users').doc(uid).get();
    User us = User.fromSnap(c);

    return us.email;
  }

/*  Future<void> _showNotification(double co2Level) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_co2_channel', // Channel ID
      'High CO2 Alerts', // Channel name
      channelDescription: 'Notification for high CO2 levels',
      // Channel description
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'High CO2 Level Alert',
      'Current CO2 Level: ${co2Level.toStringAsFixed(2)} ppm',
      platformChannelSpecifics,
      payload: 'High CO2 Alert',
    );
  }*/

  Future<void> fetchSystemData() async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    DatabaseReference readingsRef = databaseReference.child('Senor');

    try {
      readingsRef.onValue.listen((event) async {
        final readingsData = event.snapshot.value;
        List<Map<String, dynamic>> sensorDataList = [];

        if (readingsData != null && readingsData is Map) {
          readingsData.forEach((timestamp, readings) {
            if (timestamp != null) {
              // Convert timestamp string to DateTime
              int timestampValue =
                  int.tryParse(timestamp) ?? 0; // Default to 0 if parsing fails
              DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                  timestampValue * 1000); // Assuming timestamp is in seconds

              Map<String, dynamic> sensorData = {
                'timestamp': dateTime,
                'humidity': readings['hum'],
                'temperature': readings['temp'],
                'pressure': readings['pressure'],
                'CO2': readings['CO2'],
              };
              sensorDataList.add(sensorData);
            }
          });

          // Assuming `systemData` is initialized as a RxList<Map<String, dynamic>>
          systemData
              .assignAll(sensorDataList); // Update systemData with fetched data
          systemData.sort((a, b) {
            // Compare timestamps as strings
            return a['timestamp'].compareTo(b['timestamp']);
          });
          //logger.d("Fetched data: $systemData");

          if (systemData.isNotEmpty) {
            latestData = [systemData.last];
            logger.d("latest data: $latestData");
            if (latestData[0]["CO2"] > 1000) {
              print("DANGER!!!!");
              String email = await getemail();
              sendEmail(username.toString(), email, latestData[0]["CO2"]);
              showNotification(latestData[0]["CO2"]);
            }
          } else {
            latestData = [];
            logger.w("latestData is empty");
          }
        } else {
          logger.w("No data available under 'readings'");
        }
      });
    } catch (e) {
      logger.e("Error fetching sensor data: $e");
    }
  }

  Future<void> showNotification(double co2Level) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_co2_channel', // Channel ID
      'High CO2 Alerts', // Channel name
      channelDescription: 'Notification for high CO2 levels',
      // Channel description
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Create an instance of your notification.
    var notification = flutterLocalNotificationsPlugin.show(
      0,
      'High CO2 Level Alert',
      'Current CO2 Level: ${co2Level.toStringAsFixed(2)} ppm',
      platformChannelSpecifics,
      payload: 'High CO2 Alert',
    );

    // When the notification is tapped, open the file.
    flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails()
        .then((details) {});

    await notification;
  }

  Future<void> _showNotification(double co2Level) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_co2_channel', // Channel ID
      'High CO2 Alerts', // Channel name
      channelDescription: 'Notification for high CO2 levels',
      // Channel description
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'High CO2 Level Alert',
      'Current CO2 Level: ${co2Level.toStringAsFixed(2)} ppm',
      platformChannelSpecifics,
      payload: 'High CO2 Alert',
    );
  }

// fetchtaskdata() async {
//   List<model.CropTask> xx = [];
//   var uid = firebaseAuth.currentUser!.uid;
//   _task.bindStream(
//     firestore
//         .collection('croptask')
//         .doc(uid)
//         .collection('currentask')
//         .snapshots()
//         .map(
//       (var query) {
//         List<model.CropTask> retValue = [];
//         for (var element in query.docs) {
//           retValue.add(model.CropTask.fromSnap(element));
//         }
//         return retValue;
//       },
//     ),
//   );
// }
}
