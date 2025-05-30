import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';


class AddPasswordReg extends GetWidget<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text("Add PIN".tr),
      ),
      body: Obx(() {
        return Column(
          children: [
            TextFieldWidget(
              labelText: "Add PIN".tr,
              hintText: "••••••••••••".tr,
              keyboardType: TextInputType.number,
              onChanged: (input) {
                controller.userData.value.password = input;
              },

              // onSaved: (input) =>
              // controller.currentUser.value.password = input,
              validator: (input) {
                if (input!.length < 6 || input.length > 6)
                  return "Should be 6 characters".tr;
                else {
                  return null;
                }
              },
              limit: 6,
              obscureText: controller.hidePassword.value,
              iconData: Icons.lock_outline,
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.hidePassword.value = !controller.hidePassword.value;
                  },
                  color:  AppColors.primaryColor,
                  icon: controller.hidePassword.value == false ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off_outlined)),
            ),
            TextFieldWidget(
              labelText: "Confirm PIN Number:".tr,
              hintText: "••••••••••••".tr,

              onChanged: (input) {
                controller.confirmPass.value = input;
              },
              keyboardType: TextInputType.number,
              validator: (input) {
                if (input!.length < 6 || input.length > 6) {
                  return "Should be 6 characters".tr;
                } else if (input != controller.userData.value.password) {
                  return "Password doesn't match".tr;
                } else {
                  return null;
                }
              },
              limit: 6,
              obscureText: controller.hideConfirmPassword.value,
              iconData: Icons.lock_outline,
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.hideConfirmPassword.value = !controller.hideConfirmPassword.value;
                  },
                  color:  AppColors.primaryColor,
                  icon: controller.hideConfirmPassword.value == false ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off_outlined)),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if(controller.confirmPass.value == controller.userData.value.password ) {

print("mobile no is ${Get.arguments[0]}");
                  controller.updatePass(Get.arguments[0],  Get.arguments[1]);
                }else{
                  Get.showSnackbar(Ui.ErrorSnackBar(
                      message: "Password did not match.", title: 'Failed'.tr));
                }

              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color:  AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Center(
                    child: Text(
                      "Confirm".tr,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ).paddingSymmetric(vertical: 5, horizontal: 20),
            ),
          ],
        );
      }),
    );
  }
}
