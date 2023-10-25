import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/domain/models/servicios.dart';

class ServicioDetailsScreen extends StatelessWidget {
  final ServicioHotel servicio;

  const ServicioDetailsScreen({super.key, required this.servicio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle Habitación'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ServicioCoverWidget(coverUrl: servicio.imagen),
            ServicioInfoWidget(
                tipoServicio: "Tipo de servicio: ${servicio.tipo}",
                capacidad: "Capacidad: ${servicio.capacidad.toString()}",
                costo: "Precio: ${servicio.costo.toString()}",
                nombre: "Nombre Servicio: ${servicio.nombre}",
                descripcion: "Descripción: ${servicio.descripcion}"),
          ],
        ),
      ),
    );
  }
}

class ServicioCoverWidget extends StatelessWidget {
  final String coverUrl;
  const ServicioCoverWidget({super.key, required this.coverUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      width: 400,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10)
      ]),
      child: getImageWidget(coverUrl),
    );
  }

  getImageWidget(String imagenes) {
    if (imagenes.startsWith("http")) {
      return Image.network(imagenes, height: 150, width: 150);
    } else {
      return Image.asset(imagenes, height: 150, width: 150);
    }
  }
}

class ServicioInfoWidget extends StatelessWidget {
  final String tipoServicio;
  final String capacidad;
  final String costo;
  final String nombre;
  final String descripcion;

  const ServicioInfoWidget({
    Key? key,
    required this.tipoServicio,
    required this.capacidad,
    required this.costo,
    required this.nombre,
    required this.descripcion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text(
            tipoServicio,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            capacidad,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            "Costo por servicio: \$$costo",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            nombre,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            descripcion,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String imagen;

  const ImageWidget({
    Key? key,
    required this.imagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagen.startsWith("http")) {
      return Image.network(imagen, height: 150, width: 150);
    } else {
      return Image.asset(imagen, height: 150, width: 150);
    }
  }
}
