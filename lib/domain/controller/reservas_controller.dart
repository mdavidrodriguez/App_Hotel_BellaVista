import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/reservas_service.dart';
import 'package:hotel_bella_vista/domain/models/reservation.dart';

class ConsultasReservasController extends GetxController {
  final Rxn<List<ReservaHotel>> _servicioFirestore =
      Rxn<List<ReservaHotel>>([]);

  Future<void> consultarServicio() async {
    _servicioFirestore.value = await ReservasService.listarReservas();
  }

  Future<void> actualizarReserva(String id, Map<String, dynamic> datos) async {
    await ReservasService.actualizarReservas(id, datos);
  }

  Future<void> eliminarHabitacion(String id) async {
    await ReservasService.eliminarReservas(id);
    _servicioFirestore.value?.removeWhere((reserva) => reserva.id == id);
  }

  List<ReservaHotel>? get listaFinalReserva => _servicioFirestore.value;
}
