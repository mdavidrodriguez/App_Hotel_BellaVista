import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/habitacionesService.dart';

class AddHabitacionScreen extends StatelessWidget {
  const AddHabitacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar habitación'),
      ),
      body: const AddHabitacionForm(),
    );
  }
}

class AddHabitacionForm extends StatefulWidget {
  const AddHabitacionForm({super.key});

  @override
  State<AddHabitacionForm> createState() => _AddHabitacionFormState();
}

class _AddHabitacionFormState extends State<AddHabitacionForm> {
  final nrohabitextController = TextEditingController();
  String? selectedTipoHabitacion;
  final preciNocheTextController = TextEditingController();
  final descripcionTextController = TextEditingController();
  final capacidadTextController = TextEditingController();
  bool isDisponible = false;
  final comodidadesTextController = TextEditingController();
  String? image;

  // Lista de opciones para el tipo de habitación
  List<String> tipoHabitacionOptions = [
    'Basica',
    'Premium',
    'VIP',
  ];
  final _formkey = GlobalKey<FormState>();
  bool _saving_habitacion = false;

  @override
  Widget build(BuildContext context) {
    if (_saving_habitacion) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Form(
        key: _formkey,
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
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nrohabitextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Numero de Habitación',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingresa el numero de la habitación";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedTipoHabitacion,
                        onChanged: (newValue) {
                          setState(() {
                            selectedTipoHabitacion = newValue;
                          });
                        },
                        items: tipoHabitacionOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Tipo de Habitación',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: preciNocheTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Precio Por Noche',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingrese el precio por noche";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: descripcionTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Descripción ',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingrese la descripción";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: capacidadTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Capacidad ',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingrese la capacidad de la habitación";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: comodidadesTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Comodidades ',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingrese las comodidades";
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          const Text('Disponible:'),
                          Switch(
                            value: isDisponible,
                            onChanged: (value) {
                              setState(() {
                                isDisponible = value;
                              });
                            },
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              setState(() => image = result.files.single.path);
                            }
                          } catch (e) {
                            e.printError();
                          }
                        },
                        child: SizedBox(
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: image != null
                                ? Image.file(File(image!))
                                : Image.asset('assets/images/take_photo.jpg'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            saveHabitacion(context);
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
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

  void saveHabitacion(BuildContext context) async {
    var nrohabitacion = nrohabitextController.text;
    var tipohab = selectedTipoHabitacion;
    var precioNoche = double.tryParse(preciNocheTextController.text) ?? 0.0;
    var descripcion = descripcionTextController.text;
    var capacidad = int.tryParse(capacidadTextController.text) ?? 0;
    var comodidades = comodidadesTextController.text;

    String newHabitacionId = await HabitacionesService().saveHabitacion(
      nrohabitacion,
      tipohab.toString(),
      precioNoche,
      descripcion,
      capacidad,
      isDisponible, // Use isDisponible as boolean
      comodidades,
    );

    setState(() {
      _saving_habitacion = true;
    });
    if (image != null) {
      String? imageUrl = await HabitacionesService()
          .uploapHabitacionCover(image!, newHabitacionId);
      if (imageUrl != null) {
        await HabitacionesService()
            .updateCoverHabitacion(newHabitacionId, imageUrl);
      }
      Navigator.pop(context);
    }
  }
}
