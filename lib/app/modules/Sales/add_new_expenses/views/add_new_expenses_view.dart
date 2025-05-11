import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:latest_payplus_agent/app/models/buysell/expense_head_data.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/add_new_expenses_controller.dart';

class AddNewExpensesView extends GetView<AddNewExpensesController> {
  AddNewExpensesView({Key? key}) : super(key: key);
  PickedFile? imageFile = null;
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final _size = Get.size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(65, 65),
          child: AppBar(
            backgroundColor: const Color(0xFF652981),
            centerTitle: true,
            title: Text('Add New Expense'.tr),
            elevation: 0,
          ),
        ),
        body: Obx(() {
          if (controller.expenseHeadLoaded.isTrue) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: [
                  SizedBox(
                    width: _size.width,
                    height: _size.height,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 20, right: 20),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Column(
                          //         children: [
                          //           Padding(
                          //             padding: const EdgeInsets.only(top: 15),
                          //             child: Text(
                          //               'Select'.tr,
                          //               style: TextStyle(
                          //                   color: AppColors.homeTextColor3,
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 12),
                          //             ),
                          //           ),
                          //           GestureDetector(
                          //             onTap: () {
                          //               controller.selectDate(context);
                          //             },
                          //             child: Container(
                          //               margin: EdgeInsets.only(top: 3),
                          //               width:
                          //                   MediaQuery.of(context).size.width * 0.42,
                          //               decoration: BoxDecoration(
                          //                 color: AppColors.primarydeepLightColor,
                          //                 borderRadius: BorderRadius.circular(10),
                          //               ),
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: controller.expensDate.isNotEmpty
                          //                     ? Center(
                          //                         child: Text(
                          //                             controller.expensDate.value))
                          //                     : Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.center,
                          //                         children: [
                          //                           SizedBox(width: 20),
                          //                           Image.asset(
                          //                             'assets/icons/calender.png',
                          //                             height: 10,
                          //                             width: 10,
                          //                             color: AppColors.homeTextColor1,
                          //                           ),
                          //                           IconGap(),
                          //                           Text(
                          //                             "তারিখ",
                          //                             style: TextStyle(
                          //                                 color: AppColors
                          //                                     .homeTextColor1,
                          //                                 fontWeight: FontWeight.w400,
                          //                                 fontSize: 13),
                          //                           ),
                          //                           SizedBox(width: 20),
                          //                           Image.asset(
                          //                             'assets/icons/down_arrow.png',
                          //                             height: 10,
                          //                             width: 10,
                          //                             color: AppColors.homeTextColor1,
                          //                           ),
                          //                         ],
                          //                       ),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    'Recipt Picture'.tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.homeTextColor2),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getImage(ImageSource.camera);
                                  },
                                  child: controller.image.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image(
                                            height: 130,
                                            width: 160,
                                            image: FileImage(controller.image.first),
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : Container(
                                          height: 130,
                                          width: 160,
                                          decoration: BoxDecoration(
                                            color: AppColors.primarydeepLightColor,
                                            borderRadius: BorderRadius.circular(30),
                                            border: Border.all(
                                              color: AppColors.primaryColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: (imageFile == null)
                                              ? Icon(Icons.camera_alt,
                                                  color: AppColors.primaryColor, size: 45)
                                              : ClipOval(
                                                  child: Image.file(
                                                  File(imageFile!.path),
                                                  width: 130,
                                                  height: 130,
                                                  fit: BoxFit.cover,
                                                )),
                                        ),
                                )
                              ],
                            ),
                          ),

                          // Column(
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.only(top: 15),
                          //       child: Text(
                          //         'Select'.tr,
                          //         style: TextStyle(
                          //             color: AppColors.homeTextColor3,
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 12),
                          //       ),
                          //     ),
                          //     Container(
                          //       margin: EdgeInsets.only(top: 3),
                          //       width: MediaQuery.of(context).size.width * 0.42,
                          //       height: 35,
                          //       decoration: BoxDecoration(
                          //         color: AppColors.homeCardBg,
                          //         border: Border.all(
                          //             color: Theme.of(context).primaryColor,
                          //             width: 1),
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: DropdownSearch<String>(
                          //           mode: Mode.MENU,
                          //           dropdownSearchDecoration: const InputDecoration(
                          //             contentPadding: EdgeInsets.all(0),
                          //             focusColor: Color(0xFF652981),
                          //             border: OutlineInputBorder(
                          //                 borderSide: BorderSide.none),
                          //             focusedBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide.none),
                          //             enabledBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide.none),
                          //           ),
                          //           showSelectedItems: true,
                          //           items: controller.expenseHeads.value.data!
                          //               .map((item) => item.expenseHead!)
                          //               .toList(),
                          //           onChanged: (input) {
                          //             for (var item
                          //                 in controller.expenseHeads.value.data!) {
                          //               if (item.expenseHead == input) {}
                          //             }
                          //           },
                          //           selectedItem: "Select Selection".tr,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 14, left: 20, right: 0),
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xFF652981).withOpacity(0.2),
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)),
                              ],
                              //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Select Type".tr,
                                  style: Get.textTheme.bodyMedium,
                                  textAlign: TextAlign.start,
                                ),
                                Container(
                                  height: 55,
                                  color: Colors.white,
                                  child: DropdownSearch<String>(
                                    // mode: Mode.MENU,
                                    // dropdownSearchDecoration: const InputDecoration(
                                    //   contentPadding: EdgeInsets.all(0),
                                    //   focusColor: Color(0xFF652981),
                                    //   border:
                                    //       OutlineInputBorder(borderSide: BorderSide.none),
                                    //   focusedBorder:
                                    //       OutlineInputBorder(borderSide: BorderSide.none),
                                    //   enabledBorder:
                                    //       OutlineInputBorder(borderSide: BorderSide.none),
                                    // ),
                                    // showSelectedItems: true,
                                    items: (filter, infiniteScrollProps) =>["Personal","Business" ]
                                        .map((item) => item!)
                                        .toList()
                                       ,
                                    onChanged: (input) {
                                      controller.type.value = input!;
                                    },
                                    selectedItem: controller.type.value,
                                  ),
                                ),
                                // Text(controller.addresses.value),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 14, left: 20, right: 0),
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xFF652981).withOpacity(0.2),
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)),
                              ],
                              //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Select Expense Date".tr,
                                  style: Get.textTheme.bodyMedium,
                                  textAlign: TextAlign.start,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.selectDate(context);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: controller.expensDate.isNotEmpty
                                          ? Text(controller.expensDate.value)
                                          : Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  'assets/icons/calender.png',
                                                  height: 10,
                                                  width: 10,
                                                  color: AppColors.homeTextColor1,
                                                ),
                                                IconGap(),
                                                Text(
                                                  "Expense Date".tr,
                                                  style: TextStyle(
                                                      color: AppColors.homeTextColor1,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 13),
                                                ),
                                                const SizedBox(width: 20),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                                // Text(controller.addresses.value),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 14, left: 20, right: 0),
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xFF652981).withOpacity(0.2),
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)),
                              ],
                              //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Select".tr,
                                  style: Get.textTheme.bodyMedium,
                                  textAlign: TextAlign.start,
                                ),
                                Container(
                                  height: 45,
                                  color: Colors.white,
                                  child: DropdownSearch<String>(
                                    // mode: Mode.MENU,
                                    // dropdownSearchDecoration: Ui.getInputDecorationWithIcon(
                                    //   hintText: '',
                                    // ),
                                    // showSelectedItems: true,
                                    items: (filter, infiniteScrollProps) =>["c1","c2"].isNotEmpty
                                        ? ["c1","c2"]
                                        .map((item) => item!)
                                        .toList()
                                        : [],
                                    // controller.businessTypes
                                    //     .map((item) => item.type!)
                                    //     .toList(),
                                    //
                                    onChanged: (input) {

                                    },
                                    selectedItem:
                                    "Select Product Measurement Unit"
                                        .tr,
                                  ),
                                ),

                                // Text(controller.addresses.value),
                              ],
                            ),
                          ),
                          TextFieldWidget(
                            // keyboardType: numberFormatSymbols,
                            labelText: "Expense Amount".tr,
                            hintText: "Enter Expense Amount".tr,
                            onChanged: (input) {
                              controller.expenseAmount.value = input;
                            },

                            // onSaved: (input) =>
                            // controller.currentUser.value.email = input,
                            // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                            keyboardType: TextInputType.number,
                            iconData: null,
                            imageData: 'assets/icons/price.png',
                          ),
                          TextFieldWidget(
                            // keyboardType: numberFormatSymbols,
                            labelText: "Expense Reason".tr,
                            hintText: "Enter Expense Reason".tr,
                            onChanged: (value) {
                              controller.expensesReason.value = value;
                            },

                            // onSaved: (input) =>
                            // controller.currentUser.value.email = input,
                            // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                            keyboardType: TextInputType.text,
                            iconData: null,
                            imageData: 'assets/icons/expense.png',
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(15.0),
                          //   child: InkWell(
                          //     onTap: () {
                          //       // Get.toNamed(Routes.Add_New_Product);
                          //     },
                          //     child: Container(
                          //       width: _size.width,
                          //       height: _size.width * .1,
                          //       decoration: Ui.getBoxDecoration(
                          //           color: Color(0xFF652981), radius: 10),
                          //       child: Center(
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(left: 5),
                          //           child: Text(
                          //             'Add'.tr,
                          //             style: TextStyle(
                          //               color: Colors.white,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )

                          SizedBox(
                            height: _size.width * .25,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          controller.addNewExpenses();
                        },
                        child: Container(
                          width: _size.width,
                          height: _size.width * .1,
                          decoration: Ui.getBoxDecoration(
                              color: const Color(0xFF652981), radius: 10),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Add'.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Ui.customLoader());
          }
        }));
  }

  void _openCamera(BuildContext context) async {
    final serviceStatus = await Permission.camera.isGranted;

    bool isCameraOn = serviceStatus == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      // Ui.customLoaderDialog();

      // setState(() {
      //   imageFile = pickedFile!;
      // });

      // Navigator.pop(context);
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  SizedBox IconGap() {
    return const SizedBox(
      width: 4,
    );
  }
}
