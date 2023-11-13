class UserData {
  final String id;
  final String identificacion;
  final String nombre;
  final String apellido;
  final String telefono;
  final String email;
  final String imagen;
  final String role;

  UserData(
      {required this.id,
      required this.identificacion,
      required this.nombre,
      required this.apellido,
      required this.telefono,
      required this.email,
      required this.imagen,
      required this.role});

  factory UserData.fromMap(String id, Map<String, dynamic> map) {
    return UserData(
        id: id,
        identificacion: map['identificacion'] ?? '',
        nombre: map['nombre'] ?? '',
        apellido: map['apellido'] ?? '',
        telefono: map['telefono'] ?? '',
        email: map['email'] ?? '',
        imagen: map['imagenes'] ??
            'https://firebasestorage.googleapis.com/v0/b/hotelbellavista-e9e72.appspot.com/o/servicios%2Foik8H8MQzNbGV7dkPezjpnwi3AC2.png?alt=media&token=6e1ffe0b-be3d-4fd8-9c87-52297d09d4a4',
        role: map['role'] ?? '');
  }
}

// Datos de ejemplo
String id = '2';
Map<String, dynamic> datosAdmin = {
  'identificacion': '987654321',
  'nombre': 'Admin',
  'apellido': 'User',
  'telefono': '555-4321',
  'email': 'admin@example.com',
  'imagen': 'admin_avatar.jpg',
  'role': 'admin'
};

UserData adminUser = UserData.fromMap(id, datosAdmin);
