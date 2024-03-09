import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

PageController thunderPageController = PageController(initialPage: 0);

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }

  route() {
    context.goNamed("home");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(color: Colors.red),
        child: SizedBox(
          height: 400,
          child: OverflowBox(
            minHeight: 400,
            maxHeight: 400,
            child: Lottie.asset(
              'assets/animation1.json',
              repeat: true,
            ),
          ),
        ));
  }
}
