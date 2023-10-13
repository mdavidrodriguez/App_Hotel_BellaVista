import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/ui/pages/Login/login.dart';
import 'package:hotel_bella_vista/ui/pages/Login/register.dart';
import 'package:hotel_bella_vista/ui/pages/Login/splash.view.dart';
// import 'package:hotel_bella_vista/ui/pages/home/home.dart';
import 'package:hotel_bella_vista/ui/pages/home/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Hotel',
      theme: ThemeData(primarySwatch: Colors.purple),
      initialRoute: '/plashvView',
      // home: SplashView(),
      routes: {
        '/plashvView': (context) => const SplashView(),
        '/home': (context) => const HomeView(),
        '/login': (context) => LoginView(),
        '/register': (context) => Register()
      },
    );
  }
}
