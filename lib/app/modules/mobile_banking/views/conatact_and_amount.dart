import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
//import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/models/operator_model.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/controllers/mobile_banking_controller.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/widgets/mobile_bank_drawer.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/recharge_drawer.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/robiAirtelOfferList.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../../../../common/custom_data.dart';

class MBankingNumAmount extends GetView<MobileBankingController> {
  @override
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        // drawer: RechargeDrawer(),
        endDrawer: MobileBankDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size(65, 65),
          child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF652981),
              centerTitle: true,
              title: controller.currentTabIndex.value == 0
                  ? Text('Cash In'.tr)
                  : controller.currentTabIndex.value == 1
                      ? Text('Cash Out'.tr)
                      : Text('Money Out'.tr),
              elevation: 0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Get.offAllNamed(Routes.ROOT)),
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
            Get.offAllNamed(Routes.ROOT);
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
                                      controller: controller.searchController,
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
                                              controller.numberController.value
                                                      .text =
                                                  data.phones.first
                                                      .normalizedNumber
                                                      .substring(3, 14);
                                              controller.contactListClicked
                                                  .value = false;
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
                                ),
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
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Card(
                                    elevation: 2,
                                    child: SizedBox(
                                      height: _size.width * .32,
                                      width: _size.width,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Mobile Number'.tr,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 18.0,
                                                              top: 5),
                                                      child: Row(
                                                        children: [
                                                          // imageData: 'assets/icons/number_pad.png',
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (controller
                                                                  .box.value
                                                                  .hasData(
                                                                      'contactbook')) {
                                                                controller
                                                                    .getStoredData();
                                                              } else {
                                                                controller
                                                                    .getPhoneContact();
                                                              }
                                                            },
                                                            child: controller
                                                                        .contactLoad
                                                                        .value ==
                                                                    false
                                                                ? Image.asset(
                                                                    'assets/icons/phnbk.png',
                                                                    height: 30,
                                                                    width: 30,
                                                                    // color: Get.theme.primaryColor,
                                                                  )
                                                                : Center(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          10,
                                                                      width: 10,
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 25),
                                                            child: SizedBox(
                                                              // color: Colors.blue,
                                                              width:
                                                                  _size.width *
                                                                      .5,
                                                              height: 50,
                                                              child:
                                                                  TextFormField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .phone,
                                                                maxLength: controller
                                                                            .gateWayID
                                                                            .value ==
                                                                        "3"
                                                                    ? 12
                                                                    : 11,
                                                                onTap: () {
                                                                  controller
                                                                          .keyboardText
                                                                          .value =
                                                                      'phone';
                                                                },

                                                                controller:
                                                                    controller
                                                                        .numberController
                                                                        .value,
                                                                // initialValue: controller.rechargeNumber.value,
                                                                onChanged:
                                                                    (input) {
                                                                  controller
                                                                      .mobileNumber
                                                                      .value = input;
                                                                  // controller.rechargeNumberController.text = input.replaceAll('+88', '');
                                                                  // print(
                                                                  //     "++++++++ HLW BRO _____${controller.rechargeNumberController.text.substring(0, 3)}");

                                                                  print(controller
                                                                      .numberController
                                                                      .value
                                                                      .text);
                                                                  for (var item
                                                                      in operators) {
                                                                    print(item
                                                                        .name);
                                                                    if (controller
                                                                            .numberController
                                                                            .value
                                                                            .text
                                                                            .length >=
                                                                        3) {
                                                                      if (controller
                                                                              .numberController
                                                                              .value
                                                                              .text
                                                                              .substring(0, 3) ==
                                                                          item.name) {
                                                                        print(controller.numberController.value.text.substring(0,
                                                                                3) ==
                                                                            item.name);
                                                                        controller
                                                                            .simOperatorLogo
                                                                            .value = item.logo!;
                                                                        controller
                                                                            .simOperator
                                                                            .value = item.id!.toString();
                                                                      }
                                                                    }
                                                                  }
                                                                  if (controller
                                                                          .gateWayID
                                                                          .value ==
                                                                      "3") {
                                                                    if (controller
                                                                            .numberController
                                                                            .value
                                                                            .text
                                                                            .length ==
                                                                        12) {
                                                                      Get.focusScope!
                                                                          .unfocus();
                                                                      controller.mobileNumber.value = controller
                                                                          .numberController
                                                                          .value
                                                                          .text;

                                                                      controller
                                                                          .number_type
                                                                          .value = 'Prepaid';
                                                                    }
                                                                  } else {
                                                                    if (controller
                                                                            .numberController
                                                                            .value
                                                                            .text
                                                                            .length ==
                                                                        11) {
                                                                      Get.focusScope!
                                                                          .unfocus();
                                                                      controller.mobileNumber.value = controller
                                                                          .numberController
                                                                          .value
                                                                          .text;

                                                                      controller
                                                                          .number_type
                                                                          .value = 'Prepaid';
                                                                    }
                                                                  }
                                                                },

                                                                validator: (input) =>
                                                                    input!.length <
                                                                            12
                                                                        ? 'Please provide valid phone number'
                                                                        : null,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      20.0,
                                                                  color: Color(
                                                                      0xFF652981),
                                                                ),
                                                                obscureText:
                                                                    false,

                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                cursorColor:
                                                                    const Color(
                                                                        0xFF652981),
                                                                decoration:
                                                                    const InputDecoration(
                                                                  // counterText: controller
                                                                  //             .rechargeNumber
                                                                  //             .value
                                                                  //             .length >
                                                                  //         3
                                                                  //     ? controller
                                                                  //                 .rechargeNumber
                                                                  //                 .value
                                                                  //                 .length >
                                                                  //             10
                                                                  //         ? ''
                                                                  //         : 'Remain ${-(controller.rechargeNumber.value.length - 11)} number'
                                                                  //     : '',
                                                                  // counterStyle:
                                                                  //     TextStyle(
                                                                  //         color: Colors
                                                                  //             .red),
                                                                  hintText:
                                                                      '01xxxxxxxxx',
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  focusColor: Color(
                                                                      0xFF652981),
                                                                  border: OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide.none),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide.none),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 60,
                                                            width: 60,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    controller
                                                                        .imageUrl
                                                                        .value,
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: Image(
                                                                    image: AssetImage(
                                                                        'assets/images/default_image.png'),
                                                                  ),
                                                                ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: Image(
                                                                    image: AssetImage(
                                                                        'assets/images/default_image.png'),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 15,
                                ),

                                Stack(
                                  children: [
                                    Container(
                                      height: _size.width * .5,
                                      width: _size.width,
                                      decoration: Ui.getBoxDecoration(
                                          color: Colors.white, radius: 8),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              controller.amountOfferFound.isTrue
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        // buildOfferDialog(controller.amountOffer.value);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          height: 25,
                                                          width: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    width: 1,
                                                                    color: const Color(
                                                                        0xFF652981),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                          child: const Center(
                                                              child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3.0),
                                                            child: Text(
                                                              'Offer',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF652981),
                                                              ),
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    )
                                                  : Wrap(),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.amountController
                                                      .value.text = '500';
                                                  //controller.amountCheck();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height: 25,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 1,
                                                          color: const Color(
                                                              0xFF652981),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Center(
                                                        child: Padding(
                                                      padding:
                                                          EdgeInsets.all(3.0),
                                                      child: Text(
                                                        '৳ 500',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF652981),
                                                        ),
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.amountController
                                                      .value.text = '1000';
                                                  // controller.amountCheck();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height: 25,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 1,
                                                          color: const Color(
                                                              0xFF652981),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Center(
                                                        child: Padding(
                                                      padding:
                                                          EdgeInsets.all(3.0),
                                                      child: Text(
                                                        '৳ 1000',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF652981),
                                                        ),
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.amountController
                                                      .value.text = '2000';
                                                  // controller.amountCheck();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height: 25,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 1,
                                                          color: const Color(
                                                              0xFF652981),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Center(
                                                        child: Padding(
                                                      padding:
                                                          EdgeInsets.all(3.0),
                                                      child: Text(
                                                        '৳ 2000',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF652981),
                                                        ),
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Obx(() {
                                            return Container(
                                              //  height: _size.width * .4,
                                              width: _size.width * .4,
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.phone,
                                                controller: controller
                                                    .amountController.value,
                                                onTap: () {
                                                  controller.keyboardText
                                                      .value = 'amount';
                                                },
                                                autofocus: controller
                                                            .mobileNumber
                                                            .value
                                                            .length ==
                                                        11
                                                    ? true
                                                    : false,
                                                onChanged: (input) {
                                                  // controller.amount.value = input;
                                                  // controller.amountCheck();
                                                  // controller.getCommission();
                                                },
                                                // validator: (input) => double.parse(input!.toString()) < 2 ? 'Minimum recharge amount is TK 2'.tr : null,
                                                style: const TextStyle(
                                                  fontSize: 35.0,
                                                  color: Color(0xFF652981),
                                                ),
                                                obscureText: false,

                                                textAlign: TextAlign.center,
                                                cursorColor:
                                                    const Color(0xFF652981),
                                                decoration:
                                                    const InputDecoration(
                                                  labelStyle:
                                                      TextStyle(fontSize: 35),
                                                  hintText: '৳ 0',
                                                  hintStyle:
                                                      TextStyle(fontSize: 35),
                                                  focusColor:
                                                      const Color(0xFF652981),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                ),
                                              ),
                                            );
                                          }),
                                          GestureDetector(
                                            onTap: () {
                                              if (controller.gateWayID.value ==
                                                  "3") {
                                                print("iam here");
                                                if (controller
                                                        .amountController
                                                        .value
                                                        .text
                                                        .isNotEmpty &&
                                                    controller
                                                            .numberController
                                                            .value
                                                            .text
                                                            .length ==
                                                        12) {
                                                  controller.getCommision(
                                                      amount: controller
                                                          .amountController
                                                          .value
                                                          .text,
                                                      type: (controller
                                                                  .currentTabIndex
                                                                  .value +
                                                              1)
                                                          .toString(),
                                                      gatewayId: controller
                                                          .gateWay.value);

                                                  //  Get.toNamed(Routes.MBANKINGFAIL,);
                                                } else {
                                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                                      message:
                                                          "Please provide valid amount and Rocket number",
                                                      title: 'Error'.tr));
                                                }
                                              } else {
                                                if (controller
                                                        .amountController
                                                        .value
                                                        .text
                                                        .isNotEmpty &&
                                                    controller
                                                            .numberController
                                                            .value
                                                            .text
                                                            .length >=
                                                        11) {
                                                  controller.getCommision(
                                                      amount: controller
                                                          .amountController
                                                          .value
                                                          .text,
                                                      type: (controller
                                                                  .currentTabIndex
                                                                  .value +
                                                              1)
                                                          .toString(),
                                                      gatewayId: controller
                                                          .gateWay.value);

                                                  //  Get.toNamed(Routes.MBANKINGFAIL,);
                                                } else {
                                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                                      message:
                                                          "Please provide valid amount and phone number",
                                                      title: 'Error'.tr));
                                                }
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.0, right: 15),
                                              child: Image(
                                                height: 35,
                                                width: 35,
                                                image: AssetImage(
                                                    'assets/images/arrow_for.png'),
                                                color: Color(0xFF652981),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child:
                                              //  Text(
                                              //   'Your Balance: ৳ ${Get.find<HomeController>().balance.value}',
                                              //   style: TextStyle(color: Color(0xFF652981)),
                                              // ),
                                              Text(
                                            'Your Balance: ৳ ${Get.find<HomeController>().balance}',
                                            style: const TextStyle(
                                                color: Color(0xFF652981)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // GestureDetector(
                                //   onTap: () {
                                //     controller.increment();
                                //   },
                                //   child: Row(
                                //     children: [
                                //       Icon(
                                //         Icons.add_circle_outline,
                                //         color: Color(0xFF652981),
                                //         size: 30,
                                //       ),
                                //       SizedBox(
                                //         width: 10,
                                //       ),
                                //       Text(
                                //         'Add Another Number'.tr,
                                //         style: TextStyle(color: Color(0xFF652981), fontSize: 16),
                                //       )
                                //     ],
                                //   ),
                                // ),

                                // controller.currentPage
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

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }
}
