import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/splashscreen/controllers/splashscreen_controller.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../common/Color.dart';
import '../../../../../routes/app_pages.dart';

class NewNidVerification extends GetView<SignupController> {
  final _size = Get.size;

  final ScrollController _controller = ScrollController();
  //signature - Z+7FVOca7EZ
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
                  if (controller.userData.value.nid_front == null ||
                      controller.userData.value.nid_back == null) {
                    Get.showSnackbar(Ui.ErrorSnackBar(
                        message: "Please Provide NID front and back picture",
                        title: 'Error'));
                  } else {
                    if (controller.isClearImage.value == false) {
                      Get.showSnackbar(Ui.ErrorSnackBar(
                          message: "আপনার পরিষ্কার NID ছবি যুক্ত করুন",
                          title: 'Error'));
                    } else {
                    //  Get.toNamed(Routes.NEWNIDINPUT);
                      Get.toNamed(Routes.NEW_TRADE);
                    }
                  }

                  // controller.newNIDVerificationController();
                },
                child: Container(
                  width: _size.width,
                  height: _size.width * .1,
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                controller.isClearImage.value == true
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          controller.errorText.value,
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.start,
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 14, left: 20, right: 20),
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
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
                        "NID Front Image".tr,
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          PermissionStatus status =
                              await Permission.camera.status;

                          if (status.isGranted) {
                            // Camera permission is granted
                            print('Camera permission is granted.');
                            showPopup(context, 'nid_front');
                          } else {
                            // Camera permission is not granted
                            print(
                                'Camera permission is not granted. Requesting permission...');
                            // Request camera permission
                            status = await Permission.camera.request();
                            if (status.isGranted) {
                              showPopup(context, 'nid_front');
                            } else {
                              print('Camera permission is still not granted.');
                              Get.showSnackbar(Ui.ErrorSnackBar(
                                  message:
                                      "Camera permission is still not granted.",
                                  title: 'Error'));
                            }
                          }

                          // controller.getImage(ImageSource.camera, 'nid_front');
                          // controller.readNId();
                          // controller.readNId();
                        },
                        child: controller.userData.value.nid_front != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  base64Decode(
                                    controller.userData.value.nid_front!,
                                  ),
                                  height: Get.size.width * .45,
                                  width: Get.size.width,
                                  fit: BoxFit.fill,
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
                                            borderRadius:
                                                BorderRadius.circular(50)),
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
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 14, left: 20, right: 20),
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
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
                        "NID Back Image".tr,
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          //controller.getImage(ImageSource.camera, 'nid_back');

                          showPopup(context, 'nid_back');
                        },
                        child: controller.userData.value.nid_back != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  base64Decode(
                                    controller.userData.value.nid_back!,
                                  ),
                                  height: Get.size.width * .45,
                                  width: Get.size.width,
                                  fit: BoxFit.fill,
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
                                            borderRadius:
                                                BorderRadius.circular(50)),
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
                SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF652981).withOpacity(.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "! আপনার এনাআইডি কার্ডের সাথে ছবি সঠিক না হলে রেজিস্ট্রেশন সফল হবে না, সফল ভাবে রেজিস্ট্রেশন করতে এনআইডি ও ছবি ভালোভাবে তুলুন।",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                )
                // Container(
                //   padding: const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
                //   margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10),
                //     boxShadow: [
                //       BoxShadow(color: const Color(0xFF652981).withOpacity(0.2), blurRadius: 2, offset: const Offset(0, 2)),
                //     ],
                //     //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     children: [
                //       Text(
                //         "Please take a picture of your face".tr,
                //         style: Get.textTheme.bodyText1,
                //         textAlign: TextAlign.start,
                //       ),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           //controller.getImage(ImageSource.camera, 'nid_back');
                //
                //               showPopup(context, 'user');
                //         },
                //         child:  Stack(
                //           children: [
                //             Image.asset(
                //               'assets/images/nid.png',
                //               height: Get.size.width * .35,
                //               width: Get.size.width,
                //               color: Colors.grey,
                //             ),
                //             Positioned(
                //                 bottom: 10,
                //                 right: 80,
                //                 child: Container(
                //                   decoration: BoxDecoration(color: const Color(0xFF652981), borderRadius: BorderRadius.circular(50)),
                //                   child: const Padding(
                //                     padding: EdgeInsets.all(8.0),
                //                     child: Icon(
                //                       Icons.camera_alt,
                //                       color: Colors.white,
                //                     ),
                //                   ),
                //                 ))
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ));
    });
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
                  // ListTile(
                  //     leading: const Icon(Icons.photo_library),
                  //     title: Text('Photo Library'.tr),
                  //     onTap: () {
                  //       controller.getImageAndroid13(ImageSource.gallery, type);
                  //       Get.back();
                  //     }),
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
