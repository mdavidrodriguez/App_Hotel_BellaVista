import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/config/theme/app_theme.dart';
import 'package:hotel_bella_vista/data/state/state.dart';
import 'package:hotel_bella_vista/ui/pages/Login/login.dart';
import 'package:hotel_bella_vista/ui/pages/Login/register.dart';
import 'package:hotel_bella_vista/ui/pages/Login/splash.view.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/detalle_habitacion_screen.dart';
import 'package:hotel_bella_vista/ui/pages/home/home_users.dart';
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
          '/home_user': (context) =>
              const HomeViewUser(title: 'Bella vista User'),
          '/login': (context) => LoginView(),
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
//         onGenerateRoute: (settings) {
//   return MaterialPageRoute<dynamic>(
//     builder: (context) {
//       if (settings.name == '/panel') {
//         // Obtén el rol del usuario desde Firestore
//         FirebaseAuthService.getUserRoleFromFirestore().then((userRole) {
//           if (userRole == 'admin') {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => const PanelView()));
//           } else {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView(title: 'Bella vista')));
//           }
//         });

//         return Container(); // Devuelve un widget temporal mientras se resuelve la lógica asincrónica.
//       } else if (settings.name == '/reservation/register') {
//         // Obtén el rol del usuario desde Firestore
//         FirebaseAuthService.getUserRoleFromFirestore().then((userRole) {
//           if (userRole == 'admin') {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => const ReservasRegister()));
//           } else {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView(title: 'Bella vista')));
//           }
//         });

//         return Container(); // Devuelve un widget temporal mientras se resuelve la lógica asincrónica.
//       }

//       // Otras rutas personalizadas según el rol del usuario

//       return Container(); // Devuelve un widget temporal mientras se resuelve la lógica asincrónica.
//     },
//   );
// },
      ),
    );
  }
}
