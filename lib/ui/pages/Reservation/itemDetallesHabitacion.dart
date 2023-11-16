import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/domain/models/reservation.dart';

class ReservaInfoWidget extends StatelessWidget {
  final ReservaHotel reserva;

  const ReservaInfoWidget({
    Key? key,
    required this.reserva,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle de la reserva"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Número de reserva: ${reserva.numeroReserva}",
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Change color as needed
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Número de habitación: ${reserva.numeroHabitacion}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Change color as needed
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Servicios: ${reserva.servicios}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Change color as needed
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Número de personas: ${reserva.numeroPersonas}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Change color as needed
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Fecha de Check-In: ${reserva.fechaCheckIn}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Change color as needed
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Fecha de Check-Out: ${reserva.fechaCheckOut}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Change color as needed
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Precio Total: ${reserva.precioTotal.toString()}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green, // Change color as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}
