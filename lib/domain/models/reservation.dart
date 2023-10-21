class ReservaHotel {
  int id;
  String nombreHuesped;
  String numeroReserva;
  DateTime fechaCheckIn;
  DateTime fechaCheckOut;
  String tipoHabitacion;
  double precioTotal;
  String metodoPago;
  String contactoHuesped;
  int ocupacion;
  List<HistorialReserva> historialReserva;

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
    required this.ocupacion,
    required this.historialReserva,
  });
}

class HistorialReserva {
  DateTime fecha;
  String accion;

  HistorialReserva({
    required this.fecha,
    required this.accion,
  });
}
