import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:thunder/thunder/thunder.dart';

PageController thunderPageController = PageController(initialPage: 0);

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: SizedBox(
          height: 400,
          child: OverflowBox(
            minHeight: 400,
            maxHeight: 400,
            child: Lottie.asset(
              'assets/animation1.json',
              repeat: true,
            ),
          ),
        ),
        nextScreen: Thunder(pageController: thunderPageController),
        duration: 4000);
  }
}
