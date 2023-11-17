import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/controlleruser.dart';
import 'package:hotel_bella_vista/domain/controller/habitaciones_controller.dart';
import 'package:hotel_bella_vista/domain/controller/reservas_controller.dart';
import 'package:hotel_bella_vista/domain/controller/servicios_controller.dart';
import 'package:hotel_bella_vista/domain/controller/user_services.dart';
import 'package:hotel_bella_vista/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ConsultasHabitacionController());
  Get.put(ConsultasServiciosController());
  Get.put(ConsultasReservasController());
  Get.put(ControlUserAuth());
  Get.put(UserController());

  runApp(const MyApp());
}
