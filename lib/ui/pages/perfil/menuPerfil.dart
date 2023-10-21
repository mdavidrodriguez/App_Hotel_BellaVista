import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _nombreCliente;
  late String _correoCliente;
  late String _telefonoCliente;
  File? _imagenCliente;

  @override
  void initState() {
    super.initState();
    _nombreCliente = "Nombre del Cliente"; 
    _correoCliente = "correo@cliente.com"; 
    _telefonoCliente = "123-456-7890";
  }

  // Método para seleccionar una imagen desde la galería.
  Future<void> _seleccionarImagen() async {
    final pickedFile =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagenCliente = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Cliente'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Widget para mostrar la imagen del cliente
            GestureDetector(
              onTap: _seleccionarImagen,
              child: _imagenCliente == null
                  ? const Icon(Icons.add_a_photo, size: 100)
                  : Image.file(_imagenCliente!, width: 100, height: 100),
            ),
            const Text('Toque para seleccionar una imagen'),
            const SizedBox(height: 20),
            Text('Nombre: $_nombreCliente'),
            Text('Correo: $_correoCliente'),
            Text('Teléfono: $_telefonoCliente'),
          ],
        ),
      ),
    );
  }
}
