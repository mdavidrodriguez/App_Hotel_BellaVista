import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/models/reservation.dart';

class ReservasService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final reserRef = FirebaseFirestore.instance.collection('reservas').withConverter(
      fromFirestore: (snapshop, _) =>
          ReservaHotel.desdeDoc(snapshop.id, snapshop.data()!),
      toFirestore: (serv, _) => serv.toJson());

  Future<String> saveReservas(
      String nombreHuesped,
      String numeroReserva,
      String fechaCheckIn,
      String fechaCheckOut,
      String tipoHabitacion,
      double precioTotal,
      String metodoPago) async {
    var reference = FirebaseFirestore.instance.collection("reservas");
    var result = await reference.add({
      'nombreHuesped': nombreHuesped,
      'numeroReserva': numeroReserva,
      'fechaCheckIn': fechaCheckIn,
      'fechaCheckOut': fechaCheckOut,
      'tipoHabitacion': tipoHabitacion,
      'precioTotal': precioTotal,
      'metodoPago': metodoPago
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
