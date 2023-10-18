import 'package:flutter/material.dart';

class Contacto extends StatelessWidget {
  const Contacto({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/contacto');
      },
      onHover: (value) => const Text("Contacto"),
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
                'assets/images/contacto.jpeg',
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
