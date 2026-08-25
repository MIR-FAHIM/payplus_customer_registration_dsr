import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';


class AddPasswordReg extends GetWidget<SignupController> {
  AddPasswordReg({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitPin() {
    if (controller.updatePassLoading.value) return;

    FocusManager.instance.primaryFocus?.unfocus();

    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    if (controller.confirmPass.value != controller.userData.value.password) {
      Get.showSnackbar(
        Ui.ErrorSnackBar(
          message: "Pin did not match.".tr,
          title: 'Failed'.tr,
        ),
      );
      return;
    }

    final dynamic args = Get.arguments;

    controller.updatePass(
      args['acc_no'],
      args['mobile'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Add Your Pin".tr,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(() {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [


                        Text(
                          "Create a secure PIN".tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff1F2937),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Please enter a 6 digit PIN and confirm it to continue."
                              .tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13.5,
                            height: 1.4,
                            color: Color(0xff6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 24),

                        TextFieldWidget(
                          labelText: "PIN:".tr,
                          hintText: "••••••".tr,
                          keyboardType: TextInputType.number,
                          limit: 6,
                          obscureText: controller.hidePassword.value,
                          iconData: Icons.lock_outline,
                          onChanged: (input) {
                            controller.userData.value.password = input;
                          },
                          validator: (input) {
                            final String value = input?.trim() ?? '';

                            if (value.isEmpty) {
                              return "PIN is required".tr;
                            }

                            if (value.length != 6) {
                              return "Should be 6 characters".tr;
                            }

                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidePassword.value =
                              !controller.hidePassword.value;
                            },
                            color: AppColors.primaryColor,
                            icon: Icon(
                              controller.hidePassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextFieldWidget(
                          labelText: "Confirm PIN Number:".tr,
                          hintText: "••••••".tr,
                          keyboardType: TextInputType.number,
                          limit: 6,
                          obscureText: controller.hideConfirmPassword.value,
                          iconData: Icons.lock_outline,
                          onChanged: (input) {
                            controller.confirmPass.value = input;
                          },
                          validator: (input) {
                            final String value = input?.trim() ?? '';
                            final String password =
                                controller.userData.value.password ?? '';

                            if (value.isEmpty) {
                              return "Confirm PIN is required".tr;
                            }

                            if (value.length != 6) {
                              return "Should be 6 characters".tr;
                            }

                            if (value != password) {
                              return "Password doesn't match".tr;
                            }

                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.hideConfirmPassword.value =
                              !controller.hideConfirmPassword.value;
                            },
                            color: AppColors.primaryColor,
                            icon: Icon(
                              controller.hideConfirmPassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: controller.updatePassLoading.value
                                ? null
                                : _submitPin,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.primaryColor,
                              disabledBackgroundColor:
                              AppColors.primaryColor.withOpacity(0.55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: controller.updatePassLoading.value
                                ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.4,
                                color: Colors.white,
                              ),
                            )
                                : Text(
                              "Confirm".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Obx(() {
                    final String error =
                    controller.errorMessagePinSet.value.trim();

                    if (error.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xffFEF2F2),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xffFECACA),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            color: Color(0xffDC2626),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              error,
                              style: const TextStyle(
                                color: Color(0xffB91C1C),
                                fontSize: 13,
                                height: 1.35,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}