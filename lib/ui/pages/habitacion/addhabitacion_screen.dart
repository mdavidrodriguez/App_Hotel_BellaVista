import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/habitacionesService.dart';
import 'package:hotel_bella_vista/domain/controller/habitaciones_controller.dart';
import 'package:hotel_bella_vista/domain/models/habitacion.dart';
import 'package:image_picker/image_picker.dart';

class EditHabitacionScreen extends StatelessWidget {
  const EditHabitacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HabitacionHotel? habitacion = Get.arguments as HabitacionHotel?;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            habitacion != null ? 'Editar Habitación' : 'Agregar Habitación'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: EditHabitacionForm(habitacion: habitacion),
    );
  }
}

class EditHabitacionForm extends StatefulWidget {
  final HabitacionHotel? habitacion;

  const EditHabitacionForm({required this.habitacion, super.key});

  @override
  State<EditHabitacionForm> createState() => _EditHabitacionFormState();
}

class _EditHabitacionFormState extends State<EditHabitacionForm> {
  final nrohabitextController = TextEditingController();
  String? selectedTipoHabitacion;
  final preciNocheTextController = TextEditingController();
  final descripcionTextController = TextEditingController();
  final capacidadTextController = TextEditingController();
  bool isDisponible = false;
  final comodidadesTextController = TextEditingController();
  String? image;

  List<String> tipoHabitacionOptions = [
    'Basica',
    'Premium',
    'VIP',
  ];
  final _formkey = GlobalKey<FormState>();
  bool _saving_habitacion = false;

  @override
  void initState() {
    super.initState();

    if (widget.habitacion != null) {
      nrohabitextController.text = widget.habitacion!.numeroHabitacion;
      selectedTipoHabitacion = widget.habitacion!.tipoHabitacion;
      preciNocheTextController.text =
          widget.habitacion!.precioPorNoche.toString();
      descripcionTextController.text = widget.habitacion!.descripcion;
      capacidadTextController.text = widget.habitacion!.capacidad.toString();
      isDisponible = widget.habitacion!.estaDisponible;
      comodidadesTextController.text = widget.habitacion!.comodidades;
    }
  }

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
                      SizedBox(
                        width: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: image != null
                              ? Image.file(File(image!))
                              : Image.asset('assets/images/camara.jpeg'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          showImagePickerDialog(context);
                        },
                        child: const Text('Seleccionar Imagen'),
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

  Future<void> showImagePickerDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Seleccionar Imagen"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Tomar foto'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        image = pickedFile.path;
                      });
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Seleccionar desde Galería'),
                  onTap: () async {
                    Navigator.pop(context);
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      setState(() {
                        image = result.files.single.path;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void saveHabitacion(BuildContext context) async {
    var nrohabitacion = nrohabitextController.text;
    var tipohab = selectedTipoHabitacion;
    var precioNoche = double.tryParse(preciNocheTextController.text) ?? 0.0;
    var descripcion = descripcionTextController.text;
    var capacidad = int.tryParse(capacidadTextController.text) ?? 0;
    var comodidades = comodidadesTextController.text;

    if (widget.habitacion == null) {
      String newHabitacionId = await HabitacionesService().saveHabitacion(
        nrohabitacion,
        tipohab.toString(),
        precioNoche,
        descripcion,
        capacidad,
        isDisponible,
        comodidades,
      );
      if (image != null) {
        String? imageUrl = await HabitacionesService()
            .uploapHabitacionCover(image!, newHabitacionId);
        if (imageUrl != null) {
          await HabitacionesService()
              .updateCoverHabitacion(newHabitacionId, imageUrl);
          ConsultasHabitacionController uc = Get.find();
          await uc.consultarHabitaciones();
        }
      }
    } else {
      await HabitacionesService.actualizarHabitacion(widget.habitacion!.id, {
        "numeroHabitacion": nrohabitacion,
        "tipoHabitacion": tipohab.toString(),
        "precioPorNoche": precioNoche,
        "descripcion": descripcion,
        "capacidad": capacidad,
        "estaDisponible": isDisponible,
        "comodidades": comodidades,
      });
      if (image != null) {
        String? imageUrl = await HabitacionesService()
            .uploapHabitacionCover(image!, widget.habitacion!.id);
        if (imageUrl != null) {
          await HabitacionesService()
              .updateCoverHabitacion(widget.habitacion!.id, imageUrl);
          ConsultasHabitacionController uc = Get.find();
          await uc.consultarHabitaciones();
        }
      }
    }
    Get.offAndToNamed('/listarHabitaciones');
  }
}
