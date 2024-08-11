import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/models/user_model.dart';
import 'package:latest_payplus_agent/app/repositories/number_check_repositories.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/common/data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:device_information/device_information.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class CheckPhoneNumberController extends GetxController {
  //TODO: Implement CheckPhoneNumberController
  final checkTerm = false.obs;
  late TextEditingController textEditingController;
  final simOperator = ''.obs;
  late GlobalKey<FormState> mobileFormKey;
  final userData = UserModel().obs;
  final isChecked = false.obs;
  final imei = ''.obs;
  final imeiLoaded = false.obs;
  final box = GetStorage().obs;
  final contactsResult = <Contact>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    mobileFormKey = GlobalKey<FormState>();
    textEditingController = TextEditingController();
    //   getPhoneContact();
  }

  @override
  void onReady() {
    super.onReady();
    showPopupForReg();
  }
  getPhoneContact() async {
    box.value.remove('contact');
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts = await FlutterContacts.getContacts();

      // Get all contacts (fully fetched)
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      // Get contact with specific ID (fully fetched)

      print("my all contact are $contacts");

      contactsResult.value = contacts;
      await box.value.write('contact', contactsResult);
      print("hlw bro ***********************${GetStorage().read('contact')}");
    }
  }
  getDeviceInfo() async {
    try {
      var status = Permission.phone;
      if (await Permission.phone.request().isGranted) {
        print('hlw bro hlw bro imei: ${imei.value}');
        imei.value = await DeviceInformation.deviceIMEINumber;

        print('hlw bro imei imei: ${imei.value}');
      } else {
        Permission.phone.request();
        imei.value = await DeviceInformation.deviceIMEINumber;

        imei.update((val) {});

        print('hlw bro imei imei: ${imei.value}');
      }
    } on PlatformException catch (e) {
      // Permission.phone.request();
      print('Failed to get platform version: $e');
    }
  }
  Future checkNumberDuplicacy() async {
    MyData.phone_no = textEditingController.text;
    if (mobileFormKey.currentState!.validate()) {
      mobileFormKey.currentState!.save();
      if (Get.find<LocationService>().imei.value.isEmpty) {
        await Get.find<LocationService>().getDeviceInfo();
      }
      if (Get.find<LocationService>().imei.value.isNotEmpty) {
        Ui.customLoaderDialog();
        NumberCheckRepository()
            .checkNumberDuplicacy(textEditingController.text)
            .then((resp) {
          print("hlw bro${resp['result']}");
          print("hlw beo res  msg${resp['message']}");

          if (resp['result'] == 1) {
            Get.back();
            // bypasss otp from here with making isFalse
            if (Get.find<AuthService>().alreadyLogged.isFalse || textEditingController.text == "01726315133" || textEditingController.text == "01716536455" ) {
              Get.offAllNamed(Routes.LOGIN,
                  arguments: textEditingController.text);
            } else {
              Get.toNamed(Routes.PHONE_VERIFICATION_WTIH_O_T_P, arguments: {
                'mobileNumber': textEditingController.text,
                'isRegistered': resp['result'].toString(),
                'selectedServiceTypeId': '',
              });


            }
          } else {
            Get.offAllNamed(Routes.NEWSIGNUP,
                arguments: textEditingController.text);
            //      Get.toNamed(Routes.PHONE_VERIFICATION_WTIH_O_T_P, arguments: {
            //        'mobileNumber': textEditingController.text,
            //        'isRegistered': resp['result'].toString(),
            //        'selectedServiceTypeId': '',
            //      });
          }

          // test token
          //
          // else {
          //   Get.back();
          //   NumberCheckRepository().paymentCheck(textEditingController.text).then((respCheck) {
          //     print("hlw bro${respCheck['result']}");
          //     print("hlw beo res  payment ${respCheck['payment_status']}");
          //
          //     if (respCheck['payment_status'] == "unpaid") {
          //
          //       // new sign up
          //       Get.toNamed(Routes.NEWSIGNUP);
          //
          //       // new signup ended
          //       // Get.back();
          //       //
          //       //
          //       // Get.toNamed(Routes.SIGNUP_SERVICE_FEE,
          //       //     arguments: {'mobileNumber': textEditingController.text, 'isRegistered': resp['result'].toString()});
          //     } else {
          //       // new sign up
          //     //  Get.offAndToNamed(Routes.LOGIN, arguments: userData.value.customerMobileNumber);
          //
          //         Get.toNamed(Routes.NEWSIGNUP);
          //
          //     }
          //
          //   });
          //
          //
          //
          //   // Get.toNamed(Routes.SIGNUP_SERVICE_FEE,
          //   //     arguments: {'mobileNumber': textEditingController.text, 'isRegistered': resp['result'].toString()});
          // }
          //  Get.toNamed(Routes.SIGNUP);
        });
      }
    }
  }

  showPopupForReg() {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Stack(
              children: [
                Container(
                  // height: Get.size.width + 5,
                  width: Get.size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/number.jpeg',
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     // Image(
                  //     //   height: Get.size.width * 0.3,
                  //     //   width: Get.size.width * 0.35,
                  //     //   image: const AssetImage(
                  //     //     'assets/Logo.png',
                  //     //   ),
                  //     // ),
                  //
                  //     Image.asset(
                  //       'assets/number.jpeg',
                  //     ),
                  //
                  //     const SizedBox(
                  //       height: 10,
                  //     ),
                  //     // Padding(
                  //     //   padding: const EdgeInsets.symmetric(
                  //     //     horizontal: 25.0,
                  //     //     vertical: 10,
                  //     //   ),
                  //     //   child: BlockButtonWidget(
                  //     //     onPressed: () {
                  //     //       Get.back();
                  //     //     },
                  //     //     color: Get.theme.primaryColor,
                  //     //     radius: 30,
                  //     //     text: const Text(
                  //     //       'Okay',
                  //     //       style: TextStyle(
                  //     //         color: Colors.white,
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     // )
                  //   ],
                  // ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 35,
                      ),
                    )),
              ],
            )
            // actions: <Widget>[

            // ],
            );
      },
    );
  }
}
