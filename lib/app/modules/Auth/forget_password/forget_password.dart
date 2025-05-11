import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

final userdata = GetStorage();

class _ForgetPasswordState extends State<ForgetPassword> {
  String? new_password;
  String? confirm_password;
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text('Enter New Password'.tr),
            elevation: 0,
          ),
        ),
        body: Container(
          width: _size.width,
          margin: EdgeInsets.all(20),
          // decoration: Ui.getBoxDecoration(color: Colors.white),
          child: Form(
            // key: controller.pinFormKey,
            child: Column(
              children: [
                TextFieldWidget(
                  labelText: "Enter New Password".tr,
                  hintText: "••••••••••••".tr,
                  keyboardType: TextInputType.number,

                  onChanged: (value) {
                    setState(() {
                      this.new_password = value;
                    });
                  },

                  validator: (input) {
                    if (input!.length < 4) {
                      return "PIN should't be less than 4 characters".tr;
                    } else {
                      return null;
                    }
                  },
                  // obscureText:
                  // Get.put(AuthController()).hidePassword.value,
                  iconData: Icons.lock_outline,
                  // suffixIcon: IconButton(
                  //   onPressed: () {
                  //     // controller.hidePassword.value =
                  //     // !controller.hidePassword.value;
                  //   },
                  //   color: Color(0xFF652981),
                  //   icon: Icon(Icons.visibility_off_outlined),
                  // ),
                ),
                TextFieldWidget(
                  labelText: "Again Type Password".tr,
                  hintText: "••••••••••••".tr,
                  keyboardType: TextInputType.number,

                  onChanged: (input) {
                    setState(() {
                      this.confirm_password = input;
                    });
                  },
                  validator: (input) {
                    if (input!.length < 4) {
                      return "PIN should't be less than 4 characters".tr;
                    } else {
                      return null;
                    }
                  },
                  // obscureText:
                  // Get.put(AuthController()).hidePassword.value,
                  iconData: Icons.lock_outline,
                  // suffixIcon: Padding(
                  //   padding: const EdgeInsets.only(right: 10),
                  //   child: IconButton(
                  //     onPressed: () {
                  //       // controller.hidePassword.value =
                  //       // !controller.hidePassword.value;
                  //     },
                  //     color: Color(0xFF652981),
                  //     icon: Icon(Icons.visibility_off_outlined),
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: 10,
                ),
                BlockButtonWidget(
                  onPressed: () {
                    if (new_password == confirm_password) {
                      setNewPassword(new_password!);
                      var response = setNewPassword(new_password!);
                      var result;
                      response.then((value) => {
                            // print(value[0]['message'])
                            result = value['result'],

                            if (value['result'] == "success")
                              {
                                Get.showSnackbar(Ui.SuccessSnackBar(
                                    message: 'New Password has been set'.tr,
                                    title: 'Success'.tr)),
                                Get.offAllNamed(Routes.CHECK_PHONE_NUMBER)
                              }
                            else
                              {
                                Get.showSnackbar(Ui.ErrorSnackBar(
                                    message: 'Pass can ot be changed'.tr,
                                    title: 'Wrong Password'.tr))
                              }
                          });
                    } else {
                      Get.showSnackbar(Ui.ErrorSnackBar(
                          message: 'Pass can ot be changed'.tr,
                          title: 'Password MisMatched'.tr));
                      print("not right");
                    }
                  },
                  color: Color(0xFF652981),
                  text: Text(
                    "Register".tr,
                    style: Get.textTheme.bodyMedium!
                        .merge(TextStyle(color: Colors.white)),
                  ),
                ).paddingSymmetric(vertical: 10, horizontal: 20),
              ],
            ),
          ),
        ));
  }

  Future<Map<String, dynamic>> setNewPassword(String newPassword) async {
    var imei = userdata.read('imeiNumber');
    var mobileNumber = userdata.read('mobile_number');
    print(imei);
    var url =
        'http://103.219.160.235:8989/paystation/public/api/appapi/save-new-password';
    Map data = {
      'number': mobileNumber,
      'new_password': newPassword,
      'imei': imei,
    };
    //encode Map to JSON

    var response = await http.post(Uri.parse(url), body: data);
    var resp = json.decode(response.body);
    print(response.body);

    return resp;
  }
}
