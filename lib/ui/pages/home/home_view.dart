import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/ui/pages/PanelPrincipal/widgets/listaReservas.dart';
import 'package:hotel_bella_vista/ui/pages/PanelPrincipal/widgets/room_card.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/listar_habitaciones.dart';
import 'package:hotel_bella_vista/ui/pages/home/HomeScreen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hotel_bella_vista/ui/pages/perfil/mostrarperfil.dart';
import 'package:hotel_bella_vista/ui/pages/servicios/listarServicios.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});
  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  static List<Widget> _sectionWidgets = [
    HomeScreen(),
    const HabitacionkshelfScreen(),
    const CardsView()
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: const Text(
          'Hotel Bella vista',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        // automaticallyImplyLeading: false,
        actions: [
          FloatingActionButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            child: const Icon(Icons.login_outlined),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: colors.primary),
                padding: EdgeInsets.zero,
                child: const Center(
                  child: Text('Menu de Opciones',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                )),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Habitaciones'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListarHabitaciones()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.room_service_outlined),
              title: const Text('Servicios'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListarServicios()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text('Usuarios'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Userscreen()));
              },
            ),
          ],
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
