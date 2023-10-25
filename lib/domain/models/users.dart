class UserData {
  final String id;
  final String identificacion;
  final String nombre;
  final String apellido;
  final String telefono;
  final String email;
  final String imagen;


  UserData({
    required this.id,
    required this.identificacion,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.email,
    required this.imagen
  });

  factory UserData.fromMap(String id, Map<String, dynamic> map) {
    return UserData(
      id: id,
      identificacion: map['identificacion'] ?? '',
      nombre: map['nombre'] ?? '',
      apellido: map['apellido'] ?? '',
      telefono: map['telefono'] ?? '',
      email: map['email'] ?? '',
      imagen: map['imagenes'] ?? '',
    );
  }
}
