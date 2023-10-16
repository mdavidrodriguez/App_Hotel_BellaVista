import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hotel_bella_vista/ui/pages/home/home.dart';
// import 'package:hotel_bella_vista/ui/pages/home/home_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.toNamed('/home');
    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/Inicio.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
