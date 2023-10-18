import 'package:flutter/material.dart';

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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fondo.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Espacio para la imagen
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Campo de número de habitación
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Número de Habitación",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          roomNumber = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Campo de tipo de habitación
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Tipo de Habitación",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          roomType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Campo de precio
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Precio por Noche",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          roomPrice = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Campo de número de personas
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Número de Personas",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          numberOfPeople = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // Botón para enviar el formulario
                    ElevatedButton(
                      onPressed: () {
                        // Aquí puedes manejar la información del formulario, por ejemplo, enviarla a una base de datos.
                        print("Número de Habitación: $roomNumber");
                        print("Tipo de Habitación: $roomType");
                        print("Precio por Noche: $roomPrice");
                        print("Número de Personas: $numberOfPeople");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Text(
                        "Registrar",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
