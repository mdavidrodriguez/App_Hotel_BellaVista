import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/user_services.dart';
import 'package:hotel_bella_vista/domain/controller/controluser.dart';
import 'package:hotel_bella_vista/ui/pages/perfil/editarPerfil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Userscreen extends StatefulWidget {
  const Userscreen({Key? key}) : super(key: key);

  @override
  UserscreenState createState() => UserscreenState();
}

class UserscreenState extends State<Userscreen> {
  final ControlUserAuth sc = Get.find();
  final ImagePicker _imagePicker = ImagePicker();
  ImageProvider? _image;
  File? _newImageFile;
  final UserService _imageUploadService = UserService();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _newImageFile = File(pickedFile.path);
        _image = FileImage(_newImageFile!);
      });
    }
  }

  Future<void> _saveImage() async {
    if (_newImageFile != null) {
      final imageUrl = await _imageUploadService.uploadUserCover(
        _newImageFile!.path,
        sc.listafinal![0].id,
      );
      if (imageUrl != null) {
        _imageUploadService.updateCoverUser(sc.listafinal![0].id, imageUrl);

        setState(() {
          _newImageFile = null;
          _image = NetworkImage(imageUrl);
          sc.consultarServicio();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    sc.consultarServicio();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi Perfil',
          style: TextStyle(color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 6),
          child: FloatingActionButton(
            child: Icon(
              Icons.arrow_back_outlined,
              color: colors.primary,
              size: 30,
            ),
            onPressed: () {
              Get.offAllNamed('/home');
            },
          ),
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
      ),
      body: Obx(() {
        if (sc.listafinal == null || sc.listafinal!.isEmpty) {
          return const Center(
            child: Text('No hay elementos para mostrar'),
          );
        } else {
          final user = sc.listafinal![0];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 400,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SafeArea(
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text(
                                          'Seleccionar de la galería'),
                                      onTap: () {
                                        _getImage(ImageSource.gallery);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('Tomar una foto'),
                                      onTap: () {
                                        _getImage(ImageSource.camera);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                _image ?? NetworkImage(user.imagen),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.credit_card_outlined, size: 40),
                      title: Text(
                        'CC: ${user.identificacion}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person, size: 40),
                      title: Text(
                        'Nombre: ${user.nombre} ${user.apellido}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email, size: 40),
                      title: Text(
                        'Email: ${user.email}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone, size: 40),
                      title: Text(
                        'Teléfono: ${user.telefono}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Perfil()));
            },
            heroTag: 'editbutton',
            child: const Icon(Icons
                .edit_note_outlined), // Etiqueta única para el segundo botón
          ),
          FloatingActionButton(
            onPressed: _saveImage,
            heroTag: 'saveButton', // Etiqueta única para el primer botón
            child: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
