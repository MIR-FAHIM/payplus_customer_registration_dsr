import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';


class MerchantImageWidget extends GetWidget<SignupController> {
  RangeValues _currentRangeValues = const RangeValues(0, 12);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
          margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF652981).withOpacity(0.2),
                  blurRadius: 2,
                  offset: const Offset(0, 2)),
            ],
            //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Merchant Image".tr,
                style: Get.textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10,
              ),
              // Obx(() {
              //   return Center(
              //     child: Container(
              //       height: Get.width * .3,
              //       width: Get.width * .3,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(100),
              //           border: Border.all(
              //             width: 2,
              //             color: Color(0xFF652981),
              //           )),
              //       child: GestureDetector(
              //         onTap: () {
              //           controller.getImage(ImageSource.camera, 'user');
              //         },
              //         child: controller.userData.value.image != null
              //             ? ClipRRect(
              //                 borderRadius: BorderRadius.circular(100),
              //                 child: Image.memory(
              //                   base64Decode(
              //                     controller.userData.value.image!,
              //                   ),
              //                   // height: Get.size.width * .45,
              //                   // width: Get.size.width,
              //                   fit: BoxFit.fill,
              //                 ),
              //               )
              //             : Icon(
              //                 Icons.camera_alt_outlined,
              //                 color: Color(0xFF652981),
              //                 size: 30,
              //               ),
              //       ),
              //     ),
              //   );
              // }),
            ],
          ),
        ),
        const SizedBox(
          height: 150,
        ),
      ],
    );
  }
}
