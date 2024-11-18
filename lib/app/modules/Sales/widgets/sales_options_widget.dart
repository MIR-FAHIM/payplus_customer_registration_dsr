import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/icon_model.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/square_card_widget.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';

class SalesOptionWidget extends GetWidget<HomeController> {
  final _size = Get.size;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: _size.height * .5,
      width: _size.width,
      color: Colors.white,
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 1.6,
          children: List.generate(saless.length, (index) {
            return GestureDetector(
              onTap: saless[index].press,
              child: AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 475),
                columnCount: saless.length,
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: SquareCardWidget(
                      width: Get.width * .1,
                      aspectRetio: 1.2,
                      colors: Color(0xFF652981),
                      image: saless[index].image,
                      allpadding: 0.0,
                      name: saless[index].title!.tr,
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}
