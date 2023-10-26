import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/config/theme/color_styles.dart';
import 'package:hotel_bella_vista/config/theme/text_styles.dart';
import 'package:hotel_bella_vista/ui/pages/widgets/textfield_button.dart';

class TouristCardItemWidget extends StatefulWidget {
  final String title;

  const TouristCardItemWidget({
    super.key,
    required this.title,
  });

  @override
  State<TouristCardItemWidget> createState() => _TouristCardItemWidgetState();
}

class _TouristCardItemWidgetState extends State<TouristCardItemWidget> {
  bool isExpanded = true;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController citizenshipController = TextEditingController();
  TextEditingController passportNumberController = TextEditingController();
  TextEditingController passportValidityPeriodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.bounceIn,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 13, 16, 13),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: TextStyles.makadi),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0x190D72FF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.blue,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: isExpanded ? null : 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  TextFormField1(
                    controller: firstNameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese su nombre";
                      }
                      return null;
                    },
                    labelText: 'Nombre',
                  ),
                  const SizedBox(height: 8),
                  TextFormField1(
                    labelText: 'Apellido',
                    controller: lastNameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese su apellido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField1(
                    labelText: "Fecha de nacimiento",
                    controller: birthDayController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese su fecha de nacimiento";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField1(
                    labelText: "Nacionalidad",
                    controller: citizenshipController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese su nacionalidad";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField1(
                    labelText: "Número de pasaporte",
                    controller: passportNumberController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese su número de pasaporte";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField1(
                    labelText: "Fecha de vencimiento del pasaporte",
                    controller: passportValidityPeriodController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese la fecha de vencimiento del pasaporte";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
