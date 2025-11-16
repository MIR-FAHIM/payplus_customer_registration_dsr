import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/login_controller.dart';


class LoginView extends GetView<LoginController> {

  final userdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    userdata.write('mobile_number', controller.mobileNumber.value);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Get.height < 700
                    ? Container(
                  // height: _size.width,
                  width: _size.width,
                  margin: EdgeInsets.all(_size.width * .04),
                  decoration: Ui.getBoxDecoration(color: Colors.white),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: _size.width * .04,
                        ),
                        const Center(
                          child: Text(
                            'Login to PayPlus',
                            style: TextStyle(
                              color: const Color(0xFF652981),
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _size.width * .04,
                        ),
                        TextFieldWidget(
                          labelText: "Account No:".tr,
                          hintText: "Mobile Number".tr,
                          keyboardType: TextInputType.phone,
                          readOnly: true,

                          // onTapped: () {
                          //   FocusScope.of(context).requestFocus(FocusNode());
                          // },
                          initialValue: controller.mobileNumber.value,
                          onChanged: (input) => controller.mobileNumber.value = input,
                          // onSaved: (input) =>
                          // controller.currentUser.value.email = input,
                          // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                          // iconData: CupertinoIcons.device_phone_portrait,
                          imageData: 'assets/icons/number_pad.png',
                        ),
                        TextFieldWidget(
                          labelText: "Pin:".tr,
                          hintText: "Pin No".tr,
                          keyboardType: TextInputType.number,
                          obscureText: controller.hidePassword.value,
                          onChanged: (input) {
                            controller.password.value = input;
                          },

                          limit: 6,
                          counterText: "",
                          validator: (input) => input!.length < 4 ? "Should be more than 4 characters".tr : null,


                          // obscureText:
                          // Get.put(AuthController()).hidePassword.value,
                          // iconData: Icons.lock_outline,
                          iconData: CupertinoIcons.lock,
                          // suffixIcon: IconButton(
                          //   onPressed: () {
                          //     controller.hidePassword.value = !controller.hidePassword.value;
                          //   },
                          //   color: const Color(0xFF652981),
                          //   icon: Icon(
                          //     !controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          //     color: !controller.hidePassword.value ? const Color(0xFF652981) : Colors.grey,
                          //   ),
                          // ),
                        ),

                        // TextField(
                        //   decoration: InputDecoration(
                        //     hintText: "Email",
                        //     counterText: "",
                        //   ),
                        //   maxLength: 6,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                var data = {
                                  "mobileNumber": controller.mobileNumber.value,
                                  "imeiNumber": controller.imeiNumber.value,
                                };

                                Get.toNamed(Routes.Forget_pass_otp, arguments: data);
                                print("LoginView");
                                print(controller.mobileNumber.value);
                                print("pu pu ${controller.imeiNumber.value}");
                              },
                              child: Container(
                                child: Text(
                                  "Forget Pin?".tr,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                ),
                              ),
                            )
                          ],
                        ).paddingSymmetric(horizontal: 20),
                        SizedBox(
                          height: _size.width * .04,
                        ),
                        BlockButtonWidget(
                          onPressed: () {
                         //   FirebaseService().logCustomEvent();
                            controller.login();
                          },
                          color: const Color(0xFF652981),
                          text: Text(
                            "Login".tr,
                            style: Get.textTheme.bodyMedium!.merge(const TextStyle(color: Colors.white)),
                          ),
                        ).paddingSymmetric(vertical: _size.width * .04, horizontal: 20),

                        SizedBox(
                          height: _size.width * .08,
                        ),
                      ],
                    ),
                  ),
                ) :
                GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: SizedBox(
                    width: _size.width,
                    height: _size.height,
                    child: Stack(
                      children: [

                        Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                Container(
                                  height: _size.width,
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
                          child: Container(
                            // height: _size.width,
                            width: _size.width,
                            margin: EdgeInsets.all(_size.width * .04),
                            decoration: Ui.getBoxDecoration(color: Colors.white),
                            child: Form(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              key: controller.loginFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: _size.width * .04,
                                  ),
                                  const Center(
                                    child: Text(
                                      'Login to PayPlus',
                                      style: TextStyle(
                                        color: const Color(0xFF652981),
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _size.width * .04,
                                  ),
                                  TextFieldWidget(
                                    labelText: "Account No:".tr,
                                    hintText: "Mobile Number".tr,
                                    keyboardType: TextInputType.phone,
                                    readOnly: false,

                                    // onTapped: () {
                                    //   FocusScope.of(context).requestFocus(FocusNode());
                                    // },
                                    initialValue: controller.mobileNumber.value,
                                    onChanged: (input) => controller.mobileNumber.value = input,
                                    // onSaved: (input) =>
                                    // controller.currentUser.value.email = input,
                                    // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                                    // iconData: CupertinoIcons.device_phone_portrait,
                                    imageData: 'assets/icons/number_pad.png',
                                  ),
                                  TextFieldWidget(
                                    labelText: "Pin:".tr,
                                    hintText: "Give Your Pin".tr,
                                    keyboardType: TextInputType.number,
                                    obscureText: controller.hidePassword.value,
                                    onChanged: (input) {
                                      controller.password.value = input;
                                    },

                                    limit: 6,
                                    counterText: "",
                                    validator: (input) => input!.length < 4 ? "Should be more than 4 characters".tr : null,

                                    // obscureText:
                                    // Get.put(AuthController()).hidePassword.value,
                                    // iconData: Icons.lock_outline,
                                    iconData: CupertinoIcons.lock,
                                    // suffixIcon: IconButton(
                                    //   onPressed: () {
                                    //     controller.hidePassword.value = !controller.hidePassword.value;
                                    //   },
                                    //   color: const Color(0xFF652981),
                                    //   icon: Icon(
                                    //     !controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                    //     color: !controller.hidePassword.value ? const Color(0xFF652981) : Colors.grey,
                                    //   ),
                                    // ),
                                  ),
                                  // TextField(
                                  //   decoration: InputDecoration(
                                  //     hintText: "Email",
                                  //     counterText: "",
                                  //   ),
                                  //   maxLength: 6,
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          var data = {
                                            "mobileNumber": controller.mobileNumber.value,
                                            "imeiNumber": controller.imeiNumber.value,
                                          };

                                          Get.toNamed(Routes.Forget_pass_otp, arguments: data);
                                          print("LoginView");
                                          print(controller.mobileNumber.value);
                                          print("pu pu ${controller.imeiNumber.value}");
                                       //   controller.printSimCardsData();
                                        },
                                        child: Container(
                                          child: Text(
                                            "Forget Pin?".tr,
                                            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                          ),
                                        ),
                                      )
                                    ],
                                  ).paddingSymmetric(horizontal: 20),
                                  SizedBox(
                                    height: _size.width * .04,
                                  ),
                                  BlockButtonWidget(
                                    onPressed: () {
                                     // FirebaseService().logCustomEvent();
                                      controller.login();
                                    },
                                    color: const Color(0xFF652981),
                                    text: Text(
                                      "Login".tr,
                                      style: Get.textTheme.bodyMedium!.merge(const TextStyle(color: Colors.white)),
                                    ),
                                  ).paddingSymmetric(vertical: _size.width * .04, horizontal: 20),

                                  SizedBox(
                                    height: _size.width * .26,
                                  ),



                                  Center(child: Text('App Version:${MyData.appVersion}', style: TextStyle(fontSize: 10),))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
