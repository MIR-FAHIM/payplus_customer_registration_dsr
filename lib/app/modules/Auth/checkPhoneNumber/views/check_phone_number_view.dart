import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/models/icon_model.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import '../controllers/check_phone_number_controller.dart';

class CheckPhoneNumberView extends GetView<CheckPhoneNumberController> {
  final userdata = GetStorage();
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        userdata.write('imeiNumber', Get.find<LocationService>().imei.value);

        return WillPopScope(
          onWillPop: () async {
            return exit(0);
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: _size.width,
              height: _size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.size.height * .1,
                    ),
                    Center(
                      child: SizedBox(
                        height: Get.size.width * .35,
                        width: Get.size.width * .55,
                        child: const Image(
                          image: AssetImage('assets/Logo.png'),
                          // color: Color(0xFF652981),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.size.height * .02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25,
                      ),
                      child: Text(
                        'Login / Register with mobile number'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Form(
                      key: controller.mobileFormKey,
                      child: Column(
                        children: [
                          TextFieldWidget(
                            labelText: "Mobile No".tr,
                            initialValue: controller.textEditingController.text,
                            keyboardType: TextInputType.phone,
                            hasDropdown: true,
                            limit: 11,
                            dropDownData: const [
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
                                if (controller
                                        .textEditingController.text.length >
                                    3) {
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width - 40,
                                child: Center(
                                  child: CheckboxListTile(
                                    title: GestureDetector(
                                      onTap: () {
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     builder: (builder) =>
                                        //         TermAndCOndition(),
                                        //   ),
                                        // );
                                      },
                                      child: Text(
                                        "I agree on Terms and Conditions of this App.",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    value: controller.checkTerm.value,
                                    onChanged: (newValue) {
                                      controller.checkTerm.value = newValue!;
                                      // print("my term $newValue and check ${controller.checkTerm.value}");
                                    },
                                    controlAffinity: ListTileControlAffinity
                                        .leading, //  <-- leading Checkbox
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {

                              if (controller.checkTerm.value == true) {
                                if(controller.isAnySimAvailable.value == false){
                                  controller.checkNumberDuplicacy();
                                }else{
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'You do not have any sim in this device.'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }

                              } else {
                                final snackBar = SnackBar(
                                  content: Text(
                                      'User must agree on Terms and Condition!'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }

                             // controller.getDeviceInfo();
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
                                      color: Color(0xFF652981).withOpacity(0.4),
                                      blurRadius: 6,
                                      spreadRadius: 1,
                                      offset: Offset(0, 4)),
                                ],
                              ),
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/arrow_for.png'),
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
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
