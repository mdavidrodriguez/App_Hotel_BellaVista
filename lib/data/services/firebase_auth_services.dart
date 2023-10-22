import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> signupWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("some error");
    }
    return null;
  }

  Future<User?> singInWithAndPassword(String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("some error");
    }
    return null;
  }


 Future<void> storeUserDataInFirestore({
    required String userId,
    required String identificacion,
    required String username,
    required String apellido,
    required String telefono,
    required String email,
  }) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference userCollection = firestore.collection('users');

    try {
      await userCollection.doc(userId).set({
        'identificacion': identificacion,
        'username': username,
        'apellido': apellido,
        'telefono': telefono,
        'email': email,
      });
    } catch (e) {
      print("Error storing user data in Firestore: $e");
    }
  }
}
  
