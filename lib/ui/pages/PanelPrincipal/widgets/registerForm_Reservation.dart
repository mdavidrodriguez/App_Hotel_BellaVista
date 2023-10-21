import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class ReservasRegister extends StatefulWidget {
  const ReservasRegister({super.key});

  @override
  State<ReservasRegister> createState() => _ReservasRegisterState();
}

class _ReservasRegisterState extends State<ReservasRegister> {
  String reserveDate = "";
  String roomType = "";
  double reserveNumberOfRooms = 0.0;
  int numberOfPeople = 0;
  TextEditingController dateOfInput = TextEditingController();
  TextEditingController dateOfOutput = TextEditingController();

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Campo de número de habitación
                TextField(
                  decoration: InputDecoration(
                    labelText: "Fecha de reserva",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      reserveDate = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                // Campo de tipo de habitación
                TextField(
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
                // Campo de número de personas
                TextField(
                  decoration: InputDecoration(
                    labelText: "Personas",
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
                TextField(
                  controller: dateOfInput,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_today_rounded),
                    labelText: "Fecha de Entrada",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onTap: () async {
                    DateTime? pickedTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    print("time: $pickedTime");
                    if (pickedTime != null) {
                      setState(() {
                        dateOfInput.text =
                            formatDate(pickedTime, [dd, '-', mm, '-', yyyy]);
                        print("Variable: $dateOfInput");
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: dateOfOutput,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_today_rounded),
                    labelText: "Fecha de Salida",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.text,
                  onTap: () async {
                    DateTime? pickedTime2 = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    print("time: $pickedTime2");
                    if (pickedTime2 != null) {
                      setState(() {
                        dateOfOutput.text =
                            formatDate(pickedTime2, [dd, '-', mm, '-', yyyy]);
                        print("Variable: $dateOfOutput");
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                // Botón para enviar el formulario
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes manejar la información del formulario, por ejemplo, enviarla a una base de datos.
                    print("Número de Habitación: $reserveDate");
                    print("Tipo de Habitación: $roomType");
                    print("Precio por Noche: $reserveNumberOfRooms");
                    print("Número de Personas: $numberOfPeople");
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: const Text("Registrar"),
                ),
              ],
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
