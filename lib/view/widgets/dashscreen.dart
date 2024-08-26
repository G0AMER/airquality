import 'package:flutter/material.dart';
//import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:smart_srrigation/controller/homecontroller.dart';
import 'package:smart_srrigation/view/homescreen.dart';
import 'package:smart_srrigation/view/widgets/chartscreen.dart';
import 'package:smart_srrigation/view/widgets/drawer.dart';
import 'package:smart_srrigation/view/widgets/tablescreen.dart';

class DashScreen extends StatelessWidget {
  const DashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homecontroller = Get.put(HomeController());
    homecontroller.fetchSystemData();
    final drawerController = ZoomDrawerController();

    return Scaffold(
      body: ZoomDrawer(
        controller: drawerController,
        menuScreen: const DrawerScreen(),
        mainScreen: HomeScreen(
          zoomcontroller: drawerController,
        ),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        slideWidth: MediaQuery.of(context).size.width * 0.45,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      chartscreen(fetchedData: homecontroller.systemData),
                ),
              );
            },
            child: const Icon(Icons.insert_chart),
          ),
          const SizedBox(height: 16),
          // Adjust the spacing between the buttons
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TableScreen(fetchedData: homecontroller.systemData),
                ),
              );
            },
            child: const Icon(Icons.table_chart),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
