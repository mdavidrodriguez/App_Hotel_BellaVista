import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_bella_vista/domain/models/habitacion.dart';

class HabitacionesService {
  final habiRef = FirebaseFirestore.instance
      .collection('habitaciones')
      .withConverter(
          fromFirestore: (snapshop, _) =>
              HabitacionHotel.fromJson(snapshop.id, snapshop.data()!),
          toFirestore: (habit, _) => habit.toJson());

  Future<List<HabitacionHotel>> getLastHabitaciones() async {
    var resultado = await habiRef.limit(2).get().then((value) => value);
    List<HabitacionHotel> habitaciones = [];
    for (var doc in resultado.docs) {
      habitaciones.add(doc.data());
    }
    return Future.value(habitaciones);
  }

  Future<HabitacionHotel> getHabitacion(String habId) async {
    var resultado = await habiRef.doc(habId).get().then((value) => value);
    if (resultado.exists) {
      return Future.value(resultado.data());
    }
    throw const HttpException('habitacion not found');
  }

  void saveHabitacion(
      String nrohabitacion,
      String tipoHabitacion,
      double precioNoche,
      String descripcion,
      int capacidad,
      bool disponible,
      String comodidades) async {
    var reference = FirebaseFirestore.instance.collection("habitaciones");
    var result = await reference.add({
      'numeroHabitacion': nrohabitacion,
      'tipoHabitacion': tipoHabitacion,
      'precioPorNoche': precioNoche,
      'descripcion': descripcion,
      'capacidad': capacidad,
      'estaDisponible': disponible,
      'comodidades': comodidades
    });
    return Future.value(result.id);
}

}
