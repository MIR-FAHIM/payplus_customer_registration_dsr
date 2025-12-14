import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';

class TradeLVerificationWidget extends GetWidget<SignupController> {
  RangeValues _currentRangeValues = const RangeValues(0, 12);

  TradeLVerificationWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Text(
            "Optional".tr,
            style: Get.textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),
          Text(
            "You can skip this page for now if you want".tr,
            style: Get.textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
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
                  "First Page of Trade License".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    //controller.getImage(ImageSource.camera, 'nid_back');

                    showPopup(context, 'trade');
                  },
                  child: controller.userData.value.trade_license != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            base64Decode(
                              controller.userData.value.trade_license!,
                            ),
                            height: Get.size.width * .3,
                            width: Get.size.width,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Stack(
                          children: [
                            Image.asset(
                              'assets/images/nid.png',
                              height: Get.size.width * .35,
                              width: Get.size.width,
                              color: Colors.grey,
                            ),
                            Positioned(
                                bottom: 10,
                                right: 80,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF652981),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                )
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
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
                  "Second Page of Trade License".tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    //controller.getImage(ImageSource.camera, 'nid_back');

                    showPopup(context, 'trade2');
                  },
                  child: controller.userData.value.trade_license2 != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            base64Decode(
                              controller.userData.value.trade_license2!,
                            ),
                            height: Get.size.width * .3,
                            width: Get.size.width,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Stack(
                          children: [
                            Image.asset(
                              'assets/images/nid.png',
                              height: Get.size.width * .35,
                              width: Get.size.width,
                              color: Colors.grey,
                            ),
                            Positioned(
                                bottom: 10,
                                right: 80,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF652981),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  void showPicker(context, String type) {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Wrap(
          children: <Widget>[
            InkWell(
              onTap: () {
                Get.back();
              } /* Navigator.pop(context)*/,
              child: Center(
                child: Image.asset(
                  'assets/bottom/rectline.png',
                  height: 20,
                  width: 40,
                  color: Get.theme.disabledColor.withOpacity(0.2),
                ),
              ),
            ),
            ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text('Photo Library'.tr),
                onTap: () {
                  controller.getImageAndroid13(ImageSource.gallery, type);
                  Get.back();
                }),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text('Camera'.tr),
              onTap: () {
                controller.getImage(ImageSource.camera, type);
                Get.back();
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
    // showModalBottomSheet(
    //     context: context,
    //     builder: (BuildContext bc) {
    //       return Container(
    //         width: double.infinity,
    //         decoration: BoxDecoration(
    //           color: Get.theme.scaffoldBackgroundColor,
    //           borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    //         ),
    //         child: Wrap(
    //           children: <Widget>[
    //             ListTile(
    //                 leading: const Icon(Icons.photo_library),
    //                 title: Text('Photo Library'.tr),
    //                 onTap: () {
    //                   controller.getImage(ImageSource.gallery);
    //                   Get.back();
    //                 }),
    //             ListTile(
    //               leading: const Icon(Icons.photo_camera),
    //               title: Text('Camera'.tr),
    //               onTap: () {
    //                 controller.getImage(ImageSource.camera);
    //                 Get.back();
    //               },
    //             ),
    //           ],
    //         ),
    //       );
    //     });
  }

  showPopup(context, String type) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            //title: Text('Select '),
            content: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text('Photo Library'.tr),
                      onTap: () {
                        controller.getImageAndroid13(ImageSource.gallery, type);
                        Get.back();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Camera'.tr),
                    onTap: () {
                      controller.getImage(ImageSource.camera, type);
                      Get.back();
                    },
                  ),
                ],
              ),
            )
            // actions: <Widget>[

            // ],
            );
      },
    );
  }
}
