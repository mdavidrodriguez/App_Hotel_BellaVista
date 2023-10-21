import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/ui/pages/PanelPrincipal/widgets/room_card.dart';
import 'package:hotel_bella_vista/ui/pages/Reservation/reservartion_screen.dart';
import 'package:hotel_bella_vista/ui/pages/home/HomeScreen.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  static List<Widget> _sectionWidgets = [
    HomeScreen(),
    ReservationGrid(),
    const CardsView()
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: const Text('Hotel Bella vista',
            style: TextStyle(color: Colors.white)),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _sectionWidgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.room_service), label: 'Servicios'),
          BottomNavigationBarItem(
              icon: Icon(Icons.meeting_room), label: 'Reservas'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
