import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/ui/pages/Reservation/lista_reservaciones.dart';

class ReservacionesAdmin extends StatelessWidget {
  const ReservacionesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListaReservaciones(),
            ));
      },
      onHover: (value) => const Text("Reservaciones"),
      child: Center(
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: colors.surface,
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          margin: EdgeInsets.zero,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/reservaciones.png',
                fit: BoxFit.cover,
                width: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}