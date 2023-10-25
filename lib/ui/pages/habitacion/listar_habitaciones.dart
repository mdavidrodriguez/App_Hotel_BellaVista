import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/habitaciones_controller.dart';

class ListarHabitaciones extends StatelessWidget {
  const ListarHabitaciones({super.key});

  @override
  Widget build(BuildContext context) {
    ConsultasHabitacionController uc = Get.find();
    uc.consultarHabitaciones();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Habitaciones"),
      ),
      body: Obx(() {
        if (uc.listaFinalHabitaciones?.isEmpty == true) {
          return const Center(
            child: Text("No existen habitaciones registradas"),
          );
        } else {
          return ListView.builder(
            itemCount: uc.listaFinalHabitaciones!.length,
            itemBuilder: (context, posicion) {
              return Card(
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/editarhabitacion',
                        arguments: uc.listaFinalHabitaciones![posicion]);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: getImageWidget(
                            uc.listaFinalHabitaciones![posicion].imagenes),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(uc.listaFinalHabitaciones![posicion]
                                  .numeroHabitacion),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(uc.listaFinalHabitaciones![posicion]
                                  .descripcion),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(uc.listaFinalHabitaciones![posicion]
                                  .tipoHabitacion),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(uc
                                  .listaFinalHabitaciones![posicion].capacidad
                                  .toString()),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _showConfirmationDialog(context, uc, posicion);
                        },
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
          Get.toNamed('/editarhabitacion');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  getImageWidget(String imagenes) {
    if (imagenes.startsWith("http")) {
      return Image.network(imagenes, height: 150, width: 150);
    } else {
      return Image.asset(imagenes, height: 150, width: 150);
    }
  }

  void _showConfirmationDialog(
      BuildContext context, ConsultasHabitacionController uc, int posicion) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar eliminación"),
          content: const Text(
              "¿Estás seguro de que deseas eliminar esta habitación?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                uc.eliminarHabitacion(uc.listaFinalHabitaciones![posicion].id);
                Navigator.of(context).pop();
                uc.consultarHabitaciones();
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }
}
