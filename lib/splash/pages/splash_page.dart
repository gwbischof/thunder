import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        nextScreen: const NextScreen(),
        duration: 4000);
  }
}

/*
class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.go('/home');
    return const Text("");
  }
}
*/

class NextScreen extends StatefulWidget {
  const NextScreen({super.key});

  @override
  State<NextScreen> createState() => _NextScreen();
}

class _NextScreen extends State<NextScreen> {
  @override
  void initState() {
    context.go('/home');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
