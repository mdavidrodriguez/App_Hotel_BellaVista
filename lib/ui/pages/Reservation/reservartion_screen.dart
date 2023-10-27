import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/domain/models/reservation.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ReservationGrid();
  }
}

class ReservationGrid extends StatelessWidget {
  ReservationGrid({super.key});

  final List<ReservaHotel> _reservation = [
    ReservaHotel(
        id: "123",
        nombreHuesped: 'Mateo',
        numeroReserva: '28374',
        fechaCheckIn: ("2023"),
        fechaCheckOut: ("2023"),
        tipoHabitacion: 'Premium',
        precioTotal: 20000,
        metodoPago: 'Efectivo',
        contactoHuesped: '3104956725',
        // ocupacion: 3,
        // historialReserva: [
        //   HistorialReserva(
        //       fecha: DateTime(2023, 10, 15), accion: 'Pago confirmado')
        ),
    ReservaHotel(
        id: "234",
        nombreHuesped: 'Mateo',
        numeroReserva: '28374',
        fechaCheckIn: ("2023"),
        fechaCheckOut: ("2023"),
        tipoHabitacion: 'Premium',
        precioTotal: 20000,
        metodoPago: 'Efectivo',
        contactoHuesped: '3104956725',
        // ocupacion: 3,
        // historialReserva: [
        //   HistorialReserva(
        //       fecha: DateTime(2023, 10, 15), accion: 'Pago confirmado')
        // ]
        ),
    ReservaHotel(
        id: "567",
        nombreHuesped: 'Mateo',
        numeroReserva: '28374',
        fechaCheckIn: ("2023"),
        fechaCheckOut: ("2023"),
        tipoHabitacion: 'Premium',
        precioTotal: 20000,
        metodoPago: 'Efectivo',
        contactoHuesped: '3104956725',
        // ocupacion: 3,
        // historialReserva: [
        //   HistorialReserva(
        //       fecha: DateTime(2023, 10, 15), accion: 'Pago confirmado')
        // ]
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: GridView.builder(
          itemCount: _reservation.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(4.0),
                onTap: () {
                  _navigateToReserva();
                },
                child: Container(
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.green.withOpacity(0.5),
                  ),
                  child: Text(
                    _reservation[index].nombreHuesped,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _navigateToReserva() {}

}
class Myhabitacion extends StatelessWidget {
  const Myhabitacion({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
