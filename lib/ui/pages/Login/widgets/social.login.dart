import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_bella_vista/config/theme/app_theme.dart';

class SocialLogin extends StatelessWidget {
  final VoidCallback onTap;

  const SocialLogin({super.key, required this.onTap});

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            'Or sign in with',
            style: TextStyle(
              color: GlobalColors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onTap, // Usa el onTap que se pasa desde el widget padre
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.11,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/google.svg',
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Iniciar con Google',
                        style: TextStyle(
                          color: GlobalColors.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
