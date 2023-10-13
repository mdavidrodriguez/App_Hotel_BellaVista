// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/config/theme/text_styles.dart';

// ignore: must_be_immutable
class CustomButton1 extends StatelessWidget {
  const CustomButton1({
    Key? key,
    required this.text,
    required this.onTap,
    required TextStyle style,
  }) : super(key: key);
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 343,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xff0D72FF),
        ),
        child: Center(
          child: Text(text, style: TextStyles.kvyboru),
        ),
      ),
    );
  }
}
