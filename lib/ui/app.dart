import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/config/theme/app_theme.dart';
import 'package:hotel_bella_vista/data/state/state.dart';
import 'package:hotel_bella_vista/ui/pages/Login/login.dart';
import 'package:hotel_bella_vista/ui/pages/Login/register.dart';
import 'package:hotel_bella_vista/ui/pages/Login/splash.view.dart';
import 'package:hotel_bella_vista/ui/pages/panelPrincipal/listaReservas.dart';
import 'package:hotel_bella_vista/ui/pages/panelPrincipal/registerForm_Reservation.dart';
import 'package:hotel_bella_vista/ui/pages/panelPrincipal/servicioCliente.dart';
import 'package:hotel_bella_vista/ui/pages/home/panel.dart';
import 'package:hotel_bella_vista/ui/pages/Reservation/reservartion_screen.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/addhabitacion_screen.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/listar_habitaciones.dart';
import 'package:hotel_bella_vista/ui/pages/home/home_view.dart';
import 'package:hotel_bella_vista/ui/pages/perfil/listarusuarios.dart';
import 'package:hotel_bella_vista/ui/pages/servicios/addservicio.dart';
import 'package:hotel_bella_vista/ui/pages/servicios/listarservicios.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HabshelfBloc(HabitacionShelState([])),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Hotel',
        theme: AppTheme(selectedColor: 1).getTheme(),
        initialRoute: '/plashView',
        // home:
        routes: {
          '/plashView': (context) => const SplashView(),
          '/home': (context) => const HomeView(title: 'Bella vista'),
          '/login': (context) => const LoginView(),
          '/register': (context) => const Register(),
          '/panel': (context) => const PanelView(),
          '/reservation/register': (context) => const ReservasScreen(),
          '/contacto': (context) => const ContactScreen(),
          '/reservationAdmin': (context) => const ReservationScreen(),
          '/reservashelf': (context) => const HabitacionkshelfScreen(),
          '/editarhabitacion': (context) => const EditHabitacionScreen(),
          '/listarHabitaciones': (context) => const ListarHabitaciones(),
          '/editarservicio': (context) => const EditServicioScreen(),
          '/listarservicios': (context) => const ListarServicios(),
          '/listarUsuarios': (context) => const ListarUsuarios(),
        },
      ),
    );
  }
}
