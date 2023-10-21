import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/config/theme/app_texts.dart';
import 'package:hotel_bella_vista/config/theme/color_styles.dart';
import 'package:hotel_bella_vista/config/theme/text_styles.dart';
import 'package:hotel_bella_vista/widgets/corusel.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String ratingName = "5 Stars";
  String name = "Hotel Bella Vista";
  String address = "Cra 24 ";
  double minimalPrice = 100.000;
  String priceForIt = "Starting from";
  String description = "Comodidad";

  final TextStyle kvyboruStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          AppTexts.otel,
          style: TextStyles.otelStyle,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VistaImages(
                  ratingName: ratingName,
                  name: name,
                  address: address,
                  minimalPrice: minimalPrice,
                  priceForIt: priceForIt),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Elige una Habitacion",
                      style: kvyboruStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                      icon: const Icon(Icons.login),
                      label: const Text(
                        'Iniciar Sesion',
                      ))
                ]),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.room_service), label: 'Servicios'),
          BottomNavigationBarItem(
              icon: Icon(Icons.meeting_room), label: 'Habitaciones'),
        ],
        onTap: (int index) {
          if (index == 0) {
            Get.toNamed('/home');
          } else if (index == 1) {
            print('Servicios');
            //  Get.toNamed('/panel');
          } else if (index == 2) {
            Get.toNamed('/panel');
          }
        },
      ),
    );
  }
}

class VistaImages extends StatelessWidget {
  const VistaImages({
    super.key,
    required this.ratingName,
    required this.name,
    required this.address,
    required this.minimalPrice,
    required this.priceForIt,
  });

  final String ratingName;
  final String name;
  final String address;
  final double minimalPrice;
  final String priceForIt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: CoruselWidget(
              urls: [
                "https://www.atorus.ru/sites/default/files/upload/image/News/56149/Club_Priv%C3%A9_by_Belek_Club_House.jpg",
                "https://deluxe.voyage/useruploads/articles/The_Makadi_Spa_Hotel_02.jpg",
                "https://deluxe.voyage/useruploads/articles/article_1eb0a64d00.jpg"
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 149,
                    height: 29,
                    decoration: ShapeDecoration(
                      color: AppColors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.yellow1),
                        const SizedBox(width: 2),
                        Text(
                          ratingName,
                          style: TextStyles.prevosxodnoStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyles.makadi,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(address, style: TextStyles.egipet),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("$minimalPrice COP", style: TextStyles.sifraText),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(priceForIt, style: TextStyles.turStyle),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
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
