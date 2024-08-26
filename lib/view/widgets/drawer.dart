import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_srrigation/constants.dart';
import 'package:smart_srrigation/controller/homecontroller.dart';
import 'package:smart_srrigation/view/widgets/Aboutus.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var name = username;

    void initState() {}

    final homecontroller = Get.find<HomeController>();

    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // stops: [0.3, 0.9],
              colors: [
                Color.fromARGB(255, 227, 245, 252),
                Color.fromARGB(255, 191, 255, 193)
              ],
            )),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 300,
                  child: DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/profile.png',
                          height: 120,
                          width: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 9),
                          child: Row(
                            children: [
                              const Text(
                                "Hi,",
                                style: TextStyle(
                                    fontSize: 36, // color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              Lottie.asset('assets/hello.json', height: 35),
                            ],
                          ),
                        ),
                        Text(
                          "$username",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: const Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.lightBlueAccent,
                      ),
                      // Icon
                      SizedBox(width: 8),
                      // SizedBox for spacing
                      Text(
                        "Home",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      // Text
                    ],
                  ),
                  onTap: () {
                    // Navigate back to the previous screen
                    Get.back(); // Close the drawer
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.help),
                //   title: Transform.translate(
                //       offset: Offset(-27, 0),
                //       child: Text("Help",
                //           style: TextStyle(
                //               //color: Colors.white,
                //               ))),
                // ),
                // ListTile(
                //   leading: Icon(Icons.phone),
                //   title: Transform.translate(
                //       offset: Offset(-27, 0),
                //       child: Text("Contact",
                //           style: TextStyle(
                //               //color: Colors.white,
                //               ))),
                // ),
                // ListTile(
                //   leading: Icon(Icons.settings),
                //   title: Transform.translate(
                //       offset: Offset(-27, 0),
                //       child: Text("Settings",
                //           style: TextStyle(
                //               //color: Colors.white,
                //               ))),
                // ),

                ListTile(
                    onTap: (() {
                      Get.to(const AboutUs());
                    }),
                    title: const Row(
                      children: [
                        Icon(Icons.add_comment),
                        SizedBox(
                          width: 3,
                        ),
                        Text("About Us",
                            style: TextStyle(//color: Colors.white,
                                ))
                      ],
                    )),
                ListTile(
                    //tileColor: Colors.white,
                    // leading: Icon(Icons.exit_to_app),
                    //  title: Text("LogOut"),

                    title: const Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Color.fromARGB(255, 244, 52, 38),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "LogOut",
                          style: TextStyle(
                              color: Color.fromARGB(255, 244, 52, 38)),
                        )
                      ],
                    ),
                    onTap: () => authController.signOut()),
                const SizedBox(
                  height: 18.0,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
