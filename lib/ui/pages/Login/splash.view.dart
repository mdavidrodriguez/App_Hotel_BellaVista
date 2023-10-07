import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/ui/pages/Login/login.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(LoginView());
    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Para que la imagen ocupe toda la pantalla
        children: [
          // Agrega la imagen como fondo
          Image.asset(
            'assets/images/Inicio.png', // Reemplaza con la ruta de tu imagen
            fit: BoxFit.cover, // Para que la imagen se ajuste a la pantalla
          ),
          // Agrega un contenedor para el texto centrado en la parte superior
        ],
      ),
    );
  }
}
