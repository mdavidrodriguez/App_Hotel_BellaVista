import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<dynamic> crearRegistroEmail(dynamic email, dynamic pass) async {
    try {
      UserCredential usuario = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);

      await storeUserDataInFirestore(
          userId: usuario.user!.uid,
          identificacion: '',
          nombre: '',
          apellido: '',
          telefono: '',
          email: email,
          role: '');

      return usuario;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Contraseña Debil');
        return '1';
      } else if (e.code == 'email-already-in-use') {
        print('Correo ya Existe');
        return '2';
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> ingresarEmail(dynamic email, dynamic pass) async {
    try {
      UserCredential usuario =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      return usuario;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Correo no encontrado');
        return '1';
      } else if (e.code == 'wrong-password') {
        print('Password incorrecto');
        return '2';
      }
    }
  }

  Future<UserCredential> ingresarGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
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


Future<String?> getUserRoleFromFirestore(String userId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DocumentReference userDocRef = firestore.collection('users').doc(userId);

  try {
    final DocumentSnapshot userDoc = await userDocRef.get();
    if (userDoc.exists) {
      final userData = userDoc.data() as Map<String, dynamic>;
      final String? userRole = userData['role'];
      return userRole;
    } else {
      return null; 
    }
  } catch (e) {
    print('Error al obtener el rol del usuario desde Firestore: $e');
    return null;
  }
}

  Future<User?> getCurrentUser() {
    return auth.authStateChanges().first;
  }


  static Future<void> storeUserDataInFirestore({
    required String userId,
    required String identificacion,
    required String nombre,
    required String apellido,
    required String telefono,
    required String email,
    required String role,
  }) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference userCollection = firestore.collection('users');

    try {
      await userCollection.doc(userId).set({
        'identificacion': identificacion,
        'nombre': nombre,
        'apellido': apellido,
        'telefono': telefono,
        'email': email,
        'role': role
      });
    } catch (e) {
      print("Error storing user data in Firestore: $e");
    }
  }
}
