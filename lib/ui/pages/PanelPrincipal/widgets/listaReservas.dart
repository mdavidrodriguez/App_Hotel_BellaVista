import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/domain/models/habitacion.dart';

class ReservaShelf extends StatelessWidget {
  ReservaShelf({super.key});
  final List<HabitacionHotel> _habitaciones = [
    HabitacionHotel(
      id: "1",
      numeroHabitacion: '12',
      tipoHabitacion: 'Premium',
      precioPorNoche: 30000,
      descripcion: 'Comoda y amplia',
      capacidad: 12,
      estaDisponible: true,
      imagenes: 'assets/images/room.jpeg',
      comodidades: '',
    ),
    HabitacionHotel(
      id: "1",
      numeroHabitacion: '12',
      tipoHabitacion: 'Premium',
      precioPorNoche: 30000,
      descripcion: 'Comoda y amplia',
      capacidad: 12,
      estaDisponible: true,
      imagenes: 'assets/image.png',
      comodidades: '',
    ),
    HabitacionHotel(
      id: "1",
      numeroHabitacion: '12',
      tipoHabitacion: 'Premium',
      precioPorNoche: 30000,
      descripcion: 'Comoda y amplia',
      capacidad: 12,
      estaDisponible: true,
      imagenes: 'assets/images/room.jpeg',
      comodidades: '',
    ),
  ];
  

  @override
  Widget build(BuildContext context) {
    if (_habitaciones.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Lista de Reservaciones')),
          ),
          body: const Center(
            child: Text(
              'Aun no tienes ninguna reserva realizada',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Lista de Reservaciones')),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7),
          itemCount: _habitaciones.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {},
                child: Ink.image(
                    fit: BoxFit.fitHeight,
                    image: AssetImage(_habitaciones[index].imagenes)));
          },
        ),
      ),
    );
  }
}
