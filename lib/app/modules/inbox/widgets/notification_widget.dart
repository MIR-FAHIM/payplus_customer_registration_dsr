import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class NotificationWidget extends GetWidget<InboxController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.notificationLoaded.isTrue) {
        if (controller.notifications.value.data!.isNotEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(
                  controller.notifications.value.data!.length, (index) {
                var notiData = controller.notifications.value.data![index];
                return InkWell(
                  onTap: () {
                    if (notiData.image!.isNotEmpty) {
                      Get.toNamed(Routes.NOTIDETAILS, arguments: [notiData]);
                    } else {
                      if (controller.notifications.value.data![index].title! ==
                              "Robi Recharge Request from PayPos" ||
                          controller.notifications.value.data![index].title! ==
                              "Airtel Recharge Request from PayPos" ||
                          controller.notifications.value.data![index].title! ==
                              "Teletalk Recharge Request from PayPos") {
                        controller.notiId.value = controller.notifications.value.data![index].notiId!;
                        List<String?> numbers =
                            controller.extractNumbersFromString(controller
                                .notifications.value.data![index].message!);
                        if (numbers.isNotEmpty) {

                          Get.toNamed(
                            Routes.RECHARGEPINNOTIFICATION,
                            arguments: [
                              numbers[0],
                              numbers[1],
                              numbers[2],
                            ],
                          );
                        } else {
                          print("message num list is empty bhai >>>>>>");
                        }


                      }
                    }
                  },
                  child: AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: Get.size.width,
                            decoration: Ui.getBoxDecoration(
                              color: Colors.white,
                              radius: 10,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  width: _size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: controller.notifications.value
                                                        .data![index].image !=
                                                    null
                                                ? 3
                                                : 1,
                                            child: controller
                                                        .notifications
                                                        .value
                                                        .data![index]
                                                        .image !=
                                                    null
                                                ? Container(
                                                    height: Get.height * .12,
                                                    width: Get.width * .3,
                                                    child: CachedNetworkImage(
                                                      imageUrl: controller
                                                          .notifications
                                                          .value
                                                          .data![index]
                                                          .image!,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder:
                                                          (context, url) =>
                                                               Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child:  Icon(
                                                          Icons.notifications,
                                                          color: controller
                                                              .notifications
                                                              .value
                                                              .data![
                                                          index]
                                                              .activityStatus ==
                                                              0 &&
                                                              controller
                                                                  .notifications
                                                                  .value
                                                                  .data![
                                                              index]
                                                                  .title!.contains("Recharge Request from PayPos")


                                                              ? Colors.redAccent
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                           Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child:  Icon(
                                                          Icons.notifications,
                                                          color: controller
                                                              .notifications
                                                              .value
                                                              .data![
                                                          index]
                                                              .activityStatus ==
                                                              0 &&
                                                              controller
                                                                  .notifications
                                                                  .value
                                                                  .data![
                                                              index]
                                                                  .title!.contains("Recharge Request from PayPos")
                                                              ? Colors.redAccent
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: _size.width * .15,
                                                    width: _size.width * .15,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.notifications,
                                                        color: controller
                                                                        .notifications
                                                                        .value
                                                                        .data![
                                                                            index]
                                                                        .activityStatus ==
                                                                    0 &&
                                                                controller
                                                                        .notifications
                                                                        .value
                                                                        .data![
                                                                            index]
                                                                        .title!.contains("Recharge Request from PayPos")
                                                            ? Colors.redAccent
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller
                                                        .notifications
                                                        .value
                                                        .data![index]
                                                        .title!,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Get
                                                            .theme
                                                            .textTheme
                                                            .bodyMedium!
                                                            .color),
                                                  ),
                                                  Text(
                                                    controller
                                                        .notifications
                                                        .value
                                                        .data![index]
                                                        .message!,
                                                    maxLines: 3,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  Text(
                                                    controller
                                                        .notifications
                                                        .value
                                                        .data![index]
                                                        .dateTime!,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColors
                                                            .primaryColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        } else {
          return Container(
              height: Get.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Notification found for you'.tr,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        // Get.offAndToNamed(Routes.ROOT);
                      },
                      child: Text(
                        'Back To Home'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF652981),
                        ),
                      )),
                ],
              ));
        }
      } else {
        return Container(
          height: Get.size.width,
          child: Center(
            child: Ui.customLoader(),
          ),
        );
      }
    });
  }
}
