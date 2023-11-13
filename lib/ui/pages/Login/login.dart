import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/config/theme/app_theme.dart';
import 'package:hotel_bella_vista/data/services/firebase_auth_services.dart';
import 'package:hotel_bella_vista/domain/controller/controluser.dart';
import 'package:hotel_bella_vista/ui/pages/Login/register.dart';
import 'package:hotel_bella_vista/ui/pages/Login/widgets/button.global.dart';
import 'package:hotel_bella_vista/ui/pages/Login/widgets/social.login.dart';
import 'package:hotel_bella_vista/ui/pages/Login/widgets/text.form.global.dart';
import 'package:hotel_bella_vista/ui/pages/home/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  var usuarior;
  final _formkey = GlobalKey<FormState>();

  void ingoogle() {
    FirebaseAuthService().ingresarGoogle().then((user) {
      setState(() {
        print(user);
        usuarior = user.user!.displayName;

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    const HomeView(title: 'Logueado')));
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ControlUserAuth cua = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formkey,
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
                    if (_formkey.currentState!.validate()) {
                      cua.ingresarUser(
                          emailController.text, passwordController.text).then((value) {
                      if (cua.userValido == null) {
                        Get.snackbar(
                          'Error',
                          'Email o clave incorrecta',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          borderRadius: 10,
                          margin: const EdgeInsets.all(10),
                          duration: const Duration(seconds: 3),
                          isDismissible: true,
                          dismissDirection: DismissDirection.vertical,
                          forwardAnimationCurve: Curves.easeOutBack,
                          reverseAnimationCurve: Curves.easeInBack,
                        );
                      } else {
                        // final ControlUserAuth cua = Get.find();
                        // // final HabitacionController hc = Get.find();
                        
                        // if (cua.rol == 'Admin') {
                        //   // hc.consultarHabitaciones(cua.userValido?.user?.uid);
                        // } else {
                        //   // hc.consultarHabitacionesgenerales();
                        // }
                        Get.offAllNamed('/home');
                      }
                    });
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

  // void sigIn() async {
  //   String email = emailController.text;
  //   String password = passwordController.text;

  //   User? user = await _auth.singInWithAndPassword(email, password);

  //   if (user != null) {
  //     // ignore: use_build_context_synchronously
  //     Navigator.pushNamed(context, "/home");
  //     print("User is signip");
  //     emailController.clear();
  //     passwordController.clear();
  //   } else {
  //     print('Some error');
  //   }
  // }
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
          const Text('No tienes cuenta? '),
          InkWell(
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Register()));
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
