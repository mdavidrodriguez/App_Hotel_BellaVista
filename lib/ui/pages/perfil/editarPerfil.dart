// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/peticionperfil.dart';
import 'package:hotel_bella_vista/domain/controller/controluser.dart';
import 'package:image_picker/image_picker.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final controlidentificacion = TextEditingController();
  final controlNombre = TextEditingController();
  final controlApellido = TextEditingController();
  final controlCorreo = TextEditingController();
  final controlCelular = TextEditingController();

  final picker = ImagePicker();
  File? _image;
  String? image;

  // Define a variable to store profile data
  Map<String, dynamic>? perfil;

  _galeria() async {
    final image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  _camara() async {
    final image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarInformacionPerfil();
  }

  Future<void> cargarInformacionPerfil() async {
    final cua = Get.find<ControlUserAuth>();
    perfil = await Peticiones.obtenerPerfil(cua.userValido!.user!.uid);
    if (perfil != null) {
      controlidentificacion.text = perfil!['identificacion'] ?? '';
      controlNombre.text = perfil!['nombre'] ?? '';
      controlApellido.text = perfil!['apellido'] ?? '';
      controlCorreo.text = perfil!['email'] ?? '';
      controlCelular.text = perfil!['telefono'] ?? '';

      final imageUrl = perfil!['imagenes'];

      if (imageUrl != null) {
        setState(() {
          image = imageUrl;
        });
      }
    }
  }

  Future<void> _subirImagen() async {
    final cua = Get.find<ControlUserAuth>();

    if (_image != null) {
      var imageUrl = await Peticiones.uploadPerfilCover(
          _image!.path, cua.userValido!.user!.uid);

      var nuevoPerfil = <String, dynamic>{
        'identificacion': controlidentificacion.text,
        'nombre': controlNombre.text,
        'apellido': controlApellido.text,
        'email': controlCorreo.text,
        'telefono': controlCelular.text,
        'imagenes': imageUrl,
      };

      await Peticiones.actualizarcatalogo(
          cua.userValido!.user!.uid, nuevoPerfil);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completar Perfil"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _opcioncamara(context);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 220,
                  width: double.maxFinite,
                  child: const Card(
                    elevation: 5,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                      size: 70,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: controlidentificacion,
                decoration: const InputDecoration(labelText: "Identificacion"),
              ),
              TextField(
                controller: controlNombre,
                decoration: const InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: controlApellido,
                decoration: const InputDecoration(labelText: "Apellido"),
              ),
              TextField(
                controller: controlCorreo,
                decoration: const InputDecoration(
                  labelText: "Correo",
                ),
                enabled: false,
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
                controller: controlCelular,
                decoration: const InputDecoration(labelText: "Telefono"),
              ),
              ElevatedButton(
                child: const Text("Actualizar Perfil"),
                onPressed: () async {
                  await _subirImagen();
                  Get.offAllNamed('/perfil');
                  ControlUserAuth cua = Get.find();
                  cua.consultarServicio();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _opcioncamara(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Imagen de Galería'),
                onTap: () {
                  _galeria();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Capturar Imagen'),
                onTap: () {
                  _camara();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
