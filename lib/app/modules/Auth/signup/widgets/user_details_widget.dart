import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/controllers/signup_controller.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class UserDetailsWidget extends GetWidget<SignupController> {
  late double latitude;
  late double longitude;
  var selectedAddress;
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Form(
      key: controller.userinfo,
      child: Column(
        children: [
          TextFieldWidget(
            labelText: "Personal Mobile No".tr,
            initialValue: '',
            hintText: 'Mobile'.tr,
            keyboardType: TextInputType.phone,
            limit: 11,
            // hasDropdown: true,
            onChanged: (input) => controller.userData.value.personalMobile = input,
            validator: (input) => input!.length < 11 || input.length > 11 ? 'Enter valid phone number'.tr : null,
            iconData: CupertinoIcons.device_phone_portrait,
          ),
          TextFieldWidget(
            labelText: "Outlet Name".tr,
            hintText: "Enter Outlet Name".tr,
            onChanged: (input) => controller.userData.value.outletName = input,
            validator: (input) => input!.length < 1 ? 'Please provide outlet name'.tr : null,
            iconData: null,
            imageData: 'assets/images/shop.png',
          ),
          Obx(() {
            controller.userData.value.outletAddress = 'Bangladesh';
            print("object");
            print(controller.addresses);
            controller.userData.value.outletAddress = controller.addresses.value;
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 0),
                  margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Color(0xFF652981).withOpacity(0.2), blurRadius: 2, offset: Offset(0, 2)),
                    ],
                    //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Business Type".tr,
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        height: 55,
                        color: Colors.white,
                        child: DropdownSearch<String>(
                          // mode: Mode.MENU,
                          // dropdownSearchDecoration: Ui.getInputDecoration(
                          //   hintText: '',
                          //   iconData: null,
                          //   imageData: 'assets/images/btype.png',
                          // ),
                          // showSelectedItems: true,
                          items: (filter, infiniteScrollProps) =>controller.businessTypes.isNotEmpty
                              ? controller.businessTypes!
                              .map((item) => item.type!)
                              .toList()
                              : [],
                          onChanged: (input) {
                            for (var item in controller.businessTypes) {
                              if (item.type == input) {
                                controller.userData.value.businessType = item.id!.toString();
                              }
                            }
                          },
                          selectedItem: "Select Business Type".tr,
                        ),
                      ),
                      // Text(controller.addresses.value),
                    ],
                  ),
                ),
                // Container(
                //   padding:
                //       EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 0),
                //   margin:
                //       EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10),
                //     boxShadow: [
                //       BoxShadow(
                //           color: Color(0xFF652981).withOpacity(0.2),
                //           blurRadius: 2,
                //           offset: Offset(0, 2)),
                //     ],
                //     //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     children: [
                //       Text(
                //         "Service Fee type".tr,
                //         style: Get.textTheme.bodyText1,
                //         textAlign: TextAlign.start,
                //       ),
                //       Container(
                //         height: 55,
                //         color: Colors.white,
                //         child: DropdownSearch<String>(
                //           mode: Mode.MENU,
                //           dropdownSearchDecoration: Ui.getInputDecoration(
                //             hintText: '',
                //             iconData: null,
                //             imageData: 'assets/images/btype.png',
                //           ),
                //           showSelectedItems: true,
                //           items: controller.serviceCharge
                //               .map((item) => item.service_fee_type_details!)
                //               .toList(),
                //           onChanged: (input) {
                //             for (var item in controller.serviceCharge) {
                //               if (item.service_fee_type_details == input) {
                //                 controller.userData.value.service_fee_type =
                //                     item.service_fee_type!.toString();
                //               }
                //             }
                //           },
                //           selectedItem: "Select".tr,
                //         ),
                //       ),
                //       // Container(
                //       //   height: 45,
                //       //   color: Colors.white,
                //       //   child: DropdownSearch<String>(
                //       //     mode: Mode.MENU,
                //       //     dropdownSearchDecoration: Ui.getInputDecoration(
                //       //       hintText: '',
                //       //       imageData: 'assets/images/service_fee.png',
                //       //     ),
                //       //     items: ["Daily", "Monthly", "Yearly"],
                //       //     onChanged: (input) {
                //       //       controller.userData.value.service_fee_type = input;
                //       //       print(input);
                //       //     },
                //       //     selectedItem: "Daily",
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // ),
                // TextFieldWidget(
                //   initialValue: controller.addresses.value == ''
                //       ? ''
                //       : controller.addresses.value,
                //   // readOnly: true,
                //   labelText: "Outlet Address".tr,
                //   hintText: "Enter Outlet Address".tr,
                //   // onChanged: (input) => controller.userData.value
                //   //     .outletAddress = controller.addresses.value,
                //   onChanged: (input) =>
                //       controller.userData.value.outletAddress = input,
                //   // validator: (input) => input!.length < 1
                //   //     ? 'Please provide outlet address'.tr
                //   //     : null,
                //   iconData: CupertinoIcons.location_solid,
                // )
              ],
            );
          }),
        ],
      ),
    );
  }

  Future<void> getCurrentPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('Position : $position');
      if (position != null) {
        this.latitude = position.latitude;
        this.longitude = position.longitude;
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        Placemark place = placemarks[0];
        var Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

        print(Address);

        print(latitude);
        print(longitude);
      } else {
        print('permission not allowed');
      }
    }
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      //return Future.error('Location services are disabled.');
      await Geolocator.openLocationSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        //return Future.error('Location permissions are denied');

        openAppSettings();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      openAppSettings();
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    print('location');
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true).then((Position position) {
      latitude = position.latitude;
      longitude = position.longitude;
      print(latitude);
      print(longitude);
    }).catchError((e) {
      print(e);
    });
  }
}
