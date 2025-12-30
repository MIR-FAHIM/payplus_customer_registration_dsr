import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:latest_payplus_agent/app/models/icon_model.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';

import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckPhoneNumber extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  height: Get.size.width * .5,
                  width: Get.size.width * .6,
                  child: Image(
                    image: AssetImage('assets/Logow.png'),
                    color: Color(0xFF652981),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  10.0,
                ),
                child: Text(
                  'Login / Register with mobile number'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 0),
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF652981).withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0, 2)),
                  ],
                  //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Registration Mobile No".tr,
                      style: Get.textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.size.width * .6,
                          child: PhoneFieldHint(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              onChanged: (input) {
                                controller.userData.value.customerMobileNumber =
                                    input;
                                print(input);
                                print(controller
                                    .userData.value.customerMobileNumber!
                                    .substring(3, 6));
                                for (var item in simOperators) {
                                  print(item.title);
                                  if (controller.userData.value
                                          .customerMobileNumber!.length >
                                      3) {
                                    if (controller.userData.value
                                            .customerMobileNumber!
                                            .substring(3, 6) ==
                                        item.title) {
                                      print(controller.userData.value
                                              .customerMobileNumber!
                                              .substring(3, 6) ==
                                          item.title);
                                      controller.simOperator.value =
                                          item.image!;
                                    }
                                  }
                                }
                              },
                              controller: controller.textEditingController,
                              style: Get.textTheme.bodyMedium,
                              obscureText: false,
                              textAlign: TextAlign.start,
                              cursorColor: Color(0xFF652981),
                              decoration: Ui.getInputDecoration(
                                hintText: '',
                                iconData: CupertinoIcons.device_phone_portrait,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: controller.simOperator.value != ''
                                ? Image.asset(
                                    controller.simOperator.value,
                                    height: 25,
                                    width: 25,
                                  )
                                : Text(controller.simOperator.value)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width - 40,
                    child: Center(
                      child: CheckboxListTile(
                        title: GestureDetector(
                          onTap: (){
                            launchURL();
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
                            print("my term $newValue and check ${controller.checkTerm.value}");

                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Get.offAllNamed(Routes.SIGNUP);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF652981),
                    size: 30,
                  ),
                ),
              ))
        ],
      ),
      // bottomNavigationBar: Container(
      //   height: 60,
      //   child: Stack(
      //     children: [
      //       Container(
      //         width: Get.size.width,
      //         height: 60,
      //         color: Colors.white,
      //       ),
      //
      //     ],
      //   ),
      // ),
    );
  }
  launchURL() async {

    const String homeLat = "23.788598";
    const String homeLng = "90.418556";

    final String googleMapslocationUrl = "https://www.paystation.paypos.reg/privacy-policy.php";
    final String urlString = "https://raw.githubusercontent.com/musabbir-mamun/app-privacy-policy/master/paystation/paystation.html";


    final String encodedURl = Uri.encodeFull(urlString);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }
}
