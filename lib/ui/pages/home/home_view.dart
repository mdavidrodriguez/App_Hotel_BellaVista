import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/ui/pages/panelPrincipal/listaReservas.dart';
import 'package:hotel_bella_vista/ui/pages/panelPrincipal/room_card.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/listar_habitaciones.dart';
import 'package:hotel_bella_vista/ui/pages/home/homeScreen.dart';
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
    const HomeScreen(),
    const HabitacionkshelfScreen(),
    const CardsView()
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
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
        // automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, right: 5),
            child: FloatingActionButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.popAndPushNamed(context, '/login');
              },
              child: const Icon(Icons.login_outlined),
            ),
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
            const ItemDrawer(
                icono: Icon(Icons.home),
                pantalla: ListarHabitaciones(),
                titulo: Text('Habitaciones')),
            const ItemDrawer(
                titulo: Text('Servicios'),
                pantalla: ListarServicios(),
                icono: Icon(Icons.room_service_outlined)),
            const ItemDrawer(
                titulo: Text('Perfil'),
                pantalla: Userscreen(),
                icono: Icon(Icons.supervised_user_circle)),
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

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({
    super.key,
    required this.titulo,
    required this.pantalla,
    required this.icono,
  });

  final Text titulo;
  final Widget pantalla;
  final Icon icono;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icono,
      title: titulo,
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => pantalla));
      },
    );
  }
}
