import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/domain/models/habitacion.dart';

class HabitacionDetailsScreen extends StatelessWidget {
  final HabitacionHotel habitacion;
  const HabitacionDetailsScreen({super.key, required this.habitacion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle Habitación'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HabitacionCoverWidget(coverUrl: habitacion.imagenes),
            HabitacionInfoWidget(
                tipohabitacion:
                    "Tipo de habitación: ${habitacion.tipoHabitacion}",
                capacidad:
                    "Capacidad de personas: ${habitacion.capacidad.toString()}",
                precioNoche:
                    "Precio por Noche: ${habitacion.precioPorNoche.toString()}",
                numeroHabitacion:
                    "Numero de habitación: ${habitacion.numeroHabitacion}",
                comodidades: "Comodidades: ${habitacion.comodidades}",
                descripcion: "Descripción: ${habitacion.descripcion}"),
            ElevatedButton(onPressed: () {}, child: const Text("Agregar"))
          ],
        ),
      ),
    );
  }
}

class HabitacionCoverWidget extends StatelessWidget {
  final String coverUrl;
  const HabitacionCoverWidget({super.key, required this.coverUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      width: 400,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10)
      ]),
      child: Image.asset(coverUrl),
    );
  }
}

class HabitacionInfoWidget extends StatelessWidget {
  final String tipohabitacion;
  final String capacidad;
  final String precioNoche;
  final String numeroHabitacion;
  final String comodidades;
  final String descripcion;
  const HabitacionInfoWidget({
    super.key,
    required this.tipohabitacion,
    required this.capacidad,
    required this.precioNoche,
    required this.numeroHabitacion,
    required this.comodidades,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text(
            tipohabitacion,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            capacidad,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            precioNoche,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            numeroHabitacion,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            comodidades,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            descripcion,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
