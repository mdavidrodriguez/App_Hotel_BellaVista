import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/controlleruser.dart';
import 'package:hotel_bella_vista/domain/models/reservation.dart';

class ReservaDetailsScreen extends StatelessWidget {
  final ReservaHotel reserva;

  const ReservaDetailsScreen({super.key, required this.reserva});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Reserva'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ReservaInfoWidget(reserva: reserva),
          ],
        ),
      ),
    );
  }
}

class ReservaInfoWidget extends StatelessWidget {
  final ReservaHotel reserva;

  const ReservaInfoWidget({Key? key, required this.reserva}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ControlUserAuth cua = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<String?>(
            future: cua.getUserName(
                reserva.uid), // Usa el método getUserName de tu controlador
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                print('Error en FutureBuilder: ${snapshot.error}');
                return const Text('Error al cargar el nombre del usuario');
              } else if (snapshot.hasData) {
                return buildInfo("Nombre Cliente", snapshot.data.toString());
              } else {
                print('Nada en el FutureBuilder');
                return Container(); // Maneja otros casos si es necesario
              }
            },
          ),
          buildInfo("Número de Reserva", reserva.numeroReserva),
          buildInfo("Número de Habitación", reserva.numeroHabitacion),
          buildInfo("Servicios", reserva.servicios),
          buildInfo("Número de Personas", reserva.numeroPersonas),
          buildInfo("Fecha de Check-In", reserva.fechaCheckIn),
          buildInfo("Fecha de Check-Out", reserva.fechaCheckOut),
          buildInfo("Precio Total", " ${reserva.precioTotal.toString()}"),
        ],
      ),
    );
  }

  Widget buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        "$label: $value",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
