<<<<<<< HEAD
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
=======
import 'package:cloud_firestore/cloud_firestore.dart';
>>>>>>> d5980e2 (habitaciones,servicios)
import 'package:hotel_bella_vista/domain/models/users.dart';

class UserService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
<<<<<<< HEAD

  static Future<List<UserData>> listarServiciosPorUserEmail(String userEmail) async {
    QuerySnapshot querySnapshot =
        await _db.collection("users").where("email", isEqualTo: userEmail).get();
    List<UserData> lista = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      lista.add(UserData.fromMap(doc.id, data));
    }
    return lista;
  }

  Future<String?> uploadUserCover(
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
   Future<void> updateCoverUser(String newServicio, String imageUrl) async {
    var reference =
        FirebaseFirestore.instance.collection("users").doc(newServicio);
    return reference.update({
      'imagenes': imageUrl,
    });
  }

  static Future<List<UserData>> listarUsuarios() async {
=======
  static Future<List<UserData>> listarServicios() async {
>>>>>>> d5980e2 (habitaciones,servicios)
    QuerySnapshot querySnapshot = await _db.collection("users").get();
    List<UserData> lista = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      lista.add(UserData.fromMap(doc.id, data));
    }
    return lista;
  }
<<<<<<< HEAD


=======
>>>>>>> d5980e2 (habitaciones,servicios)
}
