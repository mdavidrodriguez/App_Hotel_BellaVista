import 'dart:io';

import 'package:flutter/material.dart';

class CamposInputs extends StatelessWidget {
  const CamposInputs({
    super.key,
    required this.capacidadTextController, required this.label, required this.mensajevalidacion, required this.tipocampo,
  });

  final TextEditingController capacidadTextController;
  final String label;
  final String mensajevalidacion;
  final TextInputType tipocampo;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: capacidadTextController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: label,
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType:tipocampo,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return mensajevalidacion;
        }
        return null;
      },
    );
  }
}


class DropdownMenuP extends StatelessWidget {
  final String? value;
  final List<String> options;
  final Function(String?) onChanged;
  final String label;

  const DropdownMenuP({super.key, 
    required this.value,
    required this.options,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: label,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}


class ImageFile extends StatelessWidget {
  const ImageFile({
    super.key,
    required this.image,required this.imageAssets,
  });

  final String? image;
  final String? imageAssets;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: image != null
            ? Image.file(File(image!))
            : Image.asset('$imageAssets'),
      ),
    );
  }
}
class FondoFormulario extends StatelessWidget {
  const FondoFormulario({super.key, 
   required this.urlimage,
  });

  final String urlimage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: AssetImage(urlimage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
