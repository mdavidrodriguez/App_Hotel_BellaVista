import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/servicios_controller.dart';
import 'package:hotel_bella_vista/domain/models/servicios.dart';
import 'package:hotel_bella_vista/ui/pages/servicios/detalle_servicio.dart';

class ListarServicios extends StatelessWidget {
  const ListarServicios({super.key});

  @override
  Widget build(BuildContext context) {
    ConsultasServiciosController sc = Get.find();
    sc.consultarServicio();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Servicios"),
        centerTitle: true,
      ),
      body: Obx(() {
        final List<ServicioHotel>? _servicios = sc.listaFinalServicio;
        if (sc.listaFinalServicio?.isEmpty == true) {
          return const Center(
            child: Text("No existen servicios registrados"),
          );
        } else {
          return ListView.builder(
            itemCount: sc.listaFinalServicio!.length,
            itemBuilder: (context, posicion) {
              final servicio = _servicios![posicion];

              return Card(
                child: InkWell(
                  onTap: () {
                    _openHabitacionDetails(context, servicio);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: getImageWidget(
                            sc.listaFinalServicio![posicion].imagen),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Text(sc.listaFinalServicio![posicion].nombre),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  sc.listaFinalServicio![posicion].descripcion),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Text(sc.listaFinalServicio![posicion].tipo),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(sc.listaFinalServicio![posicion].costo
                                  .toStringAsFixed(2)),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit_note_outlined,
                              size: 30,
                              color: Colors.indigo,
                            ),
                            onPressed: () {
                              Get.toNamed('/editarservicio',
                                  arguments: sc.listaFinalServicio![posicion]);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              size: 30,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _showConfirmationDialog(context, sc, posicion);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/editarservicio');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  getImageWidget(String imagen) {
    if (imagen.startsWith("http")) {
      return Image.network(imagen, height: 150, width: 150);
    } else {
      return Image.asset(imagen, height: 150, width: 150);
    }
  }

  void _showConfirmationDialog(
      BuildContext context, ConsultasServiciosController sc, int posicion) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar eliminación"),
          content:
              const Text("¿Estás seguro de que deseas eliminar este servicio?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                sc.eliminarHabitacion(sc.listaFinalServicio![posicion].id);
                Navigator.of(context).pop();
                sc.consultarServicio();
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }

  void _openHabitacionDetails(BuildContext context, servicio) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServicioDetailsScreen(servicio: servicio),
      ),
    );
  }
}
