import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/user_services.dart';
import 'package:hotel_bella_vista/domain/models/users.dart';

class UserController extends GetxController {
  final Rxn<List<UserData>> _servicioFirestore = Rxn<List<UserData>>([]);

  Future<void> consultarServicio() async {
    _servicioFirestore.value = await UserService.listarServicios();
  }

  List<UserData>? get listafinal => _servicioFirestore.value;
}
