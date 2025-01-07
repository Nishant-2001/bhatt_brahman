import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/advertisement_controller.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int current = 0;
  final CarouselSliderController controller = CarouselSliderController();
  final AdvertisementController adController =
      Get.put(AdvertisementController());

  void _launchURL(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not launch URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (adController.isLoading.value) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }

      return Container(
        child: Stack(
          children: [
            CarouselSlider(
              items: adController.advertisements
                  .map((advertisement) => GestureDetector(
                        onTap: () => _launchURL(advertisement.url),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: advertisement.advertisementImage,
                            fit: BoxFit.cover,
                            width: Get.width - 5,
                            placeholder: (context, url) => const ColoredBox(
                              color: Colors.white,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ))
                  .toList(),
              carouselController: controller,
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.5,
                onPageChanged: (index, reason) {
                  setState(() {
                    current = index;
                  });
                },
                viewportFraction: 1,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    adController.advertisements.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () {
                      controller.animateToPage(entry.key);
                    },
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : const Color(0xffFF2F2F))
                            .withOpacity(current == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      );
    });
  }
}
