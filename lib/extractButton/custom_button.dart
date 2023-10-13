import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/config/theme/app_texts.dart';
import 'package:hotel_bella_vista/config/theme/text_styles.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text;
  final Image image;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("haces click");
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          image,
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text, style: TextStyles.udobno),
              const Text(AppTexts.neobxodimo,
                  style: TextStyles.neobxodimoStyle),
            ],
          ),
          const SizedBox(
            width: 150,
          ),
          const Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );
  }
}
