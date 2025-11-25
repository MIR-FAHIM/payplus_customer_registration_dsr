import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class HomeSliderWidget extends GetWidget<HomeController> {
  final Size _size = Get.size;

  HomeSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.AdBannerLoad.value) {
        return SizedBox(
          height: _size.width * .3,
          width: _size.width,
          child: CarouselSlider.builder(
            itemCount: controller.AdBanner.length,
            options: CarouselOptions(
              height: _size.width * .3,
              autoPlay: true,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              enableInfiniteScroll: true,
            ),
            itemBuilder: (context, index, realIdx) {
              return Container(
                margin: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: controller.AdBanner[index].advertisementBanner ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Padding(
                      padding: EdgeInsets.all(5),
                      child: Image(image: AssetImage("assets/Logo.png")),
                    ),
                    errorWidget: (context, url, error) => const Padding(
                      padding: EdgeInsets.all(5),
                      child: Image(image: AssetImage("assets/Logo.png")),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Ui.shimmerLoader(
            height: _size.width * .3,
            width: _size.width,
            baseColor: Get.theme.highlightColor,
            highlightColor: Get.theme.splashColor,
          ),
        );
      }
    });
  }
}
