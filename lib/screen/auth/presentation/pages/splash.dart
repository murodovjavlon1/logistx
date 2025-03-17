import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      context.go('/home_page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "asset/image/360_F_391898485_QPJhJT5WJVLFOAplGXmZWKFbyHW9VAdm-removebg-preview.png",
        ),
      ),
    );
  }
}
