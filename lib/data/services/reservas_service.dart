import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/controlleruser.dart';

import 'package:hotel_bella_vista/domain/models/reservation.dart';

class ReservasService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  ControlUserAuth cua = Get.find();
  final reserRef = FirebaseFirestore.instance
      .collection('reservas')
      .withConverter(
          fromFirestore: (snapshop, _) =>
              ReservaHotel.desdeDoc(snapshop.id, snapshop.data()!),
          toFirestore: (serv, _) => serv.toJson());

  Future<String> saveReservas(
    String numeroReserva,
    String numeroHabitacion,
    String servicioReserva,
    String numeroPersonas,
    String fechaCheckIn,
    String fechaCheckOut,
    double precioTotal,
  ) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = '';

    if (user != null) {
      // Si el usuario está autenticado con correo electrónico y contraseña
      uid = user.uid;
    } else {
      // Si el usuario está autenticado con Google
      uid = cua.userValido?.user?.uid ?? '';
    }
    var reference = FirebaseFirestore.instance.collection("reservas");
    var result = await reference.add({
      'user': uid,
      'numeroReserva': numeroReserva,
      'numeroHabitacion': numeroHabitacion,
      'numeroPersonas': numeroPersonas,
      'fechaCheckIn': fechaCheckIn,
      'fechaCheckOut': fechaCheckOut,
      'precioTotal': precioTotal,
    });
    return Future.value(result.id);
  }

  static Future<List<ReservaHotel>> listarReservas() async {
    QuerySnapshot querySnapshot = await _db.collection("reservas").get();
    List<ReservaHotel> lista = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      lista.add(ReservaHotel.desdeDoc(doc.id, data));
    }
    return lista;
  }

  static Future<void> actualizarReservas(
      String id, Map<String, dynamic> datos) async {
    await _db.collection("reservas").doc(id).update(datos).catchError((e) {
      print('Error al actualizar habitacion: $e');
    });
  }

  static Future<void> eliminarReservas(String id) async {
    await _db.collection('reservas').doc(id).delete().catchError((e) {});
  }
}
