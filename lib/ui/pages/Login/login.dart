import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/config/theme/app_theme.dart';
import 'package:hotel_bella_vista/domain/controller/controlleruser.dart';
import 'package:hotel_bella_vista/ui/pages/Login/register.dart';
import 'package:hotel_bella_vista/ui/pages/Login/widgets/button.global.dart';
import 'package:hotel_bella_vista/ui/pages/Login/widgets/social.login.dart';
import 'package:hotel_bella_vista/ui/pages/Login/widgets/text.form.global.dart';

class LoginView extends StatelessWidget {
  final ControlUserAuth _authController = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.040,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(115),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 230,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    obscure: false,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingrese el email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormGlobal(
                    controller: passwordController,
                    text: 'Password',
                    textInputType: TextInputType.text,
                    obscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingrese la contraseña";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonGlobal(onTap: () {
                    if (_formKey.currentState!.validate()) {
                      signIn();
                    }
                  }),
                  const SizedBox(
                    height: 25,
                  ),
                  SocialLogin(
                    onTap: () {
                      ingoogle();
                    },
                  ),
                  const SizedBox(height: 30),
                  const BotonNavigation(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    await _authController.ingresarUser(email, password);

    if (_authController.estadoUser != null) {
      // Obtener el rol del usuario desde Firestore
      String userId = _authController.estadoUser!.user!.uid;
      String? userRole = await _authController.obtenerRolUsuario(userId);

      if (userRole != null) {
        if (userRole == 'admin') {
          Get.snackbar(
            'Inicio de Sesión Exitoso',
            '¡Bienvenido, Admin!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed('/home');
        } else {
          Get.snackbar(
            'Inicio de Sesión Exitoso',
            '¡Bienvenido, Admin!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed('/home_user');
        }
      } else {
        // Si no se pudo obtener el rol, mostrar un mensaje de error
        print('Error al obtener el rol del usuario.');
        // Puedes mostrar un snackbar o un diálogo aquí
      }

      // Limpiar los controladores
      emailController.clear();
      passwordController.clear();
    } else {
      print('Credenciales incorrectas');
      Get.snackbar(
        'Error de Inicio de Sesión',
        'Credenciales incorrectas',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void ingoogle() async {
    try {
      UserCredential userCredential = await _authController.ingresarGoogle();
      print(userCredential);
      String usuarior = userCredential.user!.displayName ?? "";
      Get.snackbar(
        'Inicio de Sesión Exitoso',
        '¡Bienvenido, Admin!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAndToNamed('/home_user');
    } catch (e) {
      print("Error al iniciar sesión con Google: $e");
      // Manejar el error, mostrar un mensaje, etc.
    }
  }
}

class BotonNavigation extends StatelessWidget {
  const BotonNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No tienes cuenta? '),
          InkWell(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ),
                );
              },
              child: Text(
                ' Registrate',
                style: TextStyle(color: GlobalColors.maincolor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
