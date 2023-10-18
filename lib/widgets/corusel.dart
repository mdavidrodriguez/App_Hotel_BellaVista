import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/config/theme/color_styles.dart';

class CoruselWidget extends StatefulWidget {
  final List<String> urls;

  const CoruselWidget({super.key, required this.urls});

  @override
  State<CoruselWidget> createState() => _CoruselWidgetState();
}

class _CoruselWidgetState extends State<CoruselWidget> {
  List<String> images = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    images = widget.urls;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: double.infinity,
          height: 257,
          child: PageView.builder(
            itemCount: images.length,
            controller: PageController(
              initialPage: 0,
              viewportFraction: 1,
            ),
            physics: const BouncingScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemBuilder: (context, index) => CachedNetworkImage(
              placeholder: (context, url) => const SizedBox(
                width: double.infinity,
                height: 257,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blue,
                  ),
                ),
              ),
              imageUrl: images[index],
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/image.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              imageBuilder: (context, imageProvider) => Container(
                width: double.infinity,
                height: 257,
                margin: index + 1 < images.length
                    ? const EdgeInsets.symmetric(horizontal: 5)
                    : null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 17,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      for (int i = 0; i < images.length; i++)
                        Container(
                          width: 7,
                          height: 7,
                          margin: i + 1 < images.length
                              ? const EdgeInsets.only(right: 5)
                              : null,
                          decoration: BoxDecoration(
                            color: currentIndex == i
                                ? Colors.black
                                : AppColors.grey,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}
