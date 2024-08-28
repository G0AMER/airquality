// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:smart_srrigation/controller/homecontroller.dart';
import 'package:smart_srrigation/view/Overview/Screen/Overview_screen.dart';
import 'package:smart_srrigation/view/widgets/lowertabBar.dart';

//ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  ZoomDrawerController zoomcontroller;
  @override
  HomeScreen({
    super.key,
    required this.zoomcontroller,
  });

  // void initState() {

  //   // TODO: implement initState
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: [SystemUiOverlay.bottom]);
  //   super.initState();
  // }

  final homecontroller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: LowerTabBar(
            zoomcontroller: zoomcontroller,
          )),
      //backgroundColor:   Color.fromARGB(255, 242, 255, 242),,
      body: const DefaultTabController(
        length: 4,
        child: Column(
          children: [
            SizedBox(
              height: 42,
            ),
            Expanded(
              flex: 2,
              child: TabBarView(
                children: [
                  // TabComponent(data: data_UG),
                  // TabComponent(data: data_PG),
                  // TabComponent(data: data_PHD)
                  OverviewScreen(),

                  /*const Wheat(),
                  const Valves()*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
