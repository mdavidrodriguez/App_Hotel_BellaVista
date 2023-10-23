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
  final tipohabTextController = TextEditingController();
  final preciNocheTextController = TextEditingController();
  final descripcionTextController = TextEditingController();
  final capacidadTextController = TextEditingController();
  bool isDisponible = false;
  final comodidadesTextController = TextEditingController();
  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: tipohabTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Tipo Habitacion',
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
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
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
                    keyboardType: TextInputType.number, // Accepts int
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
                      // _navigateTakePictureScreen
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
                      saveHabitacion();
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void saveHabitacion() async {
    var nrohabitacion = nrohabitextController.text;
    var tipohab = tipohabTextController.text;
    var precioNoche = double.tryParse(preciNocheTextController.text) ?? 0.0;
    var descripcion = descripcionTextController.text;
    var capacidad = int.tryParse(capacidadTextController.text) ?? 0;
    var comodidades = comodidadesTextController.text;

    String newHabitacionId = await HabitacionesService().saveHabitacion(
      nrohabitacion,
      tipohab,
      precioNoche,
      descripcion,
      capacidad,
      isDisponible, // Use isDisponible as boolean
      comodidades,
    );

    if (image != null) {
      String? imageUrl = await HabitacionesService()
          .uploapHabitacionCover(image!, newHabitacionId);
      if (imageUrl != null) {
        await HabitacionesService()
            .updateCoverHabitacion(newHabitacionId, imageUrl);
      }
    }
  }
}
