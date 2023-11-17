import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/controlleruser.dart';
import 'package:hotel_bella_vista/domain/controller/reservas_controller.dart';
import 'package:hotel_bella_vista/domain/models/reservation.dart';
import 'package:hotel_bella_vista/ui/pages/Reservation/reservaDetailScreen.dart';

// ignore: must_be_immutable
class ListaReservaciones extends StatelessWidget {
  final ConsultasReservasController uc = Get.find();

  ListaReservaciones({Key? key}) : super(key: key);
  ControlUserAuth cua = Get.find();

  @override
  Widget build(BuildContext context) {
    uc.consultarServicio();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Reservas'),
        centerTitle: true,
      ),
      body: Obx(() {
        final List<ReservaHotel>? reservas = uc.listaFinalReserva;
        if (uc.listaFinalReserva?.isEmpty == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: reservas?.length ?? 0,
            itemBuilder: (context, index) {
              final reserva = reservas![index];
              return SingleChildScrollView(
                child: Card(
                  margin: const EdgeInsets.all(2.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(3.0),
                    onTap: () {
                      _openReservaDetails(context, reserva);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: ReservaInfoWidget(reserva: reserva),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _openReservaDetails(BuildContext context, ReservaHotel reserva) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservaDetailsScreen(reserva: reserva),
      ),
    );
  }
}
