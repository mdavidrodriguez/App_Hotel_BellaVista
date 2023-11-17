import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/controlleruser.dart';
import 'package:hotel_bella_vista/domain/controller/reservas_controller.dart';
import 'package:hotel_bella_vista/domain/models/reservation.dart';
import 'package:hotel_bella_vista/ui/pages/Reservation/reservaDetailScreen.dart';

// ignore: must_be_immutable
class ListaReservacionesUser extends StatelessWidget {
  final ConsultasReservasController uc = Get.find();
  ControlUserAuth cua = Get.find();

  ListaReservacionesUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    uc.consultarServicio();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservaciones'),
        centerTitle: true,
      ),
      body: Obx(() {
        final List<ReservaHotel>? reservas = uc.listaFinalReserva;
        if (uc.listaFinalReserva?.isEmpty == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // Filtrar reservas por uid
          final userUid = cua.userValido?.user?.uid;
          final userReservas =
              reservas?.where((reserva) => reserva.uid == userUid).toList();

          return ListView.builder(
            itemCount: userReservas?.length ?? 0,
            itemBuilder: (context, index) {
              final reserva = userReservas![index];
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
