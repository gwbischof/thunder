import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

import 'package:rive/rive.dart';

PageController thunderPageController = PageController(initialPage: 0);

// TODO: Load background data when splash is visible.
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
            height: 800,
            child: OverflowBox(
              minHeight: 800,
              maxHeight: 800,
              child: Column(children: [
                Lottie.asset('assets/moversmarket.json', backgroundLoading: true, repeat: false),
                SizedBox(height: 400, width: 400, child: Lottie.asset('assets/truck.json'))
              ]),
            )));
  }
}
