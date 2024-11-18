import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/data_model_product.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/square_card_text_widget.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';

class ProductDetailWidget extends GetWidget<HomeController> {
  final _size = Get.size;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      // height: _size.width * .6,
      width: _size.width,
      color: Colors.white,
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.5,
          children: List.generate(productDetail.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              child: GestureDetector(
                // onTap: productDetail[index].press,
                child: AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 475),
                  columnCount: 3,
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: SquareCardTextWidget(
                        width: 35,
                        aspectRetio: 1.2,
                        name: productDetail[index].value!,
                        allpadding: 0.0,
                        title: productDetail[index].title!.tr,
                      ),
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}
