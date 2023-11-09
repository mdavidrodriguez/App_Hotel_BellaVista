import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/servicios_services.dart';
import 'package:hotel_bella_vista/domain/controller/servicios_controller.dart';
import 'package:hotel_bella_vista/domain/models/servicios.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/inputs_campos.dart';

class EditServicioScreen extends StatelessWidget {
  const EditServicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ServicioHotel? servicio = Get.arguments as ServicioHotel?;
    return Scaffold(
      appBar: AppBar(
        title: Text(servicio != null ? 'Editar Servicio' : 'Agregar Servicio'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: EditServicioForm(servicio: servicio),
    );
  }
}

class EditServicioForm extends StatefulWidget {
  final ServicioHotel? servicio;

  const EditServicioForm({super.key, this.servicio});

  @override
  State<EditServicioForm> createState() => _EditServicioFormState();
}

class _EditServicioFormState extends State<EditServicioForm> {
  final nombreTextController = TextEditingController();
  final descripcionTextController = TextEditingController();
  final costoTextController = TextEditingController();
  final tipoTextController = TextEditingController();
  final capacidadTextController = TextEditingController();
  bool isDisponible = false;
  String? image;

  final _formKey = GlobalKey<FormState>();
  bool savingServicio = false;

  @override
  void initState() {
    super.initState();

    if (widget.servicio != null) {
      nombreTextController.text = widget.servicio!.nombre;
      descripcionTextController.text = widget.servicio!.descripcion;
      costoTextController.text = widget.servicio!.costo.toString();
      tipoTextController.text = widget.servicio!.tipo;
      capacidadTextController.text = widget.servicio!.capacidad.toString();
      isDisponible = widget.servicio!.estaDisponible;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (savingServicio) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Form(
        key: _formKey,
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
                          capacidadTextController: nombreTextController,
                          label: 'Nombre del Servicio',
                          mensajevalidacion:
                              'Por favor ingrese el nombre del servicio',
                          tipocampo: TextInputType.text),
                      const SizedBox(height: 10),
                      CamposInputs(
                          capacidadTextController: descripcionTextController,
                          label: 'Descripción',
                          mensajevalidacion:
                              'Por favor ingrese la descripción del servicio',
                          tipocampo: TextInputType.text),
                      const SizedBox(height: 10),
                      CamposInputs(
                          capacidadTextController: costoTextController,
                          label: 'Costo del servicio',
                          mensajevalidacion:
                              'Por favor ingrese el costo del servicio',
                          tipocampo: const TextInputType.numberWithOptions(
                              decimal: true)),
                      const SizedBox(height: 10),
                      CamposInputs(
                          capacidadTextController: tipoTextController,
                          label: 'Tipo de servicio',
                          mensajevalidacion:
                              'Por favor ingrese el tipo de servicio',
                          tipocampo: TextInputType.text),
                      const SizedBox(height: 10),
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
                      const SizedBox(
                        height: 10,
                      ),
                      CamposInputs(
                          capacidadTextController: capacidadTextController,
                          label: 'Capacidad',
                          mensajevalidacion:
                              'Por favor ingrese la cantidad disponible del servicio',
                          tipocampo: TextInputType.number),
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
                        child: ImageFile(
                            image: image,
                            imageAssets: 'assets/images/camara.jpeg'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            saveServicio(context);
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

  void saveServicio(BuildContext context) async {
    var nombre = nombreTextController.text;
    var descripcion = descripcionTextController.text;
    var costo = double.tryParse(costoTextController.text) ?? 0.0;
    var tipo = tipoTextController.text;
    var capacidad = int.tryParse(capacidadTextController.text) ?? 0;

    if (widget.servicio == null) {
      String newServicioId = await ServiciosServices().saveServicio(
          nombre, descripcion, costo, tipo, isDisponible, capacidad);
      if (image != null) {
        String? imageUrl = await ServiciosServices()
            .uploadServicioCover(image!, newServicioId);
        if (imageUrl != null) {
          await ServiciosServices()
              .updateCoverServicio(newServicioId, imageUrl);
          ConsultasServiciosController sc = Get.find();
          await sc.consultarServicio();
        }
      }
    } else {
      await ServiciosServices.actualizarServicio(widget.servicio!.id, {
        "nombre": nombre,
        "descripcion": descripcion,
        "costo": costo,
        "tipo": tipo,
        "estaDisponible": isDisponible,
        "capacidad": capacidad
      });
      if (image != null) {
        String? imageUrl = await ServiciosServices()
            .uploadServicioCover(image!, widget.servicio!.id);
        if (imageUrl != null) {
          await ServiciosServices()
              .updateCoverServicio(widget.servicio!.id, imageUrl);
          ConsultasServiciosController sc = Get.find();
          await sc.consultarServicio();
        }
      }
    }
    Get.toNamed('/listarservicios');
  }
}
