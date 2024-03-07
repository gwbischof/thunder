import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:thunder/settings/pages/settings_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: Column(children: [Image.asset('assets/logo.png'), const Text("MoversMarket")]), nextScreen: SettingsPage());
  }
}
