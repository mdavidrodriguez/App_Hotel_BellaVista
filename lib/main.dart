import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/controluser.dart';
import 'package:hotel_bella_vista/domain/controller/habitaciones_controller.dart';
import 'package:hotel_bella_vista/domain/controller/servicios_controller.dart';
import 'package:hotel_bella_vista/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
/*   GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDELZkJd10YfaX_riPF-bSuB29_oBbSpwc",
              authDomain: "hotelbellavista-e9e72.firebaseapp.com",
              projectId: "hotelbellavista-e9e72",
              storageBucket: "hotelbellavista-e9e72.appspot.com",
              messagingSenderId: "942578221527",
              appId: "1:942578221527:web:420b864629f47d82ef8b92"))
      : await Firebase.initializeApp(); */
  Get.put(ConsultasHabitacionController());
  Get.put(ConsultasServiciosController());
  Get.put(ControlUserAuth());

  runApp(const MyApp());
}
