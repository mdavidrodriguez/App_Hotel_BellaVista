import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:hotel_bella_vista/data/services/firebase_auth_services.dart';
=======
>>>>>>> d5980e2 (habitaciones,servicios)
import 'package:hotel_bella_vista/data/services/user_services.dart';
import 'package:hotel_bella_vista/domain/models/users.dart';

class UserController extends GetxController {
  final Rxn<List<UserData>> _servicioFirestore = Rxn<List<UserData>>([]);
<<<<<<< HEAD
  final FirebaseAuthService _authService = FirebaseAuthService();

   Future<void> consultarUsuarios() async {
    _servicioFirestore.value = await UserService.listarUsuarios();
  }

  Future<void> consultarServicio() async {
    final user = await _authService.getCurrentUser();

    if (user != null) {
      final userEmail = user.email;
      _servicioFirestore.value =
          await UserService.listarServiciosPorUserEmail(userEmail!);
    } else {}
  }

  List<UserData>? get listafinal => _servicioFirestore.value;

=======

  Future<void> consultarServicio() async {
    _servicioFirestore.value = await UserService.listarServicios();
  }

  List<UserData>? get listafinal => _servicioFirestore.value;
>>>>>>> d5980e2 (habitaciones,servicios)
}
