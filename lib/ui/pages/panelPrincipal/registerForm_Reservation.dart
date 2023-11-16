import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/reservas_service.dart';
import 'package:hotel_bella_vista/domain/controller/controlleruser.dart';
import 'package:hotel_bella_vista/domain/controller/habitaciones_controller.dart';
import 'package:hotel_bella_vista/domain/controller/servicios_controller.dart';
import 'package:hotel_bella_vista/domain/models/reservation.dart';

class ReservasScreen extends StatelessWidget {
  const ReservasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReservaHotel? reservas = Get.arguments as ReservaHotel?;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar reserva"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ReservasRegister(reserva: reservas),
    );
  }
}

class ReservasRegister extends StatefulWidget {
  final ReservaHotel? reserva;
  const ReservasRegister({super.key, required this.reserva});

  @override
  State<ReservasRegister> createState() => _ReservasRegisterState();
}

class _ReservasRegisterState extends State<ReservasRegister> {
  TextEditingController reserveNumber = TextEditingController();
  TextEditingController numberOfPeople = TextEditingController();
  String selectedServices = "";
  String selectedRoom = "";
  TextEditingController dateOfInput = TextEditingController();
  TextEditingController dateOfOutput = TextEditingController();
  TextEditingController total = TextEditingController();

  double costoHabitacion = 0.0;
  double costoServicio = 0.0;

  double calcularTotal() {
    // Sumar el precio de la habitación seleccionada
    double totalPagar = 0.0;

    if (selectedRoom.isNotEmpty) {
      totalPagar += costoHabitacion;
    }

    // Sumar el precio del servicio seleccionado
    if (selectedServices.isNotEmpty) {
      totalPagar += costoServicio;
    }

    return totalPagar;
  }

  void actualizarTotal() {
    double totalPagar = calcularTotal();
    setState(() {
      total.text = totalPagar.toString();
    });
  }

  // final _formKey = GlobalKey<FormState>();
  // bool _saving_habitacion = false;

  @override
  void initState() {
    super.initState();
    reserveNumber.text = Random().nextInt(100000).toString();
    total.text = calcularTotal().toString();
  }

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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Campo de número de habitación
                  TextField(
                    controller: reserveNumber,
                    decoration: InputDecoration(
                      labelText: "Numero de reserva",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    readOnly: true,
                    // onChanged: (value) {
                    //   setState(() {
                    //     reserveNumber.text = Random().nextInt(100000).toString();
                    //   });
                    // },
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
                        costoHabitacion = uc.listaFinalHabitaciones!
                            .firstWhere((element) =>
                                element.numeroHabitacion == selectedRoom)
                            .precioPorNoche;
                        actualizarTotal();
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

                      setState(() {
                        costoServicio = sc.listaFinalServicio!
                            .firstWhere(
                                (element) => element.nombre == selectedServices)
                            .costo;

                        actualizarTotal();
                      });
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
                        numberOfPeople.text = (value);
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
                    readOnly: true,
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
                    readOnly: true,
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
                          print("Variable: $dateOfInput");
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: total,
                    decoration: InputDecoration(
                      labelText: "Total a pagar",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    readOnly: true,
                    onChanged: (value) {
                      setState(() {
                        total.text = calcularTotal().toString();
                      });
                    },
                  ),

                  const SizedBox(height: 20),
                  // Botón para enviar el formulario
                  ElevatedButton(
                    onPressed: () {
                      saveReserva(context);
                      // Aquí puedes manejar la información del formulario, por ejemplo, enviarla a una base de datos.
                      print("Numero de reserva: ${reserveNumber.text}");
                      print("Habitación seleccionada: ${selectedRoom}");
                      print("Servicios: ${selectedServices}");
                      print("Fecha de llegada: ${dateOfInput.text}");
                      print("Fecha de salida: ${dateOfOutput.text}");
                      print("Número de Personas: ${numberOfPeople.text}");
                      print("Total: ${total.text}");
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

  ControlUserAuth cua = Get.find();
  void saveReserva(BuildContext context) async {
    var numeroReserva = reserveNumber.text;
    var numeroHabitacionReserva = selectedRoom;
    var numeroPersonasReserva = numberOfPeople.text;
    var servicios = selectedServices.toString();
    var fechaIngreso = dateOfInput.text;
    var fechaSalida = dateOfOutput.text;
    var totalAPagar = double.parse(total.text);

    if (widget.reserva == null) {
      String newReservaId = await ReservasService().saveReservas(
        numeroReserva,
        numeroHabitacionReserva,
        servicios,
        numeroPersonasReserva,
        fechaIngreso,
        fechaSalida,
        totalAPagar,
      );
      print(newReservaId);
    }
    Get.offNamed('/home');
  }
}
