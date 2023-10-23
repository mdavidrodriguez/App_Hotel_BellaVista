import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/data/services/habitacionesService.dart';
import 'package:hotel_bella_vista/domain/models/habitacion.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/detalle_habitacion_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HabitacionHotel> _habitaciones = [];

  @override
  void initState() {
    super.initState();
    _getLastHabitaciones();
  }

  void _getLastHabitaciones() async {
    var lastHabitaciones = await HabitacionesService().getLastHabitaciones();
    setState(() {
      _habitaciones = lastHabitaciones;
    });
  }

  @override
  Widget build(BuildContext context) {
    var showProgress = _habitaciones.isEmpty;
    var listLenght = showProgress ? 5 : _habitaciones.length + 1;
    return Container(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: listLenght,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const HeaderWidget();
            }
            if (showProgress) {
              return const Center(child: CircularProgressIndicator());
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
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: getImageWidget(habitacion.imagenes),
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HabitacionDetailsScreen(habitacion: habitacion)));
  }

  Widget getImageWidget(String imagenes) {
    if (imagenes.startsWith("http")) {
      return Image.network(imagenes, height: 150, width: 150);
    } else {
      return Image.asset(imagenes, height: 150, width: 150);
    }
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
