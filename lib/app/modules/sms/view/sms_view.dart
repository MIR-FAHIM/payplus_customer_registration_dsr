import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
//import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/models/operator_model.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/recharge_drawer.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/robiAirtelOfferList.dart';
import 'package:latest_payplus_agent/app/modules/sms/controller/sms_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../../../../common/custom_data.dart';

class SMSView extends GetView<SMSController> {
  // RechargeController controller = Get.put(RechargeController());

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        // drawer: RechargeDrawer(),
        endDrawer: RechargeDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size(65, 65),
          child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF652981),
              centerTitle: true,
              title: Text('SMS'.tr),
              elevation: 0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    if (controller.contactListClicked.value == true) {
                      controller.contactListClicked.value = false;
                    } else {
                      Get.offAllNamed(Routes.ROOT);
                    }
                  }),
              actions: [
                // IconButton(
                //     onPressed: () {
                //       Get.toNamed(Routes.Notification_View);
                //     },
                //     icon: Icon(
                //       CupertinoIcons.bell,
                //       color: Colors.white70,
                //     )),
                Builder(
                  builder: (context) => // Ensure Scaffold is in context
                      IconButton(
                          onPressed: () =>
                              {Scaffold.of(context).openEndDrawer()},
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white70,
                          )),
                )
              ]),
        ),
        body: WillPopScope(
          onWillPop: () {
            if (controller.contactListClicked.value == true) {
              controller.contactListClicked.value = false;
            } else {
              Get.offAllNamed(Routes.ROOT);
            }
            return Future.value(false);
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: _size.width,
              height: _size.height,
              child: SingleChildScrollView(
                child: Obx(() {
                  if (controller.contactListClicked.value == true) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15),
                      child: Container(
                        width: size.width,
                        decoration: Ui.getBoxDecoration(
                          color: Get.theme.cardColor,
                          radius: 5,
                          //  shadowColor: Get.theme.primaryColor.withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'All Contacts',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Get.theme.disabledColor
                                        .withOpacity(0.6),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    child: TextField(
                                      onChanged: (e) {
                                        controller.setSearchText(e);
                                        // controller.contactsResult.value =
                                        //     _search(controller.contacts.value);
                                      },
                                      controller:
                                          controller.searchController.value,
                                      decoration: InputDecoration(
                                          labelText: "Search",
                                          hintText: "Search",
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)))),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.width * .04,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .7,
                                  child: Obx(() {
                                    return ListView.builder(
                                        itemCount:
                                            controller.filteredContacts.length,
                                        itemBuilder: (build, index) {
                                          var data = controller
                                              .filteredContacts[index];
                                          return InkWell(
                                            onTap: () {
                                              controller
                                                      .rechargeNumberController
                                                      .value
                                                      .text =
                                                  data.phones.first
                                                      .normalizedNumber
                                                      .substring(3, 14);
                                              controller.contactListClicked
                                                  .value = false;

                                              print(
                                                  "mobile number in contact list clicked +++++++++ ${controller.rechargeNumberController.value.text}");

                                              for (var item in operators) {
                                                print(item.name);
                                                if (controller
                                                        .rechargeNumberController
                                                        .value
                                                        .text
                                                        .length >=
                                                    3) {
                                                  if (controller
                                                          .rechargeNumberController
                                                          .value
                                                          .text
                                                          .substring(0, 3) ==
                                                      item.name) {
                                                    print(controller
                                                            .rechargeNumberController
                                                            .value
                                                            .text
                                                            .substring(0, 3) ==
                                                        item.name);
                                                    controller.simOperatorLogo
                                                        .value = item.logo!;
                                                    controller
                                                            .simOperator.value =
                                                        item.id!.toString();
                                                    Get.focusScope!.unfocus();
                                                    controller.rechargeNumber
                                                            .value =
                                                        controller
                                                            .rechargeNumberController
                                                            .value
                                                            .text;
                                                    controller.getOfferList(
                                                        controller
                                                            .simOperator.value);
                                                    controller.number_type
                                                        .value = 'Prepaid';
                                                  }
                                                }
                                              }
                                              //controller.mobileNumber.value = StaticData.mobileNofromPhone!;
                                              // controller.name.value = data.displayName;

                                              // print("123123${controller.mobileNumber.value}");
                                            },
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                  child: Icon(Icons
                                                      .verified_user_outlined)),
                                              title: Text(controller
                                                  .filteredContacts[index]
                                                  .displayName),
                                              subtitle: controller
                                                      .filteredContacts[index]
                                                      .phones
                                                      .isEmpty
                                                  ? Text("No Number")
                                                  : Text(controller
                                                      .filteredContacts[index]
                                                      .phones
                                                      .first
                                                      .number
                                                      .toString()),
                                            ),
                                          );
                                        });
                                  }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Obx(() {
                            return Column(
                              children: [
                                Container(
                                  height: Get.height * .2,
                                  child: GridView.count(
                                      scrollDirection: Axis.vertical,
                                      primary: true,
                                      shrinkWrap: true,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 2.0,
                                      childAspectRatio: 2.5,
                                      children: List.generate(8, (index) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Chip(
                                              labelStyle:
                                                  TextStyle(fontSize: 12),
                                              label: Text("01782084390"),
                                              onDeleted: () {}),
                                        );
                                      })),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          15), // Rounded corners for the card
                                    ),
                                    child: SizedBox(
                                      height: _size.width * .35,
                                      width: _size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Title and icon row
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Add Mobile Number(10/8)'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xFF652981),
                                                  ),
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Image.asset(
                                                      'assets/icons/avatar.png',
                                                      height: 30,
                                                      width: 30,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (controller.box.value
                                                        .hasData(
                                                            'contactbook')) {
                                                      controller
                                                          .getStoredData();
                                                    } else {
                                                      controller
                                                          .getPhoneContact();
                                                    }
                                                  },
                                                  child: controller.contactLoad
                                                              .value ==
                                                          false
                                                      ? Image.asset(
                                                          'assets/icons/phnbk.png',
                                                          height: 30,
                                                          width: 30,
                                                        )
                                                      : const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Color(
                                                                        0xFF652981)),
                                                          ),
                                                        ),
                                                ),
                                                SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        width: 2,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        weight: 20,
                                                        Icons.add_outlined,
                                                        color: AppColors
                                                            .primaryColor,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                                height:
                                                    10), // Space between title and input

                                            // Phone number input field
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18.0),
                                              child: SizedBox(
                                                width: _size.width *
                                                    .8, // Adjust width of the text field
                                                height: 50,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  onTap: () {
                                                    controller.keyboardText
                                                        .value = 'phone';
                                                  },
                                                  controller: controller
                                                      .rechargeNumberController
                                                      .value,
                                                  onChanged: (input) {
                                                    controller.rechargeNumber
                                                        .value = input;
                                                    for (var item
                                                        in operators) {
                                                      if (input.length >= 3 &&
                                                          input.substring(
                                                                  0, 3) ==
                                                              item.name) {
                                                        controller
                                                            .simOperatorLogo
                                                            .value = item.logo!;
                                                        controller.simOperator
                                                                .value =
                                                            item.id!.toString();
                                                      }
                                                    }
                                                    if (input.length == 11) {
                                                      Get.focusScope!.unfocus();
                                                      controller.rechargeNumber
                                                              .value =
                                                          controller
                                                              .rechargeNumberController
                                                              .value
                                                              .text;
                                                      controller.getOfferList(
                                                          controller.simOperator
                                                              .value);
                                                      controller.number_type
                                                          .value = 'Prepaid';
                                                    }
                                                  },
                                                  autofocus: controller
                                                      .autoFocus.value,
                                                  focusNode: controller
                                                      .mobileNumberFocus.value,
                                                  validator: (input) => input!
                                                              .length <
                                                          11
                                                      ? 'Please provide valid phone number'
                                                      : null,
                                                  style: const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color(0xFF652981),
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  cursorColor:
                                                      const Color(0xFF652981),
                                                  decoration: InputDecoration(
                                                    hintText: '01xxxxxxxxx',
                                                    hintStyle: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey,
                                                    ),
                                                    focusColor:
                                                        Color(0xFF652981),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF652981),
                                                          width: 2),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF652981),
                                                          width: 2),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF652981),
                                                          width: 2),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: TextFormField(
                                    // controller: controller.descController, // Uncomment and use your controller if needed
                                    keyboardType: TextInputType.text,
                                    style: Get.textTheme.bodyText2,
                                    obscureText: false,
                                    maxLines: 4,
                                    textAlign: TextAlign.start,
                                    cursorColor: Color(0xFF652981),
                                    decoration: InputDecoration(
                                      filled:
                                          true, // Enable background color filling
                                      fillColor: Colors
                                          .white, // Set background color to white
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Border radius
                                        borderSide: BorderSide(
                                          color:
                                              Color(0xFF652981), // Border color
                                          width: 2, // Border width
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Color(
                                              0xFF652981), // Border color when not focused
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Color(
                                              0xFF652981), // Border color when focused
                                          width: 2,
                                        ),
                                      ),
                                      hintText:
                                          'Enter your sms here', // Optional: Add a hint text
                                      hintStyle: TextStyle(
                                        color: Colors
                                            .grey, // Optional: Customize hint text color
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                BlockButtonWidget(
                                  onPressed: () {},
                                  color: Color(0xFF652981),
                                  text: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Text(
                                      "Send SMS".tr,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ).paddingSymmetric(
                                    vertical: 10, horizontal: 20),
                                // controller.currentPage
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            15), // Rounded corners for the card
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "You have 100 sms available."),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                    height: 20,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: Get
                                                          .theme.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Center(
                                                        child: controller
                                                                    .loading
                                                                    .value ==
                                                                true
                                                            ? Container(
                                                                height: 10,
                                                                width: 10,
                                                                child:
                                                                    CircularProgressIndicator())
                                                            : Text(
                                                                'Buy More'.tr,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ))),
                                              ),
                                            ]),
                                      )),
                                ),
                              ],
                            );
                          }),
                        ),
                        // Custom Number Pad
                      ],
                    );
                  }
                }),
              ),
            ),
          ),
        ));
  }
}
