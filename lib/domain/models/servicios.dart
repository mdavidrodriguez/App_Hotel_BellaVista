class ServicioHotel {
  final String id;
  final String nombre;
  final String descripcion;
  final double costo;
  final String tipo;
  final bool estaDisponible;
  final String imagen;
  final int capacidad;

  ServicioHotel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.costo,
    required this.tipo,
    required this.estaDisponible,
    required this.imagen,
    required this.capacidad,
  });

  factory ServicioHotel.desdeDoc(String id, Map<String, dynamic> json) {
    return ServicioHotel(
      id: id,
      nombre: json["nombre"] ?? '',
      descripcion: json["descripcion"] ?? '',
      costo: (json["costo"] as num?)?.toDouble() ?? 0.0,
      tipo: json["tipo"] ?? '',
      estaDisponible: json["estaDisponible"] as bool? ?? false,
      imagen: json["imagenes"] ?? 'assets/images/sin_imagen.jpg',
      capacidad: json["capacidad"] is int
          ? json["capacidad"]
          : json["capacidad"] is String
              ? int.tryParse(json["capacidad"] as String) ?? 0
              : 0,
    );
  }
  toJson() {
    throw UnimplementedError();
  }
}
