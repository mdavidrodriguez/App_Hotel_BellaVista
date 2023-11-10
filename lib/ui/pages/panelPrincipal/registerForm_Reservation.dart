import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/habitaciones_controller.dart';
import 'package:hotel_bella_vista/domain/controller/servicios_controller.dart';


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
  String selectedServices = "";

  String selectedRoom = "";

  TextEditingController dateOfInput = TextEditingController();
  TextEditingController dateOfOutput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ConsultasServiciosController sc = Get.find();
    sc.consultarServicio();

    ConsultasHabitacionController uc = Get.find();
    uc.consultarHabitaciones();

    print(sc.listaFinalServicio);

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

                DropdownButtonFormField(
                  items: uc.listaFinalHabitaciones!.map((e) {
                    return DropdownMenuItem(
                      value: e
                          .numeroHabitacion, // Supongo que "nombre" es el campo que deseas mostrar
                      //child: Text(e.nombre),
                      child: Text(
                          "${e.numeroHabitacion} ${e.tipoHabitacion} - ${e.precioPorNoche}"),
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    selectedRoom = value as String;
                    setState(() {
                      print("Habitacion seleccionada: $selectedRoom");
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Habitaciones",
                    prefixIcon: Icon(
                      Icons.room_preferences_rounded,
                      color: Colors.blueGrey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  dropdownColor: Colors.white,
                ),

                const SizedBox(height: 10),

                DropdownButtonFormField(
                  items: sc.listaFinalServicio!.map((e) {
                    return DropdownMenuItem(
                      value: e
                          .nombre, // Supongo que "nombre" es el campo que deseas mostrar
                      //child: Text(e.nombre),
                      child: Text("${e.nombre} - ${e.costo}"),
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    selectedServices = value as String;

                    setState(() {});
                  },
                  isDense: true,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: "Servicios",
                    prefixIcon: Icon(
                      Icons.alarm_add,
                      color: Colors.blueGrey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  dropdownColor: Colors.white,
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
                    prefixIcon: const Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.blueGrey,
                    ),
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
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.blueGrey,
                    ),
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
                        dateOfInput.text =
                            formatDate(pickedTime2, [dd, '-', mm, '-', yyyy]);
                        print("Variable: $dateOfInput");
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                // Botón para enviar el formulario
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes manejar la información del formulario, por ejemplo, enviarla a una base de datos.

                    print("Habitación seleccionada: ${selectedRoom}");
                    print("Servicios: ${selectedServices}");
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
