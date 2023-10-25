import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/domain/models/servicios.dart';

class ServiciosServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  final servRef = FirebaseFirestore.instance
      .collection('servicios')
      .withConverter(
          fromFirestore: (snapshop, _) =>
              ServicioHotel.desdeDoc(snapshop.id, snapshop.data()!),
          toFirestore: (serv, _) => serv.toJson());

  Future<String> saveServicio(String nombre, String descripcion, double costo,
      String tipo, bool estaDisponible, int capacidad) async {
    var reference = FirebaseFirestore.instance.collection("servicios");
    var result = await reference.add({
      'nombre': nombre,
      'descripcion': descripcion,
      'costo': costo,
      'tipo': tipo,
      'estaDisponible': estaDisponible,
      'capacidad': capacidad,
    });
    return Future.value(result.id);
  }

  Future<String?> uploadServicioCover(
      String imagePath, String newServicioId) async {
    try {
      File image = File(imagePath);
      final ext = image.path.split('.').last.toLowerCase();
      if (ext == 'png' || ext == 'jpg') {
        var uploadTask = await FirebaseStorage.instance
            .ref('servicios/$newServicioId.$ext')
            .putFile(image);
        debugPrint('Subida completada');
        var downloadUrl = await uploadTask.ref.getDownloadURL();
        return downloadUrl;
      } else {
        debugPrint(
            'Formato de imagen no válido. Solo se permiten archivos .png o .jpg.');
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> updateCoverServicio(String newServicio, String imageUrl) async {
    var reference =
        FirebaseFirestore.instance.collection("servicios").doc(newServicio);
    return reference.update({
      'imagenes': imageUrl,
    });
  }

  static Future<List<ServicioHotel>> listarServicios() async {
    QuerySnapshot querySnapshot = await _db.collection("servicios").get();
    List<ServicioHotel> lista = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      lista.add(ServicioHotel.desdeDoc(doc.id, data));
    }
    return lista;
  }

  static Future<void> actualizarServicio(
      String id, Map<String, dynamic> datos) async {
    await _db.collection('servicios').doc(id).update(datos).catchError((e) {
      print('Error al actualizar habitación: $e');
    });
  }

  static Future<void> eliminarServicio(String id) async {
    await _db.collection('servicios').doc(id).delete().catchError((e) {});
  }
}
