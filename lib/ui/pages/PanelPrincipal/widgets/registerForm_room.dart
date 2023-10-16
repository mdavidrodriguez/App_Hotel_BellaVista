import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomRegister extends StatefulWidget {
  const RoomRegister({super.key});

  @override
  State<RoomRegister> createState() => _RoomRegisterState();
}

class _RoomRegisterState extends State<RoomRegister> {
  String roomNumber = "";
  String roomType = "";
  double roomPrice = 0.0;
  int numberOfPeople = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Espacio para la imagen
                const Placeholder(
                  // Puedes usar un widget como `Image.asset` para mostrar la imagen aquí.
                  fallbackHeight: 200,
                ),
                const SizedBox(height: 20),

                // Campo de número de habitación
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Número de Habitación",
                  ),
                  onChanged: (value) {
                    setState(() {
                      roomNumber = value;
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Campo de tipo de habitación
                TextField(
                  decoration:
                      const InputDecoration(labelText: "Tipo de Habitación"),
                  onChanged: (value) {
                    setState(() {
                      roomType = value;
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Campo de precio
                TextField(
                  decoration:
                      const InputDecoration(labelText: "Precio por Noche"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      roomPrice = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Campo de número de personas
                TextField(
                  decoration:
                      const InputDecoration(labelText: "Número de Personas"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      numberOfPeople = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Botón para enviar el formulario
                FilledButton(
                  onPressed: () {
                    // Aquí puedes manejar la información del formulario, por ejemplo, enviarla a una base de datos.

                    print("Número de Habitación: $roomNumber");
                    print("Tipo de Habitación: $roomType");
                    print("Precio por Noche: $roomPrice");
                    print("Número de Personas: $numberOfPeople");
                  },
                  child: const Text("Registrar"),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
