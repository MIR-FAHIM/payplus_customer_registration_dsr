import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/account_setting_controller.dart';
import 'package:flutter/cupertino.dart';

class AccountSettingView extends GetView<AccountSettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Agent Profile'.tr),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.divisionLoaded.isTrue) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 2,
                      color: Color(0xFF652981),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl:
                          Get.find<AuthService>().currentUser.value.image!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image(
                          image: AssetImage('assets/images/user2.png'),
                        ),
                      ),
                      errorWidget: (context, url, error) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image(
                          image: AssetImage('assets/images/user2.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF652981).withOpacity(0.2),
                          blurRadius: 2,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: TextFormField(
                    //controller: controller.descController,
                    keyboardType: TextInputType.text,
                    style: Get.textTheme.bodyMedium,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    cursorColor: Color(0xFF652981),
                    onChanged: (input) {
                      controller.name.value = input;
                    },
                    decoration: InputDecoration(
                      hintText: "Agent Name".tr,
                      prefixIcon: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/user.png',
                            height: 25,
                            width: 25,
                            color: Color(0xFF652981),
                          ),
                        ),
                      ).marginAll(5),
                      contentPadding: EdgeInsets.all(0),
                      focusColor: Color(0xFF652981),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF652981).withOpacity(0.2),
                          blurRadius: 2,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: TextFormField(
                    //controller: controller.descController,
                    keyboardType: TextInputType.text,
                    style: Get.textTheme.bodyMedium,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    cursorColor: Color(0xFF652981),
                    onChanged: (input) {
                      controller.id.value = input;
                    },
                    decoration: InputDecoration(
                      hintText: "Agent ID".tr,
                      prefixIcon: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/nid.png',
                            height: 25,
                            width: 25,
                            color: Color(0xFF652981),
                          ),
                        ),
                      ).marginAll(5),
                      contentPadding: EdgeInsets.all(0),
                      focusColor: Color(0xFF652981),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF652981).withOpacity(0.2),
                          blurRadius: 2,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: TextFormField(
                    //controller: controller.descController,
                    keyboardType: TextInputType.text,
                    style: Get.textTheme.bodyMedium,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    cursorColor: Color(0xFF652981),
                    onChanged: (input) {
                      controller.email.value = input;
                    },
                    decoration: InputDecoration(
                      hintText: "Agent Email".tr,
                      prefixIcon: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/email.png',
                            height: 25,
                            width: 25,
                            color: Color(0xFF652981),
                          ),
                        ),
                      ).marginAll(5),
                      contentPadding: EdgeInsets.all(0),
                      focusColor: Color(0xFF652981),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF652981).withOpacity(0.2),
                          blurRadius: 2,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: TextFormField(
                    //controller: controller.descController,
                    keyboardType: TextInputType.text,
                    style: Get.textTheme.bodyMedium,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    cursorColor: Color(0xFF652981),
                    onChanged: (input) {
                      controller.phone.value = input;
                    },
                    decoration: InputDecoration(
                      hintText: "Agent Mobile Number".tr,
                      prefixIcon: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/hotline/call.png',
                            height: 20,
                            width: 20,
                            color: Color(0xFF652981),
                          ),
                        ),
                      ).marginAll(5),
                      contentPadding: EdgeInsets.all(0),
                      focusColor: Color(0xFF652981),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF652981),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF652981).withOpacity(0.2),
                          blurRadius: 2,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    'Agent Address'.tr,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF652981).withOpacity(0.2),
                          blurRadius: 2,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: DropdownSearch<String>(
                    // mode: Mode.MENU,
                    // showSelectedItems: true,
                    items: (filter, infiniteScrollProps) =>controller.divisions.isNotEmpty
                        ? controller.divisions!
                        .map((item) => item.divisionName!)
                        .toList()
                        : [],
                    onChanged: (input) {
                      for (var item in controller.divisions.value) {
                        if (item.divisionName == input) {
                          controller.divisionId.value = item.id!.toString();
                        }
                      }
                      controller.getDistrict();
                    },
                    selectedItem: 'Division'.tr,
                    // dropdownSearchDecoration: InputDecoration(
                    //   //   hintText: "Division".tr,
                    //   prefixIcon: Container(
                    //     height: 20,
                    //     width: 20,
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey.withOpacity(0.3),
                    //       borderRadius: BorderRadius.circular(25),
                    //     ),
                    //     child: Center(
                    //       child: Image.asset(
                    //         'assets/images/map.png',
                    //         height: 20,
                    //         width: 20,
                    //         color: Color(0xFF652981),
                    //       ),
                    //     ),
                    //   ).marginAll(5),
                    //   contentPadding: EdgeInsets.all(0),
                    //   focusColor: Color(0xFF652981),
                    //   border: OutlineInputBorder(borderSide: BorderSide.none),
                    //   focusedBorder:
                    //       OutlineInputBorder(borderSide: BorderSide.none),
                    //   enabledBorder:
                    //       OutlineInputBorder(borderSide: BorderSide.none),
                    // ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF652981).withOpacity(0.2),
                          blurRadius: 2,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: DropdownSearch<String>(
                    // mode: Mode.MENU,
                    // showSelectedItems: true,
                    items: (filter, infiniteScrollProps) =>controller.districts.isNotEmpty
                        ? controller.districts!
                        .map((item) => item.districtName!)
                        .toList()
                        : [],
                    onChanged: (input) {
                      for (var item in controller.districts.value) {
                        if (item.districtName == input) {
                          controller.districtId.value = item.id!.toString();
                        }
                      }
                      controller.getThana();
                    },
                    selectedItem: 'District'.tr,
                    // dropdownSearchDecoration: InputDecoration(
                    //   //   hintText: "Division".tr,
                    //   prefixIcon: Container(
                    //     height: 20,
                    //     width: 20,
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey.withOpacity(0.3),
                    //       borderRadius: BorderRadius.circular(25),
                    //     ),
                    //     child: Center(
                    //       child: Image.asset(
                    //         'assets/images/map.png',
                    //         height: 20,
                    //         width: 20,
                    //         color: Color(0xFF652981),
                    //       ),
                    //     ),
                    //   ).marginAll(5),
                    //   contentPadding: EdgeInsets.all(0),
                    //   focusColor: Color(0xFF652981),
                    //   border: OutlineInputBorder(borderSide: BorderSide.none),
                    //   focusedBorder:
                    //       OutlineInputBorder(borderSide: BorderSide.none),
                    //   enabledBorder:
                    //       OutlineInputBorder(borderSide: BorderSide.none),
                    // ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF652981).withOpacity(0.2),
                          blurRadius: 2,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: DropdownSearch<String>(
                    // mode: Mode.MENU,
                    // showSelectedItems: true,
                    items: (filter, infiniteScrollProps) =>controller.thanas.isNotEmpty
                        ? controller.thanas!
                        .map((item) => item.upazilaName!)
                        .toList()
                        : [],
                    onChanged: (input) {
                      for (var item in controller.thanas.value) {
                        if (item.upazilaName == input) {
                          controller.thanaId.value = item.id!.toString();
                        }
                      }
                      controller.getUnion();
                    },
                    selectedItem: 'Thana'.tr,
                    // dropdownSearchDecoration: InputDecoration(
                    //   //   hintText: "Division".tr,
                    //   prefixIcon: Container(
                    //     height: 20,
                    //     width: 20,
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey.withOpacity(0.3),
                    //       borderRadius: BorderRadius.circular(25),
                    //     ),
                    //     child: Center(
                    //       child: Image.asset(
                    //         'assets/images/map.png',
                    //         height: 20,
                    //         width: 20,
                    //         color: Color(0xFF652981),
                    //       ),
                    //     ),
                    //   ).marginAll(5),
                    //   contentPadding: EdgeInsets.all(0),
                    //   focusColor: Color(0xFF652981),
                    //   border: OutlineInputBorder(borderSide: BorderSide.none),
                    //   focusedBorder:
                    //       OutlineInputBorder(borderSide: BorderSide.none),
                    //   enabledBorder:
                    //       OutlineInputBorder(borderSide: BorderSide.none),
                    // ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF652981).withOpacity(0.2),
                          blurRadius: 2,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: DropdownSearch<String>(
                    // mode: Mode.MENU,
                    // showSelectedItems: true,
                    items: (filter, infiniteScrollProps) =>controller.unions.isNotEmpty
                        ? controller.unions!
                        .map((item) => item.unionName!)
                        .toList()
                        : [],
                    onChanged: (input) {
                      for (var item in controller.unions.value) {
                        if (item.unionName == input) {
                          controller.unionId.value = item.id!.toString();
                        }
                      }
                    },
                    selectedItem: 'Union'.tr,
                    // dropdownSearchDecoration: InputDecoration(
                    //   //   hintText: "Division".tr,
                    //   prefixIcon: Container(
                    //     height: 20,
                    //     width: 20,
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey.withOpacity(0.3),
                    //       borderRadius: BorderRadius.circular(25),
                    //     ),
                    //     child: Center(
                    //       child: Image.asset(
                    //         'assets/images/map.png',
                    //         height: 20,
                    //         width: 20,
                    //         color: Color(0xFF652981),
                    //       ),
                    //     ),
                    //   ).marginAll(5),
                    //   contentPadding: EdgeInsets.all(0),
                    //   focusColor: Color(0xFF652981),
                    //   border: OutlineInputBorder(borderSide: BorderSide.none),
                    //   focusedBorder:
                    //       OutlineInputBorder(borderSide: BorderSide.none),
                    //   enabledBorder:
                    //       OutlineInputBorder(borderSide: BorderSide.none),
                    // ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (input) {
                      controller.wordNo.value = input;
                    },
                    validator: (input) {},
                    obscureText: false,
                    initialValue: '',
                    cursorColor: Color(0xFF652981),
                    decoration: InputDecoration(
                      labelText: 'Word'.tr,
                      labelStyle: TextStyle(
                        color: Color(0xFF652981),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusColor: Color(0xFF652981),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFF652981), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          width: 2,
                          // style: BorderStyle.solid,
                          color: Color(0xFF652981),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (input) {
                      controller.permanentAddress.value = input;
                    },
                    validator: (input) {},
                    obscureText: false,
                    initialValue: '',
                    cursorColor: Color(0xFF652981),
                    decoration: InputDecoration(
                      labelText: 'Enter Permanent Address'.tr,
                      labelStyle: TextStyle(
                        color: Color(0xFF652981),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusColor: Color(0xFF652981),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFF652981), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          width: 2,
                          // style: BorderStyle.solid,
                          color: Color(0xFF652981),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (input) {
                      controller.presentAddress.value = input;
                    },
                    validator: (input) {},
                    obscureText: false,
                    initialValue: '',
                    cursorColor: Color(0xFF652981),
                    decoration: InputDecoration(
                      labelText: 'Enter Present Address'.tr,
                      labelStyle: TextStyle(
                        color: Color(0xFF652981),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusColor: Color(0xFF652981),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFF652981), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          width: 2,
                          // style: BorderStyle.solid,
                          color: Color(0xFF652981),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.saveInfoo();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 15, left: 20, right: 20),
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF652981),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF652981).withOpacity(0.2),
                            blurRadius: 2,
                            offset: Offset(0, 2)),
                      ],
                    ),
                    child: Center(
                        child: Text(
                      'Save Information'.tr,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Ui.customLoader(),
          );
        }
      }),
    );
  }
}
