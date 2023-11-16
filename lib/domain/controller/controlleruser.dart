import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_bella_vista/data/services/firebase_auth_services.dart';

class ControlUserAuth extends GetxController {
  final _response = Rxn();
  final _emailLocal = Rxn();
  final _passwdLocal = Rxn();
  final _mensaje = "".obs;
  final Rxn<UserCredential> _usuario = Rxn<UserCredential>();
  final Rxn<String> _rolUsuario = Rxn<String>();

  Future<void> crearUser(String email, String pass) async {
    try {
      _response.value = await FirebaseAuthService.crearRegistroEmail(email, pass);
      _passwdLocal.value = pass;
      print(_response.value);
      await controlUser(_response.value);
    } catch (e) {
      print("Error creating user: $e");
      _mensaje.value = "Error creating user: $e";
    }
  }

  Future<void> ingresarUser(String email, String pass) async {
    try {
      _response.value = await FirebaseAuthService.ingresarEmail(email, pass);
      _passwdLocal.value = pass;
      print(_response.value);
      await controlUser(_response.value);
    } catch (e) {
      print("Error signing in: $e");
      _mensaje.value = "Error signing in: $e";
    }
  }

  Future<void> controlUser(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "No Se Completo la Consulta";
    } else if (respuesta == "1" || respuesta == "2") {
      _mensaje.value = "Datos Ingresados Incorrectos";
    } else {
      _mensaje.value = "Proceso Realizado Correctamente";
      _usuario.value = respuesta;

      // Guarda localmente y obtiene el rol del usuario
      await guardaLocal();
      await obtenerRolUsuario(_usuario.value!.user!.uid);
    }
  }

  Future<void> guardaLocal() async {
    GetStorage datosLocal = GetStorage();
    datosLocal.write('email', _usuario.value!.user!.email);
    datosLocal.write('passwd', _passwdLocal.value);
  }

 Future<String?> obtenerRolUsuario(String userId) async {
    try {
      String? rol = await FirebaseAuthService().getUserRoleFromFirestore(userId);
      return rol;
    } catch (e) {
      print('Error al obtener el rol del usuario: $e');
      return null;
    }
  }


  // ... (otras funciones)

  Future<void> verLocal() async {
    GetStorage datosLocal = GetStorage();
    _emailLocal.value = datosLocal.read('email');
    _passwdLocal.value = datosLocal.read('passwd');
    print(_emailLocal.value);
  }

  Future<UserCredential> ingresarGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // Manejar el caso en el que el usuario canceló el proceso de inicio de sesión con Google
      throw Exception("Inicio de sesión con Google cancelado por el usuario");
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  dynamic get passwdLocal => _passwdLocal.value;
  dynamic get emailLocal => _emailLocal.value;
  dynamic get estadoUser => _response.value;
  String get mensajesUser => _mensaje.value;
  UserCredential? get userValido => _usuario.value;
  String? get rolUsuario => _rolUsuario.value;
}
