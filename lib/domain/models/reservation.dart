class ReservaHotel {
  final String id;
  String numeroReserva;
  String numeroHabitacion;
  String servicios;
  String numeroPersonas;
  String fechaCheckIn;
  String fechaCheckOut;
  double precioTotal;
  String uid;

  // int ocupacion;
  // List<HistorialReserva> historialReserva;

  ReservaHotel(
      {required this.id,
      required this.numeroReserva,
      required this.numeroHabitacion,
      required this.servicios,
      required this.numeroPersonas,
      required this.fechaCheckIn,
      required this.fechaCheckOut,
      required this.precioTotal,
      required this.uid
      // required this.ocupacion,
      // required this.historialReserva,
      });

  factory ReservaHotel.desdeDoc(String id, Map<String, dynamic> json) {
    return ReservaHotel(
      id: id,
      numeroReserva: json["numeroReserva"] ?? 0,
      numeroHabitacion: json["numeroHabitacion"] ?? 'No hay habitacion',
      servicios: json["servicios"] ?? 'No hay servicios',
      numeroPersonas: json["numeroPersonas"] ?? 1,
      fechaCheckIn: json["fechaCheckIn"] ?? '',
      fechaCheckOut: json["fechaCheckOut"] ?? '',
      precioTotal: (json["precioTotal"] as num?)?.toDouble() ?? 0.0,
      uid: json["user"] ?? '',
    );
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
