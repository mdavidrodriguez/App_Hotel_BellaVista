import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/config/theme/app_theme.dart';

class ButtonRegister extends StatelessWidget {
  final VoidCallback onTap;
  const ButtonRegister({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
            color: GlobalColors.maincolor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
            ]),
        child: const Text(
          'Registrarse',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
