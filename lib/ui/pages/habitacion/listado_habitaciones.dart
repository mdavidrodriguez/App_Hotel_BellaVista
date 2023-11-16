import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/habitaciones_controller.dart';
import 'package:hotel_bella_vista/domain/models/habitacion.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/detalle_habitacion_screen.dart';
import 'package:hotel_bella_vista/ui/pages/home/itemDetalleHabitacion.dart';

class ListaHabitaciones extends StatelessWidget {
  const ListaHabitaciones({super.key});

  @override
  Widget build(BuildContext context) {
    ConsultasHabitacionController uc = Get.find();
    uc.consultarHabitaciones();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Habitaciones',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final List<HabitacionHotel>? habitaciones =
                  uc.listaFinalHabitaciones;
              if (uc.listaFinalHabitaciones?.isEmpty == true) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: habitaciones?.length ?? 0,
                  itemBuilder: (context, index) {
                    final habitacion = habitaciones![index];
                    return Card(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.0),
                        onTap: () {
                          _openHabitacionDetails(context, habitacion);
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: getImageWidget(habitacion.imagenes),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ItemDetallesHabitacion(
                                  habitacion: habitacion),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  void _openHabitacionDetails(
      BuildContext context, HabitacionHotel habitacion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HabitacionDetailsScreen(habitacion: habitacion),
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
}
