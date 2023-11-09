import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotel_bella_vista/data/services/firebase_auth_services.dart';

class ControlUserAuth extends GetxController {
  final _response = Rxn();
  final _emailLocal = Rxn();
  final _passwdLocal = Rxn();
  final _mensaje = "".obs;
  final Rxn<UserCredential> _usuario = Rxn<UserCredential>();

  Future<void> crearUser(String email, String pass) async {
    _response.value = await FirebaseAuthService.crearRegistroEmail(email, pass);
    _passwdLocal.value = pass;
    print(_response.value);
    await controlUser(_response.value);
  }

  Future<void> ingresarUser(String email, String pass) async {
    _response.value = await FirebaseAuthService.ingresarEmail(email, pass);
    _passwdLocal.value = pass;
    print(_response.value);
    await controlUser(_response.value);
  }

  Future<void> controlUser(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "No Se Completo la Consulta";
    } else if (respuesta == "1" || respuesta == "2") {
      _mensaje.value = "Datos Ingresas Incorrectos";
    } else {
      _mensaje.value = "Proceso Realizado Correctamente";
      _usuario.value = respuesta;

      guardaLocal();
    }
  }

  Future<void> guardaLocal() async {
    GetStorage datosLocal = GetStorage();
    datosLocal.write('email', _usuario.value!.user!.email);
    datosLocal.write('passwd', _passwdLocal.value);
  }

  Future<void> verLocal() async {
    GetStorage datosLocal = GetStorage();
    _emailLocal.value = datosLocal.read('email');
    _passwdLocal.value = datosLocal.read('passwd');
    print(_emailLocal.value);
  }

  dynamic get passwdLocal => _passwdLocal.value;
  dynamic get emailLocal => _emailLocal.value;
  dynamic get estadoUser => _response.value;
  String get mensajesUser => _mensaje.value;
  UserCredential? get userValido => _usuario.value;
}