import 'package:flutter/material.dart';



class ReservationCard extends StatelessWidget {
  const ReservationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/reservation/register');
      },
      onHover: (value) => const Text("Habitaciones"),
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
                'assets/images/reserva-legal.png',
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