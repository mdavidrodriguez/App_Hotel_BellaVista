import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/servicios_controller.dart';
import 'package:hotel_bella_vista/domain/models/servicios.dart';
import 'package:hotel_bella_vista/ui/pages/servicios/detalle_servicio.dart';

class ListadoServicios extends StatelessWidget {
  const ListadoServicios({super.key});

  @override
  Widget build(BuildContext context) {
    ConsultasServiciosController sc = Get.find();
    sc.consultarServicio();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de Servicios"),
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
                                  .toString()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }

  getImageWidget(String imagen) {
    if (imagen.startsWith("http")) {
      return Image.network(imagen, height: 150, width: 150);
    } else {
      return Image.asset(imagen, height: 150, width: 150);
    }
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
