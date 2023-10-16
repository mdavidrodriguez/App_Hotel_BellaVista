import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/config/theme/app_theme.dart';
import 'package:hotel_bella_vista/ui/pages/Login/register.dart';
import 'package:hotel_bella_vista/ui/pages/Login/widgets/button.global.dart';
import 'package:hotel_bella_vista/ui/pages/Login/widgets/social.login.dart';
import 'package:hotel_bella_vista/ui/pages/Login/widgets/text.form.global.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                  'Login to your Account',
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
                  controller: emailController,
                  text: 'Email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Password input
                TextFormGlobal(
                    controller: passwordController,
                    text: 'Password',
                    textInputType: TextInputType.text,
                    obscure: true),
                const SizedBox(
                  height: 10,
                ),
                const ButtonGlobal(),
                const SizedBox(
                  height: 25,
                ),
                const SocialLogin(),
                const SizedBox(height: 30),
                const BotonNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
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
          const Text('No tienes cuenta? '),
          InkWell(
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
              child: Text(
                ' Sign Up ',
                style: TextStyle(color: GlobalColors.maincolor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
