// ignore_for_file: prefer_final_fields
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/controluser.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/listahabitacionesgenerales.dart';
import 'package:hotel_bella_vista/ui/pages/panelPrincipal/listaReservas.dart';
import 'package:hotel_bella_vista/ui/pages/panelPrincipal/room_card.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/listar_habitaciones.dart';
import 'package:hotel_bella_vista/ui/pages/home/homeScreen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hotel_bella_vista/ui/pages/perfil/listarusuarios.dart';
import 'package:hotel_bella_vista/ui/pages/perfil/mostrarperfil.dart';
import 'package:hotel_bella_vista/ui/pages/servicios/listadoserviciosgenerales.dart';
import 'package:hotel_bella_vista/ui/pages/servicios/listarServicios.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ControlUserAuth sc = Get.find();
  int _selectedIndex = 0;
  static List<Widget> _sectionWidgets = [
    const HomeScreen(),
    const HabitacionkshelfScreen(),
    const CardsView(),
  ];

  final List<DrawerItem> drawerItems = [
    DrawerItem(
      icon: const Icon(Icons.home),
      title: const Text('Habitaciones'),
      screen: const ListarHabitaciones(),
    ),
    DrawerItem(
      icon: const Icon(Icons.home),
      title: const Text('Habitaciones Generales'),
      screen: const ListaHabitaciones(),
    ),
    DrawerItem(
      icon: const Icon(Icons.room_service_outlined),
      title: const Text('Servicios'),
      screen: const ListarServicios(),
    ),
    DrawerItem(
      icon: const Icon(Icons.room_service_outlined),
      title: const Text('Servicios Generales'),
      screen: const ListadoServicios(),
    ),
    DrawerItem(
      icon: const Icon(Icons.supervised_user_circle),
      title: const Text('Perfil'),
      screen: const Userscreen(),
    ),
    DrawerItem(
      icon: const Icon(Icons.supervisor_account_rounded),
      title: const Text('Usuarios'),
      screen: const ListarUsuarios(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    sc.consultarServicio();
    final colors = Theme.of(context).colorScheme;
    bool isGoogleSignIn =
        FirebaseAuth.instance.currentUser?.providerData[0].providerId ==
            'google.com';

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: colors.primary,
        title: const Text(
          'Hotel Bella vista',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, right: 5),
            child: FloatingActionButton(
              onPressed: () {
                sc.cerrarSesion();
                Get.offAllNamed('/login');
              },
              child: const Icon(Icons.login_outlined),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: drawerItems.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return DrawerHeader(
                decoration: BoxDecoration(color: colors.primary),
                padding: EdgeInsets.zero,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          child: ClipOval(
                            child: Image.network(
                              isGoogleSignIn
                                  ? FirebaseAuth.instance.currentUser!.photoURL!
                                  : sc.listafinal![index].imagen,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isGoogleSignIn
                            ? FirebaseAuth.instance.currentUser!.displayName!
                            : "${sc.listafinal![index].nombre} - ${sc.listafinal![index].apellido}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              final itemIndex = index - 1;
              return ListTile(
                leading: drawerItems[itemIndex].icon,
                title: drawerItems[itemIndex].title,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => drawerItems[itemIndex].screen,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _sectionWidgets,
      ),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28.0)),
        child: Container(
          color: colors.primary,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
            child: GNav(
              backgroundColor: colors.primary,
              gap: 8,
              color: Colors.white,
              activeColor: colors.primary,
              tabBackgroundColor: Colors.white,
              padding: const EdgeInsets.all(10),
              tabs: const [
                GButton(
                  icon: Icons.room_service,
                  text: 'Servicios',
                ),
                GButton(
                  icon: Icons.meeting_room,
                  text: 'Reservas',
                ),
                GButton(
                  icon: Icons.home,
                  text: 'Inicio',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class DrawerItem {
  final Icon icon;
  final Text title;
  final Widget screen;

  DrawerItem({
    required this.icon,
    required this.title,
    required this.screen,
  });
}
