import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:lottie/lottie.dart';
import 'package:smart_srrigation/constants.dart';
import 'package:smart_srrigation/view/auth/login_screen.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(children: [
        Center(
          child: Lottie.asset('assets/overview1.json'),
        ),
      ]),
      nextScreen: const LoginScreen(),
      splashIconSize: 300,
      duration: 2000,
      backgroundColor: color2,
    );
  }
}
