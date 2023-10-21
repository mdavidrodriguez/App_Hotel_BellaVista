class HabitacionHotel {
  final int id;
  final String numeroHabitacion;
  final String tipoHabitacion;
  final double precioPorNoche;
  final String descripcion;
  final int capacidad;
  final bool estaDisponible;
  final List<String> imagenes;
  final List<String> comodidades;

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
}
