import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/reservas_service.dart';
import 'package:hotel_bella_vista/domain/controller/habitaciones_controller.dart';
import 'package:hotel_bella_vista/domain/controller/reservas_controller.dart';
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

  final _formKey = GlobalKey<FormState>();
  bool _saving_reserva = false;

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

    ConsultasReservasController rc = Get.find();
    rc.consultarServicio();

    print(sc.listaFinalServicio);

    if (_saving_reserva) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
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
                    TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor seleccione una habitacion";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    DropdownButtonFormField(
                      items: sc.listaFinalServicio!.map((e) {
                        return DropdownMenuItem(
                          value: e.nombre,
                          //child: Text(e.nombre),
                          child: Text("${e.nombre} - ${e.costo}"),
                        );
                      }).toList(),
                      onChanged: (dynamic value) {
                        selectedServices = value as String;

                        setState(() {
                          costoServicio = sc.listaFinalServicio!
                              .firstWhere((element) =>
                                  element.nombre == selectedServices)
                              .costo;

                          actualizarTotal();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor seleccione un servicio";
                        }
                        return null;
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
                    TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por digite el numero de personas";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor seleccione la fecha de entrada";
                        }
                        return null;
                      },
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        print("time: $pickedTime");
                        if (pickedTime != null) {
                          setState(() {
                            dateOfInput.text = formatDate(
                                pickedTime, [dd, '-', mm, '-', yyyy]);
                            print("Variable: $dateOfInput");
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: dateOfOutput,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor seleccione la fecha de salida";
                        }
                        print("fechaENTRADA --> ${dateOfInput.text}");
                        print("fechaSALIDA --> ${dateOfOutput.text}");
                        var comparar =
                            dateOfOutput.text.compareTo(dateOfInput.text);
                        print("comparar ----> $comparar");
                        if (comparar.isEqual(0)) {
                          return "";
                        } else if (comparar.isEqual(-1)) {
                          return "";
                        }
                        return null;
                      },
                      onTap: () async {
                        // String inputDate = dateOfInput.text;
                        // DateTime? parsedDate = DateTime.tryParse(inputDate);
                        // DateTime? fechaMasUnDia = parsedDate?.add(const Duration(days: 1));

                        // add(const Duration(days: 1));
                        DateTime? fechaMasUnDia =
                            DateTime.now().add(const Duration(days: 1));

                        DateTime? pickedTime2 = await showDatePicker(
                          context: context,
                          initialDate: fechaMasUnDia,
                          firstDate: fechaMasUnDia,
                          lastDate: DateTime(2101),
                        );

                        print("time: $pickedTime2");
                        if (pickedTime2 != null) {
                          setState(() {
                            
                            dateOfOutput.text = formatDate(
                                pickedTime2, [dd, '-', mm, '-', yyyy]);
                            print("Variable: $dateOfOutput.text");

                            print("fechaENTRADA --> ${dateOfInput.text}");
                            print("fechaSALIDA --> ${pickedTime2}");
                            var comparar =
                                dateOfOutput.text.compareTo(dateOfInput.text);
                            print("comparar ----> $comparar");
                            if (comparar.isEqual(0)) {
                              _showSnackBar(context,
                                  "La fecha de salida no debe ser igual a la de entrada");
                              return;
                            } else if (comparar.isEqual(-1)) {
                              _showSnackBar(context,
                                  "La fecha de salida no debe ser menor a la de entrada");
                              return;
                            }
                          });

                          
                        }
                      },
                    ),

                    const SizedBox(height: 10),

                    TextFormField(
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
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          // Aquí puedes manejar la información del formulario, por ejemplo, enviarla a una base de datos.
                          saveReserva(context);
                          print("Numero de reserva: ${reserveNumber.text}");
                          print("Habitación seleccionada: ${selectedRoom}");
                          print("Servicios: ${selectedServices}");
                          print("Fecha de llegada: ${dateOfInput.text}");
                          print("Fecha de salida: ${dateOfOutput.text}");
                          print("Número de Personas: ${numberOfPeople.text}");
                          print("Total: ${total.text}");
                        }
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
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void saveReserva(BuildContext context) async {
    var numeroReserva = reserveNumber.text;
    var numeroHabitacionReserva = selectedRoom.toString();
    var numeroPersonasReserva = numberOfPeople.text;
    var servicios = selectedServices.toString();
    var fechaIngreso = dateOfInput.text;
    var fechaSalida = dateOfOutput.text;
    var totalAPagar = double.parse(total.text);

    // Verificar si la habitación está disponible
    ConsultasHabitacionController uc = Get.find();
    ConsultasReservasController crc = Get.find();
    bool isHabitacionDisponible = uc.listaFinalHabitaciones!
        .firstWhere((element) => element.numeroHabitacion == selectedRoom)
        .estaDisponible;

    // print("aaaaaaaaa ----> $isHabitacionDisponible");

    // bool isHabitacionDisponible =
    //     crc.listaFinalReserva!.firstWhere((element) => element.numeroHabitacion == numeroHabitacionReserva)
    //     .numeroHabitacion;
    if (!isHabitacionDisponible) {
      print("Error: La habitación seleccionada no está disponible.");
      print(isHabitacionDisponible);
      // _showSnackBar(context, "La habitación seleccionada no está disponible.");
      return;
    }

    bool isDateAvailable = await isFechaDisponible(fechaIngreso, fechaSalida);

    if (!isDateAvailable) {
      print("Error: La fecha seleccionada ya está reservada por otro usuario.");
      return;
    }

    crc.cambiarDisponibilidadHabitacion(numeroHabitacionReserva, false);

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
    Get.offNamed('/home_user');
  }

  Future<bool> isFechaDisponible(
      String fechaIngreso, String fechaSalida) async {
    List<ReservaHotel> reservas = await ReservasService().getReservasByFecha(
      fechaIngreso,
      fechaSalida,
    );

    // Si la lista de reservas es vacía, la fecha está disponible
    return reservas.isEmpty;
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
