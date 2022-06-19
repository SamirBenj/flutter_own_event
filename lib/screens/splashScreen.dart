import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:flutter_own_event/navigationsBar/naviagationBar.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(seconds: 2),
            transitionsBuilder: (context, animation, animationTime, child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.elasticInOut);
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (context, animation, animationTime) {
              return NavigationBottomBar();
            }),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'OwnYourEvent 👋 !!',
                style: MONTSERRAT_BOLD_WHITE,
              ),
              Lottie.asset(
                'assets/event.json',
                width: MediaQuery.of(context).size.width * 0.60,
              ),
              Lottie.asset(
                'assets/waiting.json',
                width: MediaQuery.of(context).size.width * 0.60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
