import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/domain/models/habitacion.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<HabitacionHotel> _habitaciones = [
    HabitacionHotel(
      id: 1,
      numeroHabitacion: '12',
      tipoHabitacion: 'Premium',
      precioPorNoche: 30000,
      descripcion: 'Comoda y amplia',
      capacidad: 12,
      estaDisponible: true,
      imagenes: ['assets/otel.png'],
      comodidades: ['Baño', 'Amplia', 'Aire'],
    ),
    HabitacionHotel(
      id: 2,
      numeroHabitacion: '13',
      tipoHabitacion: 'Premium',
      precioPorNoche: 30000,
      descripcion: 'Comoda y amplia',
      capacidad: 12,
      estaDisponible: true,
      imagenes: ['assets/image.png'],
      comodidades: ['Baño', 'Amplia', 'Aire'],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _habitaciones.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const HeaderWidget();
            }
            final habitacion = _habitaciones[index - 1];
            return Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(4.0),
                onTap: () {
                  _openHabitacionDetails(context, habitacion);
                },
                child: Row(
                  children: [
                    Image.asset(
                      habitacion.imagenes[0],
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              habitacion.descripcion,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(habitacion.numeroHabitacion),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(habitacion.tipoHabitacion),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(habitacion.precioPorNoche.toString()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openHabitacionDetails(
      BuildContext context, HabitacionHotel habitacion) {
    // Aquí puedes abrir los detalles de la habitación
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Builder(builder: (context) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/room.png'));
        }),
        const SizedBox(height: 10),
        const Text(
          'Ultimas Habitaciones',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
