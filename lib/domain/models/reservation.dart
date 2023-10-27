class ReservaHotel {
  final String id;
  String nombreHuesped;
  String numeroReserva;
  String fechaCheckIn;
  String fechaCheckOut;
  String tipoHabitacion;
  double precioTotal;
  String metodoPago;
  String contactoHuesped;
  // int ocupacion;
  // List<HistorialReserva> historialReserva;

  ReservaHotel({
    required this.id,
    required this.nombreHuesped,
    required this.numeroReserva,
    required this.fechaCheckIn,
    required this.fechaCheckOut,
    required this.tipoHabitacion,
    required this.precioTotal,
    required this.metodoPago,
    required this.contactoHuesped,
    // required this.ocupacion,
    // required this.historialReserva,
  });

  factory ReservaHotel.desdeDoc(String id, Map<String, dynamic> json) {
    return ReservaHotel(
        id: id,
        nombreHuesped: json["nombreHuesped"] ?? '',
        numeroReserva: json["numeroReserva"] ?? '',
        fechaCheckIn: json["fechaCheckIn"] ?? '',
        fechaCheckOut: json["fechaCheckOut"] ?? '',
        tipoHabitacion: json["tipoHabitacion"] as String,
        precioTotal: (json["precioTotal"] as num?)?.toDouble() ?? 0.0,
        metodoPago: json["metodoPago"] ?? 'efectivo',
        contactoHuesped: json["contactoHuesped"] ?? 'No tiene');
  }
  toJson() {
    throw UnimplementedError();
  }
}

class HistorialReserva {
  DateTime fecha;
  String accion;

  HistorialReserva({
    required this.fecha,
    required this.accion,
  });
}
