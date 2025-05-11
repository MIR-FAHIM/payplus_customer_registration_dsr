import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Get.back(),
            ),
            elevation: 0,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back_ios),
            //   onPressed: () => Get.offAllNamed(Routes.ROOT),
            // ),
            // actions: [
            //   IconButton(
            //       onPressed: () {},
            //       icon: Icon(
            //         CupertinoIcons.bell,
            //         color: Colors.white70,
            //       )),
            //   // IconButton(
            //   //     onPressed: () => {Scaffold.of(context).openEndDrawer()},
            //   //     icon: Icon(
            //   //       Icons.menu,
            //   //       color: Colors.white70,
            //   //     )),
            // ],
          ),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: controller.pinFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFieldWidget(
                    labelText: "Enter Old Pin".tr,
                    hintText: "******".tr,
                    keyboardType: TextInputType.number,
                    onChanged: (input) {
                      controller.oldPin.value = input;
                    },
                    validator: (input) {
                      if (input!.length < 4) {
                        return "PIN shouldn't be less than 4 characters".tr;
                      } else {
                        return null;
                      }
                    },
                    limit: 6,
                    counterText: "",
                    iconData: CupertinoIcons.lock,
                    obscureText: controller.hideOldPin.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.hideOldPin.value = !controller.hideOldPin.value;
                      },
                      // color: Theme.of(context).focusColor,
                      icon: Icon(
                        !controller.hideOldPin.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: !controller.hideOldPin.value ? Color(0xFF652981) : Colors.grey,
                      ),
                    ),
                    imageData: null,
                  ),
                  TextFieldWidget(
                    labelText: "Enter New Pin".tr,
                    hintText: "******".tr,
                    onChanged: (input) {
                      controller.newPin.value = input;
                    },
                    validator: (input) {
                      if (input!.length < 6) {
                        return "PIN shouldn't be less than 6 characters".tr;
                      } else if (controller.newPin.value == controller.oldPin.value) {
                        return "Please provide different PIN".tr;
                      } else {
                        return null;
                      }
                    },
                    limit: 6,
                    counterText: "",
                    iconData: CupertinoIcons.lock,
                    obscureText: controller.hideNewPIN.value,
                    keyboardType: TextInputType.number,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.hideNewPIN.value = !controller.hideNewPIN.value;
                      },
                      // color: Theme.of(context).focusColor,
                      icon: Icon(
                        !controller.hideNewPIN.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: !controller.hideNewPIN.value ? Color(0xFF652981) : Colors.grey,
                      ),
                    ),
                    imageData: null,
                  ),
                  TextFieldWidget(
                    labelText: "Retype New Pin".tr,
                    hintText: "******".tr,
                    validator: (input) {
                      if (input != controller.newPin.value) {
                        return "PIN doesn't matched".tr;
                      } else {
                        return null;
                      }
                    },
                    limit: 6,
                    counterText: "",
                    keyboardType: TextInputType.number,
                    iconData: CupertinoIcons.lock,
                    obscureText: controller.hideConfirmPIN.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.hideConfirmPIN.value = !controller.hideConfirmPIN.value;
                      },

                      // color: Theme.of(context).focusColor,
                      icon: Icon(
                        !controller.hideConfirmPIN.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: !controller.hideConfirmPIN.value ? Color(0xFF652981) : Colors.grey,
                      ),
                    ),
                    imageData: null,
                  ),
                  BlockButtonWidget(
                    onPressed: () {
                      if (controller.pinFormKey.currentState!.validate()) {
                        controller.changePin();

                        // Get.find<AuthService>().removeCurrentUser();
                        // Get.offAllNamed(Routes.CHECK_PHONE_NUMBER);
                        // Get.offAndToNamed(Routes.CHECK_PHONE_NUMBER);
                      }
                    },
                    color: Color(0xFF652981),
                    text: Text(
                      "UPDATE PIN".tr,
                      style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Colors.white)),
                    ),
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                ],
              ),
            ),
          );
        }));
  }
}
