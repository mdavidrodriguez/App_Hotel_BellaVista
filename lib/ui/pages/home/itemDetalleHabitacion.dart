
import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/domain/models/habitacion.dart';

class ItemDetallesHabitacion extends StatelessWidget {
  const ItemDetallesHabitacion({
    super.key,
    required this.habitacion,
  });

  final HabitacionHotel habitacion;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Text(
            habitacion.precioPorNoche.toString(),
          ),
        ),
      ],
    );
  }
}