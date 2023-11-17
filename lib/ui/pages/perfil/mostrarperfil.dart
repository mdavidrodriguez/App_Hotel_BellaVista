import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/user_services.dart';
import 'package:hotel_bella_vista/domain/controller/user_services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Userscreen extends StatefulWidget {
  const Userscreen({super.key});

  @override
  UserscreenState createState() => UserscreenState();
}

class UserscreenState extends State<Userscreen> {
  final UserController sc = Get.find();
  final ImagePicker _imagePicker = ImagePicker();
  ImageProvider? _image;
  File? _newImageFile;
  final UserService _imageUploadService = UserService();

  Future<void> _getImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

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
          _newImageFile!.path, sc.listafinal![0].id);
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
                        onTap: _getImage,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _saveImage,
        child: const Icon(Icons.save),
      ),
    );
  }
}
