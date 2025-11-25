import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/forget_password_new/controllers/forget_password_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text(
              'Change Pin'.tr,
              style: TextStyle(fontSize: 16),
            ),
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back_ios),
            //   onPressed: () => Get.back(),
            // ),
            elevation: 0,
          ),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: controller.forgetPinFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // TextFieldWidget(
                  //   labelText: "Enter Old Password".tr,
                  //   hintText: "******".tr,
                  //   keyboardType: TextInputType.number,
                  //   onChanged: (input) {
                  //     controller.oldPin.value = input;
                  //   },
                  //   validator: (input) {
                  //     if (input!.length < 4) {
                  //       return "PIN should't be less than 4 characters".tr;
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  //   iconData: CupertinoIcons.lock,
                  //   obscureText: controller.hideOldPin.value,
                  //   suffixIcon: IconButton(
                  //     onPressed: () {
                  //       controller.hideOldPin.value =
                  //           !controller.hideOldPin.value;
                  //     },
                  //     // color: Theme.of(context).focusColor,
                  //     icon: Icon(
                  //       !controller.hideOldPin.value
                  //           ? Icons.visibility_outlined
                  //           : Icons.visibility_off_outlined,
                  //       color: !controller.hideOldPin.value
                  //           ? Color(0xFF652981)
                  //           : Colors.grey,
                  //     ),
                  //   ),
                  //   imageData: null,
                  // ),

                  // TextFieldWidget(
                  //   // keyboardType: numberFormatSymbols,
                  //   labelText: "NID No".tr,
                  //   hintText: "Enter NID".tr,
                  //   onChanged: (value) {
                  //     // setState(() {
                  //     //   bill_number = value;
                  //     // });
                  //   },
                  //   // onSaved: (input) =>
                  //   // controller.currentUser.value.email = input,
                  //   // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                  //   keyboardType: TextInputType.number,
                  //   iconData: null,
                  //   imageData: 'assets/images/nid.png',
                  // ),

                  TextFieldWidget(
                    labelText: "Enter New Pin".tr,
                    hintText: "******".tr,
                    onChanged: (input) {
                      controller.newPin.value = input;
                    },
                    validator: (input) {
                      if (input!.length < 6) {
                        return "PIN should't be less than 6 characters".tr;
                      } else {
                        return null;
                      }
                    },
                    iconData: CupertinoIcons.lock,
                    obscureText: controller.hideNewPIN.value,
                    keyboardType: TextInputType.number,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.hideNewPIN.value =
                            !controller.hideNewPIN.value;
                      },
                      // color: Theme.of(context).focusColor,
                      icon: Icon(
                        !controller.hideNewPIN.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: !controller.hideNewPIN.value
                            ? Color(0xFF652981)
                            : Colors.grey,
                      ),
                    ),
                    imageData: null,
                  ),
                  TextFieldWidget(
                    labelText: "Again Type Pin".tr,
                    hintText: "******".tr,
                    validator: (input) {
                      if (input != controller.newPin.value) {
                        return "PIN doesn't matched".tr;
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    iconData: CupertinoIcons.lock,
                    obscureText: controller.hideConfirmPIN.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.hideConfirmPIN.value =
                            !controller.hideConfirmPIN.value;
                      },
                      // color: Theme.of(context).focusColor,
                      icon: Icon(
                        !controller.hideConfirmPIN.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: !controller.hideConfirmPIN.value
                            ? Color(0xFF652981)
                            : Colors.grey,
                      ),
                    ),
                    imageData: null,
                  ),
                  BlockButtonWidget(
                    onPressed: () {
                      // controller.test();
                      if (controller.forgetPinFormKey.currentState!.validate()) {
                        controller.changePin();

                        // Get.find<AuthService>().removeCurrentUser();
                        // Get.offAllNamed(Routes.CHECK_PHONE_NUMBER);
                        // Get.offAndToNamed(Routes.CHECK_PHONE_NUMBER);
                      }
                    },
                    color: Color(0xFF652981),
                    text: Text(
                      "Register".tr,
                      style: Get.textTheme.bodyMedium!
                          .merge(TextStyle(color: Colors.white)),
                    ),
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                  if (controller.isImeiFailed.value)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Text(
                          controller.message.value,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    ),


                ],
              ),
            ),
          );
        }));
  }
}
