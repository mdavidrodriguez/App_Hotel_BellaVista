import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/habitacionesService.dart';
import 'package:hotel_bella_vista/domain/models/habitacion.dart';

class ConsultasHabitacionController extends GetxController {
  final Rxn<List<HabitacionHotel>> _habitacionFirestore =
      Rxn<List<HabitacionHotel>>([]);

  Future<void> consultarHabitaciones() async {
    _habitacionFirestore.value = await HabitacionesService.listarHabitaciones();
  }

  Future<void> actualizarHabitacion(
      String id, Map<String, dynamic> datos) async {
    await HabitacionesService.actualizarHabitacion(id, datos);
  }

  Future<void> eliminarHabitacion(String id) async {
    await HabitacionesService.eliminarHabitacion(id);
    _habitacionFirestore.value
        ?.removeWhere((habitacion) => habitacion.id == id);
  }

  List<HabitacionHotel>? get listaFinalHabitaciones =>
      _habitacionFirestore.value;
}
