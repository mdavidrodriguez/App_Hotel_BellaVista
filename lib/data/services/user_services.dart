import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_bella_vista/domain/models/users.dart';

class UserService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static Future<List<UserData>> listarServicios() async {
    QuerySnapshot querySnapshot = await _db.collection("users").get();
    List<UserData> lista = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      lista.add(UserData.fromMap(doc.id, data));
    }
    return lista;
  }
}
