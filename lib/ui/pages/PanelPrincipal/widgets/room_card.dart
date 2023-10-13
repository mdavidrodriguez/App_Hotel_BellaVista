import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navegar a la otra ruta cuando se presiona la tarjeta
        Navigator.pushNamed(context, '/room/register');
      },
      onHover: (value) => const Text("Habitaciones"),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        margin: EdgeInsets.zero,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.400,
          child: Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/Inicio.png',
                height: 400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
