import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/servicios_services.dart';
import 'package:hotel_bella_vista/domain/models/servicios.dart';

class ConsultasServiciosController extends GetxController {
  final Rxn<List<ServicioHotel>> _servicioFirestore =
      Rxn<List<ServicioHotel>>([]);

  Future<void> consultarServicio() async {
    _servicioFirestore.value = await ServiciosServices.listarServicios();
  }

  Future<void> actualizarServicio(String id, Map<String, dynamic> datos) async {
    await ServiciosServices.actualizarServicio(id, datos);
  }

  Future<void> eliminarHabitacion(String id) async {
    await ServiciosServices.eliminarServicio(id);
    _servicioFirestore.value?.removeWhere((servicio) => servicio.id == id);
  }

  List<ServicioHotel>? get listaFinalServicio => _servicioFirestore.value;
}
