import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotel_bella_vista/data/services/firebase_auth_services.dart';
import 'package:hotel_bella_vista/data/services/peticionperfil.dart';
import 'package:hotel_bella_vista/data/services/user_services.dart';
import 'package:hotel_bella_vista/domain/models/users.dart';

class ControlUserAuth extends GetxController {
  final Rxn<List<UserData>> _servicioFirestore = Rxn<List<UserData>>([]);
  final FirebaseAuthService _authService = FirebaseAuthService();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _response = Rxn();
  final _emailLocal = Rxn();
  final _passwdLocal = Rxn();
  final _mensaje = "".obs;
  final Rxn<String> _nombre = Rxn<String>();
  final Rxn<String> _fotoPerfil = Rxn<String>();
  final Rxn<String> _rol = Rxn<String>();
  final Rxn<String> _email = Rxn<String>();
  String? _uidUsuarioAutenticado;

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

      // guardaLocal();
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

  // Future<void> cargarNombreYFoto() async {
  //   final userId = _usuario.value?.user?.uid;
  //   if (userId != null) {
  //     final userDoc = await FirebaseFirestore.instance
  //         .collection('perfiles')
  //         .doc(userId)
  //         .get();
  //     if (userDoc.exists) {
  //       final data = userDoc.data() as Map<String, dynamic>;
  //       _nombre.value = data['nombre'];
  //       _fotoPerfil.value = data['foto'];
  //     }
  //   }
  // }
  Future<void> cargarNombreYFoto() async {
    final userId = _usuario.value?.user?.uid;
    if (userId != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('perfiles')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        _nombre.value = data['nombre'];
        _email.value = data['correo'];
        _fotoPerfil.value = data['foto'];
        _rol.value = data['rol'];
        _uidUsuarioAutenticado = userId;
      }
    }
  }

  String? get nombre => _nombre.value;
  String? get fotoPerfil => _fotoPerfil.value;
  String? get rol => _rol.value;
  String? get email => _email.value;

  dynamic get passwdLocal => _passwdLocal.value;
  dynamic get emailLocal => _emailLocal.value;
  dynamic get estadoUser => _response.value;
  String get mensajesUser => _mensaje.value;
  String? get uidUsuarioAutenticado => _uidUsuarioAutenticado;

  UserCredential? get userValido => _usuario.value;

  Future<void> cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    _usuario.value = null;
    GetStorage().remove('email');
    GetStorage().remove('passwd');
  }

  // Validar cantidad de administradores


  Future<int> countAdmins() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users') 
        .where('role', isEqualTo: 'admin')
        .get();

    return querySnapshot.docs.length;
  }

  // Future<void> addAdmin(String userId) async {
  //   int adminCount = await countAdmins();

  //   if (adminCount < 3) {
  //     await _firestore.collection('users').doc(userId).set({
  //       'role': 'admin',

  //     });
  //   } else {
  //     // Muestra un mensaje de error porque se alcanzó el límite de administradores
  //     print('No se pueden agregar más administradores.');
  //   }
  // }

  Future<void> consultarUsuario(String uid) async {
    try {
      final listaUsuarios = await Peticiones.listauser(uid);
    } catch (e) {
      print('Error al consultar el usuario: $e');
    }
  }

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
}
