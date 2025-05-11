import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final _size = Get.size;

  final ScrollController _controller = ScrollController();
  //signature - Z+7FVOca7EZ
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return WillPopScope(
        onWillPop: () {
          if (controller.currentIndex.value == 0) {
            Get.offAllNamed(Routes.CHECK_PHONE_NUMBER);
          } else {
            controller.currentIndex.value--;
          }
          // Get.offAllNamed(Routes.ROOT);
          return Future.value(false);
        },
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    Container(
                      height: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/login.png'),
                        fit: BoxFit.fill,
                      )),
                    ),
                    const Positioned(
                        top: 70,
                        left: 80,
                        right: 80,
                        child: Image(
                          image: AssetImage('assets/Logow.png'),
                        ))
                  ],
                )),
            Positioned(
                top: 180,
                left: 0,
                right: 0,
                bottom: 0,
                child: Stack(
                  children: [
                    Container(
                      height: controller.currentIndex.value == 4 ? _size.height * .62 : _size.height,
                      width: _size.width,
                      margin: const EdgeInsets.all(20),
                      decoration: Ui.getBoxDecoration(color: Colors.white),
                      child: Form(
                        key: controller.registerFormKey,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  controller.currentIndex.value == 5 ? 'Create PayPlus Password'.tr : 'SignUp to PayPlus'.tr,
                                  style: const TextStyle(
                                    color: Color(0xFF652981),
                                    fontSize: 22,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              controller.currentIndex.value == 5
                                  ? Center(
                                      child: Text(
                                        'Set your new password and you can login to PayPlus'.tr,
                                        style: TextStyle(
                                          color: Colors.grey.shade900,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : Wrap(),
                              const SizedBox(
                                height: 10,
                              ),
                              controller.currentPage,
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      left: 10,
                      right: 10,
                      child: controller.currentIndex.value == 5
                          ? Wrap()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                controller.currentIndex.value != 0
                                    ? Ui.getIconButton(
                                        height: 30,
                                        width: 30,
                                        radius: 30,
                                        icon: Icons.arrow_back,
                                        iconColor: Colors.white,
                                        color: const Color(0xFF652981),
                                        press: () {
                                          if (controller.currentIndex.value > 0) {
                                            controller.currentIndex.value--;
                                          }
                                        })
                                    : Wrap(),
                                Ui.getIconButton(
                                    height: 30,
                                    width: 30,
                                    radius: 30,
                                    icon: Icons.arrow_forward,
                                    iconColor: Colors.white,
                                    color: const Color(0xFF652981),
                                    press: () {
                                      print('Service Fee : ${controller.userData.value.service_fee_type}');
                                      print('Business Type : ${controller.userData.value.businessType}');
                                       print("my page current stage ${controller.currentIndex.value}");

                                      if (controller.currentIndex.value < controller.pages.length - 1) {
                                        if (controller.currentIndex.value == 1) {
                                          if (controller.userData.value.nid == null) {
                                            Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please provide your NID number'.tr, title: 'Error'.tr));
                                          } else if (controller.dateInput.value.text.isEmpty) {
                                            Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please provide your date of birth'.tr, title: 'Error'.tr));
                                          } else if (controller.userData.value.image == null) {
                                            Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please provide your photo'.tr, title: 'Error'.tr));
                                          }else {
                                            controller.currentIndex.value++;
                                          }
                                        } else if (controller.currentIndex.value == 3) {
                                          if (controller.userinfo.currentState!.validate()) {
                                            if (controller.userData.value.businessType == null) {
                                              Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please, choose Business Types'.tr, title: 'Business Types Problem'.tr));
                                            } else {
                                              controller.currentIndex.value++;
                                            }
                                          }
                                        } else if (controller.currentIndex.value == 4) {
                                          print(controller.userData.value.districts);
                                          if (controller.userData.value.districts == null || controller.userData.value.districts == '') {
                                            Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please Select District'.tr, title: 'Error'.tr));
                                          } else if (controller.userData.value.thana == null || controller.userData.value.thana == '') {
                                            Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please Select Upazila'.tr, title: 'Error'.tr));
                                          } else if (controller.userData.value.union == null || controller.userData.value.union == '') {
                                            Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please Select Union'.tr, title: 'Error'.tr));
                                          } else if (controller.userData.value.post_code == null || controller.userData.value.post_code == '') {
                                            Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please Enter Postal Code'.tr, title: 'Error'.tr));
                                          } else {
                                            Get.toNamed(Routes.PHONE_VERIFICATION_WTIH_O_T_P, arguments: {
                                              'mobileNumber': controller.userData.value.customerMobileNumber,
                                              'isRegistered': '0',
                                              'selectedServiceTypeId': controller.serviceFeeTypeId.value,
                                            })?.then((value) {
                                              controller.currentIndex.value++;
                                            });
                                          }
                                        } else if (controller.currentIndex.value == 0) {
                                          if (controller.userData.value.nid_front != null && controller.userData.value.nid_back != null) {
                                            controller.currentIndex.value++;
                                          } else {
                                            Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please provide your NID image'.tr, title: 'Error'.tr));
                                          }

                                        } else if (controller.currentIndex.value == 1) {

                                            controller.currentIndex.value++;

                                        }else if (controller.currentIndex.value == 2) {
                                          if (controller.userData.value.trade_license != null && controller.userData.value.trade_license2 != null) {
                                            controller.currentIndex.value++;
                                          } else {
                                            controller.currentIndex.value++;
                                           // Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please provide your Trade License image'.tr, title: 'Error'.tr));
                                          }
                                        } else {
                                          controller.currentIndex.value++;
                                        }

                                        // else if (controller.currentIndex == 3) {
                                        //   // if (controller.userData.value.image !=
                                        //   //     null) {
                                        //     controller.currentIndex.value++;
                                        //   } else {
                                        //     Get.showSnackbar(Ui.ErrorSnackBar(
                                        //         message:
                                        //             'Please provide your image'
                                        //                 .tr,
                                        //         title: 'Error'.tr));
                                        //   }
                                        // } else {
                                        //   controller.currentIndex.value++;
                                        // }
                                      }
                                    }),
                              ],
                            ).paddingSymmetric(vertical: 5, horizontal: 20),
                    )
                  ],
                ))
          ],
        ),
      );
    }));
  }
}
