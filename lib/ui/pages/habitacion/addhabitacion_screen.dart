import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/habitacionesService.dart';
import 'package:hotel_bella_vista/domain/controller/habitaciones_controller.dart';
import 'package:hotel_bella_vista/domain/models/habitacion.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/inputs_campos.dart';

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
  bool savingHabitacion = false;

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
    if (savingHabitacion) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Stack(
          children: [
           const FondoFormulario(urlimage: 'assets/images/fondo.jpeg'),
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CamposInputs(
                          capacidadTextController: nrohabitextController,
                          label: 'Numero de habitación',
                          mensajevalidacion:
                              'Por favor ingrese el Nro de habitación',
                          tipocampo: TextInputType.number),
                      const SizedBox(height: 10),
                      DropdownMenuP(
                        value: selectedTipoHabitacion,
                        options: tipoHabitacionOptions,
                        onChanged: (newValue) {
                          setState(() {
                            selectedTipoHabitacion = newValue;
                          });
                        },
                        label: 'Tipo de Habitación',
                      ),
                      const SizedBox(height: 10),
                      CamposInputs(
                          capacidadTextController: preciNocheTextController,
                          label: 'Precio por Noche',
                          mensajevalidacion:
                              'Por favor ingrese el precio por noche',
                          tipocampo: const TextInputType.numberWithOptions(
                              decimal: true)),
                      const SizedBox(height: 10),
                      CamposInputs(
                          capacidadTextController: descripcionTextController,
                          label: 'Descripción',
                          mensajevalidacion: 'Por favor ingrese la descripción',
                          tipocampo: TextInputType.text),
                      const SizedBox(height: 10),
                      CamposInputs(
                          capacidadTextController: capacidadTextController,
                          label: 'Capacidad',
                          mensajevalidacion: 'Por favor ingrese la capacidad',
                          tipocampo: TextInputType.number),
                      const SizedBox(height: 10),
                      CamposInputs(
                          capacidadTextController: comodidadesTextController,
                          label: 'Comodidades',
                          mensajevalidacion:
                              'Por favor ingrese las comodidades de la habitación',
                          tipocampo: TextInputType.text),
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
                        child: ImageFile(image: image,imageAssets: 'assets/images/take_photo.jpg',)
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
