import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class NewTradeLVerificationWidget extends GetWidget<SignupController> {


  NewTradeLVerificationWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Register".tr,
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,

            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 43, 42, 43).withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(0, -2)),
            ],
            //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                if (controller.userData.value.trade_license == null ||
                    controller.userData.value.trade_license2 == null) {
                  Get.showSnackbar(Ui.ErrorSnackBar(
                      message: "Please Provide Trade License front and back picture",
                      title: 'Error'));
                } else {
                  if (controller.isClearImage.value == false) {
                    Get.showSnackbar(Ui.ErrorSnackBar(
                        message: "আপনার পরিষ্কার Trade ছবি যুক্ত করুন",
                        title: 'Error'));
                  } else {
                      Get.toNamed(Routes.NEWNIDINPUT);

                  }
                }

                // controller.newNIDVerificationController();
              },
              child: Container(
                width: Get.width,
                height: Get.width * .1,
                decoration:
                Ui.getBoxDecoration(color: Color(0xFF652981), radius: 10),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'Continue'.tr,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [


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
        ),
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
