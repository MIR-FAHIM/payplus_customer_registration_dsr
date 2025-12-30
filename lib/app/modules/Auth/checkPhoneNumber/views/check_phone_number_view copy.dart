import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/models/icon_model.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';

import 'package:url_launcher/url_launcher.dart';

import '../controllers/check_phone_number_controller.dart';

class CheckPhoneNumberView extends GetView<CheckPhoneNumberController> {
  final userdata = GetStorage();
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    // Get.find<CheckPhoneNumberController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        userdata.write('imeiNumber', Get.find<LocationService>().imei.value);

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: _size.width,
            height: _size.height,
            child: Column(
              children: [
                Stack(
                  children: [
                    Form(
                      key: controller.mobileFormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.size.height * .1,
                            ),
                            Center(
                              child: Container(
                                height: Get.size.width * .35,
                                width: Get.size.width * .55,
                                child: Image(
                                  image: AssetImage('assets/Logo.png'),
                                  // color: Color(0xFF652981),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.size.height * .03,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(
                                0.0,
                              ),
                              child: Text(
                                'Login / Register with mobile number'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            TextFieldWidget(
                              labelText: "Mobile Noo".tr,
                              initialValue: controller.textEditingController.text,
                              keyboardType: TextInputType.phone,
                              hasDropdown: true,
                              limit: 11,
                              dropDownData: [
                                "assets/sim/gp.png",
                                "assets/sim/robi.png",
                                "assets/sim/bl.png",
                                "assets/sim/art.png",
                                "assets/sim/teletalk.png",
                              ],
                              initialDropDownValue: controller.simOperator.value,
                              hintText: 'Mobile Number'.tr,
                              onChanged: (input) {
                                controller.textEditingController.text = input;
                                print(input);
                                // print(controller.textEditingController.text.substring(0, 3));
                                for (var item in simOperators) {
                                  print(item.title);
                                  if (controller.textEditingController.text.length > 3) {
                                    if (controller.textEditingController.text
                                            .substring(0, 3) ==
                                        item.title) {
                                      print(controller.textEditingController.text
                                              .substring(0, 3) ==
                                          item.title);
                                      controller.simOperator.value = item.image!;
                                    }
                                  }
                                }
                              },
                              validator: (input) {
                                // return !input!.startsWith('\+') && !input.startsWith('00')
                                //     ? "Should be valid mobile number with country code"
                                //     : null;

                                return input!.length < 11 || input.length > 11
                                    ? 'Please enter valid number'
                                    : null;
                              },
                              imageData: 'assets/icons/number_pad.png',
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 8),
                            //   child: Container(
                            //     child: Row(
                            //       children: [
                            //         Checkbox(
                            //           value: controller.isChecked.value,
                            //           onChanged: (value) {
                            //             controller.isChecked.value = value!;
                            //           },
                            //         ),
                            //         Text(
                            //           'I agree to your'.tr,
                            //           style: TextStyle(
                            //               color: Colors.black, fontSize: 13),
                            //         ).paddingSymmetric(vertical: 5, horizontal: 1),
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 5),
                            //           child: InkWell(
                            //             onTap: () async {
                            //               String url =
                            //                   "https://www.paystation.paypos.reg/terms-and-conditions.php";
                            //               if (await canLaunch(url)) {
                            //                 await launch(url, forceSafariVC: false);
                            //               } else {
                            //                 print("can not load this url");
                            //               }
                            //             },
                            //             child: Container(
                            //                 child: Text(
                            //               "terms and condition".tr,
                            //               style: TextStyle(
                            //                   decoration: TextDecoration.underline,
                            //                   // fontSize: 12,
                            //                   color: AppColors.primaryColor,
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 13),
                            //             )),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // )
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                controller.checkNumberDuplicacy();
                              },
                              child: Container(
                                // width: MediaQuery.of(context).size.width * 0.17,
                                // height: MediaQuery.of(context).size.height * 0.08,
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(200),
                                    boxShadow: [
                                      BoxShadow(
                                          //offset: Offset(0, 4),
                                          color: AppColors.primarydeepLightColor, //edited
                                          spreadRadius: 4,
                                          blurRadius: 10 //edited
                                          )
                                    ]),
                                child: Container(
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/arrow_for.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                              ),
                            ),
                            // BlockButtonWidget(
                            //   onPressed: () {},
                            //   color: Color(0xFF652981),
                            //   text: Text(
                            //     "Login".tr,
                            //     style: Get.textTheme.headline6!
                            //         .merge(TextStyle(color: Colors.white)),
                            //   ),
                            // ).paddingSymmetric(vertical: 10, horizontal: 20)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
