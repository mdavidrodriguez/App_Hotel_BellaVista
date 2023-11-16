import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/listado_habitaciones.dart';
import 'package:hotel_bella_vista/ui/pages/panelPrincipal/contacto.dart';
import 'package:hotel_bella_vista/ui/pages/panelPrincipal/reservacionesUser.dart';
import 'package:hotel_bella_vista/ui/pages/panelPrincipal/reservation_card.dart';
import 'package:hotel_bella_vista/ui/pages/panelPrincipal/servicios_card.dart';

class CardsViewUser extends StatelessWidget {
  const CardsViewUser({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          const RoomCard(),
          TextEncabezados(
              texto: Text(
            "HABITACIONES",
            style: TextStyle(
                color: Colors.white,
                backgroundColor: colors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          )),
          const SizedBox(
            height: 10,
          ),
          const ReservationCard(),
          TextEncabezados(
              texto: Text(
            "RESERVAR",
            style: TextStyle(
                color: Colors.white,
                backgroundColor: colors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          )),
          const SizedBox(
            height: 10,
          ),
          const ReservacionesUser(),
          TextEncabezados(
              texto: Text(
            "RESERVACIONES",
            style: TextStyle(
                color: Colors.white,
                backgroundColor: colors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          )),
          const SizedBox(
            height: 10,
          ),
          const ServiciosListaCard(),
          TextEncabezados(
              texto: Text(
            "SERVICIOS",
            style: TextStyle(
                color: Colors.white,
                backgroundColor: colors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          )),
          const SizedBox(
            height: 10,
          ),
          const Contacto(),
          TextEncabezados(
              texto: Text(
            "CONTACTO",
            style: TextStyle(
                color: Colors.white,
                backgroundColor: colors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          )),
        ],
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  const RoomCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ListaHabitaciones()));
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
                'assets/images/room.jpeg',
                fit: BoxFit.cover,
                width: 300,
                height: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextEncabezados extends StatelessWidget {
  const TextEncabezados({super.key, required this.texto});
  final Text texto;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: colors.primary,
            padding: const EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.center,
              child: texto,
            ),
          ),
        ),
      ),
    );
  }
}
