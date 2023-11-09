import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/config/theme/app_theme.dart';
import 'package:hotel_bella_vista/data/services/firebase_auth_services.dart';
import 'package:hotel_bella_vista/ui/pages/Login/widgets/button.globalRegister.dart';
import 'package:hotel_bella_vista/ui/pages/Login/widgets/text.form.global.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController identificacionController =
      TextEditingController();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    telefonoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
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
                    height: 30,
                  ),
                  Text(
                    'Crear una Cuenta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Campo email
                  TextFormGlobal(
                    controller: identificacionController,
                    text: 'Identificación',
                    obscure: false,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingrese su identificación";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Password input
                  TextFormGlobal(
                    controller: nombreController,
                    text: 'Nombre',
                    textInputType: TextInputType.text,
                    obscure: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingrese su nombre";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  TextFormGlobal(
                    controller: apellidoController,
                    text: 'Apellido',
                    textInputType: TextInputType.text,
                    obscure: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingrese su apellido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormGlobal(
                    controller: telefonoController,
                    text: 'Telefono',
                    textInputType: TextInputType.number,
                    obscure: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingrese su telefono";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    textInputType: TextInputType.emailAddress,
                    obscure: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingrese su email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormGlobal(
                    controller: passwordController,
                    text: 'Contraseña',
                    textInputType: TextInputType.text,
                    obscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingrese su password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonRegister(onTap: () {
                    if (_formkey.currentState!.validate()) {
                      _signUp();
                    }
                  }),
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

  void _signUp() async {
    String identificacion = identificacionController.text;
    String nombre = nombreController.text;
    String apellido = apellidoController.text;
    String telefono = telefonoController.text;
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signupWithEmailAndPassword(email, password);

    if (user != null) {
      await FirebaseAuthService.storeUserDataInFirestore(
        userId: user.uid,
        identificacion: identificacion,
        nombre: nombre,
        apellido: apellido,
        telefono: telefono,
        email: email,
      );

      Navigator.pushNamed(context, "/home");
      identificacionController.clear();
      nombreController.clear();
      apellidoController.clear();
      telefonoController.clear();
      emailController.clear();
      passwordController.clear();
      print("User is successfully created");
    } else {
      print('Some error');
    }
  }
}

class BotonNavigation extends StatelessWidget {
  const BotonNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Ya tienes Cuenta?'),
          InkWell(
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  ' Inicia Sesión ',
                  style: TextStyle(color: GlobalColors.textColor),
                )),
          )
        ],
      ),
    );
  }
}
