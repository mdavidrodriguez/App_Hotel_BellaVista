import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/ui/pages/Login/splash.view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: SplashView());
  }
}
