class HabitacionHotel {
  final String id;
  final String numeroHabitacion;
  final String tipoHabitacion;
  final double precioPorNoche;
  final String descripcion;
  final int capacidad;
  final bool estaDisponible;
  final String imagenes;
  final String comodidades;

  HabitacionHotel({
    required this.id,
    required this.numeroHabitacion,
    required this.tipoHabitacion,
    required this.precioPorNoche,
    required this.descripcion,
    required this.capacidad,
    required this.estaDisponible,
    required this.imagenes,
    required this.comodidades,
  });

  HabitacionHotel.fromJson(String id, Map<String, dynamic> json)
      : id = id,
        numeroHabitacion = json["numeroHabitacion"] as String,
        tipoHabitacion = json["tipoHabitacion"] as String,
        precioPorNoche = (json["precioPorNoche"] as num).toDouble(),
        descripcion = json["descripcion"] as String,
        capacidad = json["capacidad"] is int
            ? json["capacidad"]
            : json["capacidad"] is String
                ? int.tryParse(json["capacidad"] as String) ?? 0
                : 0,
        estaDisponible = json["estaDisponible"] as bool,
        imagenes = json["imagenes"] ?? "assets/images/sin_imagen.jpg",
        comodidades = json["comodidades"] ?? "No hay";

  toJson() {
    throw UnimplementedError();
  }

  factory HabitacionHotel.desdeDoc(String id, Map<String, dynamic> json) {
    return HabitacionHotel(
      id: id,
      numeroHabitacion: json["numeroHabitacion"] ?? '',
      tipoHabitacion: json["tipoHabitacion"] ?? '',
      precioPorNoche: (json["precioPorNoche"] as num?)?.toDouble() ?? 0.0,
      descripcion: json["descripcion"] ?? '',
      capacidad: json["capacidad"] is int
          ? json["capacidad"]
          : json["capacidad"] is String
              ? int.tryParse(json["capacidad"] as String) ?? 0
              : 0,
      estaDisponible: json["estaDisponible"] as bool? ?? false,
      imagenes: json["imagenes"] ?? 'assets/images/sin_imagen.jpg',
      comodidades: json["comodidades"] ?? 'No hay',
    );
  }
}
