import 'dart:ui';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/operator_model.dart';
import 'package:latest_payplus_agent/app/modules/add_balance/controllers/add_balance_controller.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/views/pin_code_numberList.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/cash_back_widget.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/recharge_drawer.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../../../../common/custom_data.dart';
import '../controllers/recharge_controller.dart';

class RechargeView extends GetView<RechargeController> {
  // RechargeController controller = Get.put(RechargeController());
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return GetBuilder<RechargeController>(builder: (ct) {
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
                title: Column(
                  children: [
                    Text('Mobile Recharge'.tr),
                    Text(
                      'Your Balance: ৳ ${Get.find<HomeController>().balance.value}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                elevation: 0,
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
                //controller.refresh();
                controller.rechargeNumberObjectList.value.clear();
                controller.listOfNumberFocus.value.clear();
                controller.listOfFocusNodeAmount.value.clear();
                controller.numberControllerList.value.clear();
                controller.amountControllerList.value.clear();


                controller.rechargeNumberObjectList.value.add(RechargeViewModel(
                  number: "",
                  logo: "",
                  package: "",
                  validity: "",
                  operatorID: "",
                  amount: "",
                  commision: "",
                  readOnly: false,
                  isExpanded: false,
                ));
                controller.numberControllerList.value.add(Rx(TextEditingController()));
                controller.amountControllerList.value.add(Rx(TextEditingController()));
                controller.listOfNumberFocus.add(Rx(FocusNode()));
                controller.listOfFocusNodeAmount.add(Rx(FocusNode()));
                controller.moveFocus(controller.listOfNumberFocus.first.value);
                controller.refresh();
                controller.currentIndex.value = 0;
                Get.back();
              }
              return Future.value(false);
            },
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Obx(() {
                return SingleChildScrollView(
                    child: controller.contactListClicked.value == true
                        ? Padding(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // controller.updateAmountAtIndex(
                                          //     controller.selectedIndex.value ,
                                          //     "100");
                                          // controller.contactListClicked
                                          //     .value = false;
                                        },
                                        child: Text(
                                          'All Contacts',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: Get.theme.disabledColor
                                                .withOpacity(0.6),
                                          ),
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
                                            controller: controller
                                                .searchController.value,
                                            decoration: InputDecoration(
                                                labelText: "Search",
                                                hintText: "Search",
                                                prefixIcon: Icon(Icons.search),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25.0)))),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.width * .04,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .7,
                                        child: Obx(() {
                                          return ListView.builder(
                                              itemCount: controller
                                                  .filteredContacts.length,
                                              itemBuilder: (build, index) {
                                                var data = controller
                                                    .filteredContacts[index];
                                                return InkWell(
                                                  onTap: () {
                                                    controller
                                                            .numberControllerList[
                                                                controller
                                                                    .selectedIndex
                                                                    .value]
                                                            .value
                                                            .text =
                                                        data.phones.first
                                                            .normalizedNumber
                                                            .substring(3, 14);
                                                    String phoneNumFromDevice =
                                                        controller
                                                            .numberControllerList[
                                                                controller
                                                                    .selectedIndex
                                                                    .value]
                                                            .value
                                                            .text;
                                                    controller
                                                        .updateNumberAtIndex(
                                                            controller
                                                                .selectedIndex
                                                                .value,
                                                            phoneNumFromDevice);

                                                    print(
                                                        "mobile number in contact list clicked +++++++++ ${controller.rechargeNumberController.value.text}");

                                                    for (var item
                                                        in operators) {
                                                      print(item.name);
                                                      if (phoneNumFromDevice
                                                              .length >=
                                                          3) {
                                                        if (phoneNumFromDevice
                                                                .substring(
                                                                    0, 3) ==
                                                            item.name) {
                                                          print(
                                                              phoneNumFromDevice
                                                                      .substring(
                                                                          0,
                                                                          3) ==
                                                                  item.name);
                                                          controller
                                                              .simOperatorLogo
                                                              .value = item.logo!;
                                                          controller.simOperator
                                                                  .value =
                                                              item.id!
                                                                  .toString();

                                                          controller
                                                                  .rechargeNumber
                                                                  .value =
                                                              controller
                                                                  .rechargeNumberController
                                                                  .value
                                                                  .text;
                                                          controller.getOfferList(
                                                              controller
                                                                  .simOperator
                                                                  .value);
                                                          controller.number_type
                                                                  .value =
                                                              'Prepaid';
                                                        }
                                                      }
                                                    }
                                                    controller
                                                        .updateLogoAtIndex(
                                                            controller
                                                                .selectedIndex
                                                                .value,
                                                            controller
                                                                .simOperatorLogo
                                                                .value);

                                                    controller
                                                        .updateOperatorIDAtIndex(
                                                            controller
                                                                .selectedIndex
                                                                .value,
                                                            controller
                                                                .simOperator
                                                                .value);
                                                    controller
                                                        .contactListClicked
                                                        .value = false;
                                                    FocusScope.of(context)
                                                        .requestFocus(controller
                                                            .listOfFocusNodeAmount[
                                                                controller
                                                                    .selectedIndex
                                                                    .value]
                                                            .value);
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
                                                            .filteredContacts[
                                                                index]
                                                            .phones
                                                            .isEmpty
                                                        ? Text("No Number")
                                                        : Text(controller
                                                            .filteredContacts[
                                                                index]
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
                          )
                        : Column(
                            children: [
                              // Text(controller.rechargeNumberObjectList
                              //     .value.length.toString()),
                              SizedBox(
                                height: controller.rechargeNumberObjectList
                                            .value.length ==
                                        1
                                    ? Get.height * .23
                                    : controller.rechargeNumberObjectList.value
                                                .length ==
                                            2
                                        ? Get.height * .35
                                        : controller.rechargeNumberObjectList
                                                    .value.length ==
                                                3
                                            ? Get.height * .46
                                            : controller.rechargeNumberObjectList
                                                        .value.length ==
                                                    4
                                                ? Get.height * .57
                                                : Get.height * .69,
                                child: Obx(() {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller
                                        .rechargeNumberObjectList.value.length,
                                    itemBuilder: (c, i) {
                                      var data = controller
                                          .rechargeNumberObjectList.value[i];

                                      return Obx(() {
                                        return InkWell(
                                          onTap: () {
                                            controller.currentIndex.value = 0;
                                            print(
                                                "current index is ${controller.currentIndex.value.toString()}");
                                            controller.selectedIndex.value = i;
                                            controller.simOperator.value =
                                                data.operatorID!;
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: Get.height * .12,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: controller
                                                                .selectedIndex
                                                                .value ==
                                                            i
                                                        ? AppColors
                                                            .primaryLightColor
                                                        : Colors.white,
                                                    border: Border.all(
                                                      color: controller
                                                                  .selectedIndex
                                                                  .value ==
                                                              i
                                                          ? AppColors
                                                              .primaryColor
                                                              .withOpacity(.5)
                                                          : AppColors
                                                              .primarydeepLightColor,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: _size.width *
                                                                .6,
                                                            height: Get.height *
                                                                .08,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border
                                                                        .all(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                0),
                                                                        topLeft:
                                                                            Radius.circular(8))),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                // logo first
                                                                data.logo !=
                                                                            '' &&
                                                                        data.number
                                                                            .toString()
                                                                            .isNotEmpty
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          showOperatorLogo(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              Get.width * .1,
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.grey.shade100,
                                                                                  borderRadius: BorderRadius.circular(50),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(2.0),
                                                                                  child: Image.asset(
                                                                                    data.number.toString().isNotEmpty ? data.logo! : '',
                                                                                    height: 30,
                                                                                    width: 30,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Positioned(
                                                                                top: 0,
                                                                                right: 0,
                                                                                child: Container(
                                                                                  height: 15,
                                                                                  width: 15,
                                                                                  decoration: const BoxDecoration(
                                                                                    color: Color(0xFF652981),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: const Center(
                                                                                    child: Icon(
                                                                                      Icons.edit,
                                                                                      size: 10,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        width: Get.width *
                                                                            .1,
                                                                        height: Get.height *
                                                                            .05,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade100,
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                        ),
                                                                        child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(2.0),
                                                                            child: Center(child: Text(".."))),
                                                                      ),
                                                                Container(
                                                                  width: 1,
                                                                  height:
                                                                      Get.height *
                                                                          .06,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                                // number box
                                                                InkWell(
                                                                  onTap: () {
                                                                    controller
                                                                        .isPackage
                                                                        .value = false;
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    // color: Colors.blue,
                                                                    width: _size
                                                                            .width *
                                                                        .38,

                                                                    child: controller.isPackage.value ==
                                                                            false
                                                                        ? TextFormField(
                                                                            controller:
                                                                                controller.numberControllerList.value[i].value,

                                                                            // autofocus:
                                                                            //     true,
                                                                            maxLength:
                                                                                11,

                                                                            validator:
                                                                                (input) {
                                                                              if (input == null || input.length < 11) {
                                                                                return 'Please provide a valid phone number';
                                                                              } else {}
                                                                              return null;
                                                                            },
                                                                            onFieldSubmitted:
                                                                                (v) {
                                                                              controller.currentIndex.value = 0;

                                                                              FocusScope.of(context).requestFocus(controller.listOfFocusNodeAmount[i].value);
                                                                            },
                                                                            keyboardType:
                                                                                TextInputType.phone,
                                                                            onTap:
                                                                                () {
                                                                              FocusScope.of(context).requestFocus(controller.listOfNumberFocus[i].value);
                                                                              controller.currentIndex.value = 0;
                                                                              controller.selectedIndex.value = i;
                                                                              controller.keyboardText.value = 'phone';
                                                                            },
                                                                            //  initialValue: data.number,

                                                                            onChanged:
                                                                                (input) {
                                                                              controller.rechargeNumber.value = controller.numberControllerList.value[i].value.text;
                                                                              print("number is ${controller.rechargeNumber.value}");

                                                                              // controller.rechargeNumberController.text = input.replaceAll('+88', '');
                                                                              // print(
                                                                              //     "++++++++ HLW BRO _____${controller.rechargeNumberController.text.substring(0, 3)}");
                                                                              if (controller.rechargeNumber.value.length == 11) {
                                                                                // Get.focusScope!
                                                                                //     .unfocus();
                                                                                FocusScope.of(context).requestFocus(controller.listOfFocusNodeAmount[i].value);
                                                                                controller.getOfferList(controller.simOperator.value);
                                                                                controller.number_type.value = 'Prepaid';

                                                                                if (controller.rechargeNumberObjectList.value.any((element) => element.number == controller.rechargeNumber.value)) {
                                                                                  Get.showSnackbar(Ui.ErrorSnackBar(message: 'Number already exist.'.tr, title: 'Error'.tr));
                                                                                } else {
                                                                                  controller.updateNumberAtIndex(i, controller.rechargeNumber.value);
                                                                                }
                                                                              }
                                                                              print(controller.rechargeNumber.value);
                                                                              for (var item in operators) {
                                                                                print(item.name);
                                                                                if (controller.rechargeNumber.value.length >= 3) {
                                                                                  if (controller.rechargeNumber.value.substring(0, 3) == item.name) {
                                                                                    print(controller.rechargeNumber.value.substring(0, 3) == item.name);
                                                                                    controller.simOperatorLogo.value = item.logo!;
                                                                                    controller.simOperator.value = item.id!.toString();

                                                                                    controller.getCashBackOffer();

                                                                                    controller.updateLogoAtIndex(i, controller.simOperatorLogo.value);

                                                                                    controller.updateOperatorIDAtIndex(i, controller.simOperator.value);
                                                                                  }
                                                                                }
                                                                              }
                                                                            },
                                                                            focusNode:
                                                                                controller.listOfNumberFocus[i].value,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 14.0,
                                                                              color: Color(0xFF652981),
                                                                            ),
                                                                            obscureText:
                                                                                false,
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            cursorColor:
                                                                                const Color(0xFF652981),
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: '01xxxxxxxxx',
                                                                              counterText: "",
                                                                              hintStyle: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.black12,
                                                                              ),
                                                                              focusColor: Color(0xFF652981),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(0.0),
                                                                                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(0.0),
                                                                                borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
                                                                              ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(0.0),
                                                                                borderSide: BorderSide.none,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            child:
                                                                                Center(child: Text(data.number!)),
                                                                          ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 1,
                                                                  height:
                                                                      Get.height *
                                                                          .06,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                                // contact book icon
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    controller
                                                                        .selectedIndex
                                                                        .value = i;
                                                                    controller
                                                                        .currentIndex
                                                                        .value = 0;

                                                                    print(
                                                                        "my index is ${controller.selectedIndex.value}");
                                                                    if (controller
                                                                        .box
                                                                        .value
                                                                        .hasData(
                                                                            'contactbook')) {
                                                                      print(
                                                                          "Iam here");
                                                                      controller
                                                                          .getStoredData();
                                                                    } else {
                                                                      print(
                                                                          "Iam here2");

                                                                      controller
                                                                          .getPhoneContact();
                                                                    }
                                                                  },
                                                                  child: controller
                                                                              .contactLoad
                                                                              .value ==
                                                                          false
                                                                      ? Container(
                                                                          width: Get.width *
                                                                              .07,
                                                                          height: Get.height *
                                                                              .04,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(2.0),
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/icons/phonebookpurple.png",
                                                                            ),
                                                                          ))
                                                                      : Center(
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                10,
                                                                            width:
                                                                                10,
                                                                            child:
                                                                                CircularProgressIndicator(),
                                                                          ),
                                                                        ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              controller
                                                                      .isPackage
                                                                      .value =
                                                                  false;
                                                            },
                                                            child:
                                                                controller.isPackage
                                                                            .value ==
                                                                        false
                                                                    ? Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.white,
                                                                            border: Border.all(
                                                                              width: 1,
                                                                              color: Colors.grey,
                                                                            ),
                                                                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8))),
                                                                        height: _size.height *
                                                                            .08,
                                                                        width: _size.width *
                                                                            .2,
                                                                        child: SizedBox(
                                                                            width: Get.width * .2,
                                                                            child: TextFormField(
                                                                              onTap: () {
                                                                                FocusScope.of(context).requestFocus(controller.listOfFocusNodeAmount[i].value);
                                                                                controller.currentIndex.value = 0;
                                                                                controller.selectedIndex.value = i;
                                                                              },
                                                                              keyboardType: TextInputType.number, // More appropriate for numeric input
                                                                              controller: controller.amountControllerList.value[i].value,
                                                                              focusNode: controller.listOfFocusNodeAmount[i].value,
                                                                              onChanged: (input) {
                                                                                controller.amount.value = controller.amountControllerList.value[i].value.text;
                                                                                controller.updateAmountAtIndex(i, controller.amount.value);
                                                                              },
                                                                              validator: (input) {
                                                                                return (input == null || input.length < 8) ? 'Please provide a valid Amount' : null;
                                                                              },
                                                                              style: const TextStyle(
                                                                                fontSize: 18.5,
                                                                                color: Color(0xFF652981),
                                                                              ),
                                                                              obscureText: false,
                                                                              textAlign: TextAlign.start,
                                                                              cursorColor: const Color(0xFF652981),
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Amount',
                                                                                hintStyle: TextStyle(
                                                                                  fontSize: 14,
                                                                                  color: Colors.black12,
                                                                                ),
                                                                                focusColor: Color(0xFF652981),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(0),
                                                                                    bottomLeft: Radius.circular(0),
                                                                                    bottomRight: Radius.circular(8),
                                                                                    topRight: Radius.circular(8),
                                                                                  ),
                                                                                  borderSide: BorderSide(color: AppColors.primaryColor, width: 1.0),
                                                                                ),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(0),
                                                                                    bottomLeft: Radius.circular(0),
                                                                                    bottomRight: Radius.circular(8),
                                                                                    topRight: Radius.circular(8),
                                                                                  ),
                                                                                  borderSide: BorderSide.none,
                                                                                ),
                                                                              ),
                                                                            )),
                                                                      )
                                                                    : Container(
                                                                        height: _size.height *
                                                                            .08,
                                                                        width: _size.width *
                                                                            .2,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .white,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                bottomLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(8),
                                                                                topRight: Radius.circular(8)),
                                                                            border: Border.all(color: Colors.black54)),
                                                                        child: Center(child: Text(data.amount.toString()))),
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        .01,
                                                              ),
                                                              Image.asset(
                                                                'assets/tk.png',
                                                                height:
                                                                    Get.height *
                                                                        .03,
                                                                width:
                                                                    Get.width *
                                                                        .03,
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),

                                                          // add number  list
                                                          InkWell(
                                                            onTap: () {
                                                              if (i ==
                                                                      controller
                                                                              .rechargeNumberObjectList
                                                                              .value
                                                                              .length -
                                                                          1 &&
                                                                  i < 4) {
                                                                controller
                                                                    .addNewNumber(
                                                                        context);
                                                              } else {
                                                                if (controller
                                                                        .rechargeNumberObjectList
                                                                        .length ==
                                                                    1) {
                                                                  Get.showSnackbar(Ui.ErrorSnackBar(
                                                                      message:
                                                                          "You must add atleast one number.",
                                                                      title: 'Error'
                                                                          .tr));
                                                                } else {
                                                                  controller
                                                                      .isPackage
                                                                      .value = true;

                                                                  controller
                                                                      .removeNumberObject(
                                                                          data,
                                                                          i);
                                                                }
                                                              }
                                                            },
                                                            child: Container(
                                                              height:
                                                                  Get.height *
                                                                      .04,
                                                              width: Get.width *
                                                                  .07,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: i ==
                                                                            controller.rechargeNumberObjectList.length -
                                                                                1 &&
                                                                        i < 4
                                                                    ? AppColors
                                                                        .primaryColor
                                                                    : AppColors
                                                                        .primaryLightColor,
                                                                border: Border.all(
                                                                    color: i == controller.rechargeNumberObjectList.length - 1 &&
                                                                            i <
                                                                                4
                                                                        ? AppColors
                                                                            .primaryColor
                                                                        : AppColors
                                                                            .primaryLightColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                              ),
                                                              child:
                                                                  i == controller.rechargeNumberObjectList.length - 1 &&
                                                                          i < 4
                                                                      ? Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.add,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                16,
                                                                          ),
                                                                        )
                                                                      : Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.remove,
                                                                            color:
                                                                                Colors.red,
                                                                            size:
                                                                                16,
                                                                          ),
                                                                        ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .currentIndex
                                                              .value = 0;
                                                        },
                                                        child: Container(
                                                          height:
                                                              Get.height * .034,
                                                          child: InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .selectedIndex
                                                                  .value = i;
                                                              if (data.number!
                                                                      .length <
                                                                  11) {
                                                                Get.showSnackbar(
                                                                    Ui.ErrorSnackBar(
                                                                        message:
                                                                            "Add a number first.",
                                                                        title: 'Error'
                                                                            .tr));
                                                              } else {
                                                                controller
                                                                        .isExpanaded
                                                                        .value =
                                                                    controller.toggleExpanded(controller
                                                                        .isExpanaded
                                                                        .value);
                                                              }

                                                              controller.updateExpandedAtIndex(
                                                                  controller
                                                                      .selectedIndex
                                                                      .value,
                                                                  controller
                                                                      .isExpanaded
                                                                      .value);
                                                              controller
                                                                      .simOperator
                                                                      .value =
                                                                  data.operatorID!;
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                data.number ==
                                                                        ""
                                                                    ? Container()
                                                                    : data.number!.substring(0,
                                                                                3) ==
                                                                            "016"
                                                                        ? GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              controller.currentIndex.value = 0;
                                                                              controller.selectedIndex.value = i;
                                                                              controller.simOperator.value = data.operatorID!;
                                                                              controller.rechargeNumber.value = data.number!;
                                                                              FocusScope.of(context).unfocus();
                                                                              controller.getRobiAndAirtelOfferList(data.number, data.operatorID!, i, context);
                                                                            },
                                                                            child: Container(
                                                                                height: Get.height * .09,
                                                                                width: Get.width * .25,
                                                                                decoration: BoxDecoration(
                                                                                  color: AppColors.primarydeepLightColor,
                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(0), bottomLeft: Radius.circular(8)),
                                                                                ),
                                                                                child: Center(
                                                                                    child: controller.selectedIndex.value == i && controller.loading.value == true
                                                                                        ? Container(height: 10, width: 10, child: CircularProgressIndicator())
                                                                                        : Text(
                                                                                            'Tong Offer'.tr,
                                                                                            style: TextStyle(color: Colors.black),
                                                                                          ))),
                                                                          )
                                                                        : data.number!.substring(0, 3) ==
                                                                                "018"
                                                                            ? GestureDetector(
                                                                                onTap: () {
                                                                                  controller.currentIndex.value = 0;
                                                                                  controller.selectedIndex.value = i;
                                                                                  controller.simOperator.value = data.operatorID!;
                                                                                  controller.rechargeNumber.value = data.number!;
                                                                                  FocusScope.of(context).unfocus();
                                                                                  controller.getRobiAndAirtelOfferList(data.number, data.operatorID!, i, context);
                                                                                },
                                                                                child: Container(
                                                                                    height: Get.height * .09,
                                                                                    width: Get.width * .25,
                                                                                    decoration: BoxDecoration(
                                                                                      color: AppColors.primarydeepLightColor,
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(0), bottomLeft: Radius.circular(8)),
                                                                                    ),
                                                                                    child: Center(
                                                                                        child: controller.selectedIndex.value == i && controller.loading.value == true
                                                                                            ? Container(height: 10, width: 10, child: CircularProgressIndicator())
                                                                                            : Text(
                                                                                                'G-Store'.tr,
                                                                                                style: TextStyle(color: Colors.black, fontSize: 14),
                                                                                              ))),
                                                                              )
                                                                            : data.number!.substring(0, 3) == "019" && controller.cashBackOfferLoaded.isTrue
                                                                                ? GestureDetector(
                                                                                    onTap: () {
                                                                                      controller.currentIndex.value = 0;
                                                                                      controller.selectedIndex.value = i;
                                                                                      controller.rechargeNumber.value = data.number!;
                                                                                      controller.simOperatorLogo.value = data.logo!;
                                                                                      controller.simOperator.value = data.operatorID!;
                                                                                      controller.amount.value = "";
                                                                                      FocusScope.of(context).unfocus();
                                                                                      controller.getCashBackOffer();
                                                                                      Get.to(CashBackPackageWidget());
                                                                                    },
                                                                                    child: Container(
                                                                                        height: Get.height * .09,
                                                                                        width: Get.width * .25,
                                                                                        decoration: BoxDecoration(
                                                                                          color: AppColors.primarydeepLightColor,
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(0), bottomLeft: Radius.circular(8)),
                                                                                        ),
                                                                                        child: Center(
                                                                                            child: controller.selectedIndex.value == i && controller.loading.value == true
                                                                                                ? Container(height: 10, width: 10, child: CircularProgressIndicator())
                                                                                                : Text(
                                                                                                    'Amar Offer'.tr,
                                                                                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                                                                                  ))),
                                                                                  )
                                                                                : data.number!.substring(0, 3) == "017" && controller.cashBackOfferLoaded.isTrue
                                                                                    ? GestureDetector(
                                                                                        onTap: () {
                                                                                          controller.amount.value = "";
                                                                                          controller.rechargeNumber.value = data.number!;
                                                                                          controller.simOperatorLogo.value = data.logo!;
                                                                                          controller.currentIndex.value = 0;
                                                                                          controller.simOperator.value = data.operatorID!;
                                                                                          FocusScope.of(context).unfocus();
                                                                                          controller.getCashBackOffer();
                                                                                          controller.selectedIndex.value = i;
                                                                                          Get.to(CashBackPackageWidget());
                                                                                        },
                                                                                        child: Container(
                                                                                            height: Get.height * .09,
                                                                                            width: Get.width * .25,
                                                                                            decoration: BoxDecoration(
                                                                                              color: AppColors.primarydeepLightColor,
                                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(0), bottomLeft: Radius.circular(8)),
                                                                                            ),
                                                                                            child: Center(
                                                                                                child: controller.selectedIndex.value == i && controller.loading.value == true
                                                                                                    ? Container(height: 10, width: 10, child: CircularProgressIndicator())
                                                                                                    : Text(
                                                                                                        'Power Load'.tr,
                                                                                                        style: TextStyle(color: Colors.black, fontSize: 14),
                                                                                                      ))),
                                                                                      )
                                                                                    : Container(),
                                                                i == controller.rechargeNumberObjectList.length - 1 &&
                                                                        i !=
                                                                            0 &&
                                                                        i != 4
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () {
                                                                          controller
                                                                              .isPackage
                                                                              .value = true;
                                                                          controller.removeNumberObject(
                                                                              data,
                                                                              i);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              Get.height * .07,
                                                                          width:
                                                                              Get.width * .07,
                                                                          child:
                                                                              Icon(
                                                                            Icons.remove,
                                                                            color:
                                                                                Colors.red,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                // data.isExpanded == false
                                                //     ? Container()
                                                //     : Column(
                                                //   children: [
                                                //     Obx(() {
                                                //       return SingleChildScrollView(
                                                //         scrollDirection:
                                                //         Axis.horizontal,
                                                //         child:
                                                //         Padding(
                                                //           padding:
                                                //           const EdgeInsets.all(15.0),
                                                //           child:
                                                //           Row(
                                                //             mainAxisAlignment:
                                                //             MainAxisAlignment.spaceBetween,
                                                //             children: [
                                                //               GestureDetector(
                                                //                 onTap: () {
                                                //                   controller.selectedIndex.value = i;
                                                //                   controller.mobileNumberFocus.value.unfocus();
                                                //                   controller.currentIndex.value = 1;
                                                //                   // controller.getBundle('3');
                                                //                   controller.getCashBackOffer();
                                                //                 },
                                                //                 child: Padding(
                                                //                   padding: const EdgeInsets.all(4.0),
                                                //                   child: Ui.getIconButton(color: controller.currentIndex.value == 1 ? const Color(0xFF652981) : Colors.white, textColor: controller.currentIndex.value == 1 ? Colors.white : Get.theme.textTheme.bodyText1!.color, text: 'CashBack'.tr, horrizontal: 10, vertical: 5, radius: 5),
                                                //                 ),
                                                //               ),
                                                //               GestureDetector(
                                                //                 onTap: () {
                                                //                   controller.selectedIndex.value = i;
                                                //                   controller.mobileNumberFocus.value.unfocus();
                                                //                   controller.currentIndex.value = 2;
                                                //                   controller.getInternet('1');
                                                //                 },
                                                //                 child: Padding(
                                                //                   padding: const EdgeInsets.all(4.0),
                                                //                   child: Ui.getIconButton(color: controller.currentIndex == 2 ? const Color(0xFF652981) : Colors.white, textColor: controller.currentIndex == 2 ? Colors.white : Get.theme.textTheme.bodyText1!.color, text: 'Internet'.tr, horrizontal: 10, vertical: 5, radius: 5),
                                                //                 ),
                                                //               ),
                                                //               GestureDetector(
                                                //                 onTap: () {
                                                //                   controller.selectedIndex.value = i;
                                                //                   controller.mobileNumberFocus.value.unfocus();
                                                //                   controller.currentIndex.value = 3;
                                                //                   controller.getMinute('2');
                                                //                 },
                                                //                 child: Padding(
                                                //                   padding: const EdgeInsets.all(4.0),
                                                //                   child: Ui.getIconButton(color: controller.currentIndex == 3 ? const Color(0xFF652981) : Colors.white, textColor: controller.currentIndex == 3 ? Colors.white : Get.theme.textTheme.bodyText1!.color, text: 'Minute'.tr, horrizontal: 10, vertical: 5, radius: 5),
                                                //                 ),
                                                //               ),
                                                //               GestureDetector(
                                                //                 onTap: () {
                                                //                   controller.selectedIndex.value = i;
                                                //                   controller.mobileNumberFocus.value.unfocus();
                                                //                   controller.currentIndex.value = 4;
                                                //                   controller.getBundle('3');
                                                //                 },
                                                //                 child: Padding(
                                                //                   padding: const EdgeInsets.all(4.0),
                                                //                   child: Ui.getIconButton(color: controller.currentIndex == 4 ? const Color(0xFF652981) : Colors.white, textColor: controller.currentIndex == 4 ? Colors.white : Get.theme.textTheme.bodyText1!.color, text: 'Bundle'.tr, horrizontal: 10, vertical: 5, radius: 5),
                                                //                 ),
                                                //               ),
                                                //               GestureDetector(
                                                //                 onTap: () {
                                                //                   controller.selectedIndex.value = i;
                                                //                   controller.mobileNumberFocus.value.unfocus();
                                                //                   controller.currentIndex.value = 5;
                                                //                   controller.getSpecialRate('4');
                                                //                 },
                                                //                 child: Padding(
                                                //                   padding: const EdgeInsets.all(4.0),
                                                //                   child: Ui.getIconButton(color: controller.currentIndex == 5 ? const Color(0xFF652981) : Colors.white, textColor: controller.currentIndex == 5 ? Colors.white : Get.theme.textTheme.bodyText1!.color, text: 'Special Rate'.tr, horrizontal: 10, vertical: 5, radius: 5),
                                                //                 ),
                                                //               ),
                                                //               // GestureDetector(
                                                //               //   onTap: () {
                                                //               //     controller.currentIndex.value = 5;
                                                //               //     // controller.getBundle('3');
                                                //               //     controller.getCashBackOffer();
                                                //               //   },
                                                //               //   child: Padding(
                                                //               //     padding: const EdgeInsets.all(4.0),
                                                //               //     child: Ui.getIconButton(
                                                //               //         color: controller.currentIndex == 5
                                                //               //             ? Color(0xFF652981)
                                                //               //             : Colors.white,
                                                //               //         textColor: controller.currentIndex == 5
                                                //               //             ? Colors.white
                                                //               //             : Get
                                                //               //                 .theme.textTheme.bodyText1!.color,
                                                //               //         text: 'CashBack'.tr,
                                                //               //         horrizontal: 10,
                                                //               //         vertical: 5,
                                                //               //         radius: 5),
                                                //               //   ),
                                                //               // ),
                                                //             ],
                                                //           ),
                                                //         ),
                                                //       );
                                                //     }),
                                                //
                                                //     Obx(() {
                                                //       return controller
                                                //           .pages[
                                                //       controller
                                                //           .currentIndex
                                                //           .value];
                                                //     }),
                                                //     // Container(
                                                //     //   height: 50,
                                                //     //   child: ListView.separated(
                                                //     //     scrollDirection:
                                                //     //     Axis.horizontal,
                                                //     //     itemCount:
                                                //     //     activityList.length,
                                                //     //     itemBuilder:
                                                //     //         (BuildContext
                                                //     //     context,
                                                //     //         index) {
                                                //     //       return Row(
                                                //     //         children: [
                                                //     //           badges.Badge(
                                                //     //             badgeContent: index ==
                                                //     //                 0
                                                //     //                 ? Text(data
                                                //     //                 .followupLogActivity!
                                                //     //                 .leadCount
                                                //     //                 .toString())
                                                //     //                 : index == 1
                                                //     //                 ? Text(data
                                                //     //                 .followupLogActivity!
                                                //     //                 .quoteCount
                                                //     //                 .toString())
                                                //     //                 : index ==
                                                //     //                 2
                                                //     //                 ? Text(data.followupLogActivity!.orderCount.toString())
                                                //     //                 : index == 3
                                                //     //                 ? Text(data.followupActivity!.call.toString())
                                                //     //                 : index == 4
                                                //     //                 ? Text(data.followupActivity!.message.toString())
                                                //     //                 : index == 5
                                                //     //                 ? Text(data.followupActivity!.meeting.toString())
                                                //     //                 : Text(data.followupActivity!.visit.toString()),
                                                //     //             badgeStyle: badges.BadgeStyle(
                                                //     //               badgeColor: primaryColorLight,
                                                //     //             ),
                                                //     //             child: Card(
                                                //     //               elevation: 5,
                                                //     //               child:
                                                //     //               Container(
                                                //     //                 width: MediaQuery.of(context)
                                                //     //                     .size
                                                //     //                     .width *
                                                //     //                     .11,
                                                //     //                 height: 40,
                                                //     //                 child:
                                                //     //                 Column(
                                                //     //                   children: [
                                                //     //                     InkWell(
                                                //     //                       onTap:
                                                //     //                           () {},
                                                //     //                       child:
                                                //     //                       CircleAvatar(
                                                //     //                         radius:
                                                //     //                         10,
                                                //     //                         backgroundColor:
                                                //     //                         Colors.transparent,
                                                //     //                         child:
                                                //     //                         activityList[index].icon,
                                                //     //                       ),
                                                //     //                     ),
                                                //     //                     SizedBox(
                                                //     //                       height:
                                                //     //                       5,
                                                //     //                     ),
                                                //     //                     Expanded(
                                                //     //                       child:
                                                //     //                       Text(
                                                //     //                         activityList[index].activityName!,
                                                //     //                         style:
                                                //     //                         TextStyle(color: Colors.grey, fontSize: 7),
                                                //     //                         overflow:
                                                //     //                         TextOverflow.ellipsis,
                                                //     //                       ),
                                                //     //                     ),
                                                //     //                   ],
                                                //     //                 ),
                                                //     //               ),
                                                //     //             ),
                                                //     //           ),
                                                //     //           SizedBox(
                                                //     //             width: 10,
                                                //     //           )
                                                //     //         ],
                                                //     //       );
                                                //     //     },
                                                //     //     separatorBuilder:
                                                //     //         (context, index) {
                                                //     //       return SizedBox(
                                                //     //         width: 0,
                                                //     //       );
                                                //     //     },
                                                //     //   ),
                                                //     // ),
                                                //   ],
                                                // ),
// add mumber , total amount row

                                                i ==
                                                        controller
                                                                .rechargeNumberObjectList
                                                                .length -
                                                            1
                                                    ? Container(
                                                        height:
                                                            Get.height * .07,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    Get.width *
                                                                        .2,
                                                                height:
                                                                    Get.height *
                                                                        .055,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black),
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Total Amount'
                                                                          .tr,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    Text(
                                                                      controller
                                                                          .calculateTotalAmount(
                                                                              controller.rechargeNumberObjectList)
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              // InkWell(
                                                              //   onTap:
                                                              //       () {
                                                              //     controller
                                                              //         .addNewNumber();
                                                              //
                                                              //     // Add your onPressed code here!
                                                              //   },
                                                              //   child:
                                                              //   Container(
                                                              //     width:
                                                              //     Get.width * .4,
                                                              //     height:
                                                              //     Get.height * .05,
                                                              //     decoration:
                                                              //     BoxDecoration(
                                                              //       color:
                                                              //       AppColors.primaryColor,
                                                              //       borderRadius:
                                                              //       BorderRadius.circular(10),
                                                              //     ),
                                                              //     child:
                                                              //     Center(
                                                              //       child:
                                                              //       Row(
                                                              //         mainAxisAlignment: MainAxisAlignment.center,
                                                              //         children: [
                                                              //           Text(
                                                              //             'Add Number'.tr,
                                                              //             style: TextStyle(fontSize: 12, color: Colors.white),
                                                              //           ),
                                                              //           Text(
                                                              //             '  (${controller.rechargeNumberList.value.length}/5)',
                                                              //             style: TextStyle(fontSize: 12, color: Colors.white),
                                                              //           ),
                                                              //         ],
                                                              //       ),
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  if (controller
                                                                      .rechargeNumberObjectList
                                                                      .isEmpty) {
                                                                    Get.showSnackbar(Ui.ErrorSnackBar(
                                                                        message:
                                                                            'Please provide atleast 1 number'
                                                                                .tr,
                                                                        title: 'Error'
                                                                            .tr));
                                                                  } else {
                                                                    print(
                                                                        "first num is ${controller.rechargeNumberObjectList.first.number} and i typed ${controller.numberControllerList.first.value.text}");
                                                                    if (controller.rechargeNumberObjectList.any((element) =>
                                                                        element.number!.length <
                                                                            11 ||
                                                                        element.amount! ==
                                                                            "")) {
                                                                      Get.showSnackbar(Ui.ErrorSnackBar(
                                                                          message: 'Check all field has valid number and amount'
                                                                              .tr,
                                                                          title:
                                                                              'Error'.tr));
                                                                    } else {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                      Get.to(
                                                                          RechargePINViewNumberList());
                                                                    }
                                                                  }

                                                                  // Add your onPressed code here!
                                                                },
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      Get.width *
                                                                          .2,
                                                                  height:
                                                                      Get.height *
                                                                          .05,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: data.amount! ==
                                                                            ""
                                                                        ? Colors
                                                                            .grey
                                                                        : AppColors
                                                                            .primaryColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Recharge'
                                                                          .tr,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  );
                                }),
                              ),
                              Column(
                                children: [
                                  Obx(() {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller
                                                    .listOfFocusNodeAmount
                                                    .value[controller
                                                        .selectedIndex.value]
                                                    .value
                                                    .unfocus();
                                                controller.selectedIndex.value =
                                                    0;
                                                controller
                                                    .mobileNumberFocus.value
                                                    .unfocus();
                                                controller.currentIndex.value =
                                                    0;
                                                // controller.getBundle('3');
                                                controller.getCashBackOffer();
                                              },
                                              child: Text(''),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // controller.selectedIndex.value = i;
                                                controller
                                                    .mobileNumberFocus.value
                                                    .unfocus();
                                                controller.currentIndex.value =
                                                    2;
                                                controller.getInternet('1');
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Ui.getIconButton(
                                                    color: controller
                                                                .currentIndex ==
                                                            2
                                                        ? const Color(
                                                            0xFF652981)
                                                        : Colors.white,
                                                    textColor: controller
                                                                .currentIndex ==
                                                            2
                                                        ? Colors.white
                                                        : Get.theme.textTheme
                                                            .bodyText1!.color,
                                                    text: 'Internet'.tr,
                                                    horrizontal: 10,
                                                    vertical: 5,
                                                    radius: 5),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                //   controller.selectedIndex.value = i;
                                                controller
                                                    .mobileNumberFocus.value
                                                    .unfocus();
                                                controller.currentIndex.value =
                                                    3;
                                                controller.getMinute('2');
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Ui.getIconButton(
                                                    color: controller
                                                                .currentIndex ==
                                                            3
                                                        ? const Color(
                                                            0xFF652981)
                                                        : Colors.white,
                                                    textColor: controller
                                                                .currentIndex ==
                                                            3
                                                        ? Colors.white
                                                        : Get.theme.textTheme
                                                            .bodyText1!.color,
                                                    text: 'Minute'.tr,
                                                    horrizontal: 10,
                                                    vertical: 5,
                                                    radius: 5),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                //   controller.selectedIndex.value = i;
                                                controller
                                                    .listOfFocusNodeAmount
                                                    .value[controller
                                                        .selectedIndex.value]
                                                    .value
                                                    .unfocus();
                                                FocusScope.of(context)
                                                    .unfocus();
                                                controller.currentIndex.value =
                                                    4;
                                                controller.getBundle('3');
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Ui.getIconButton(
                                                    color: controller
                                                                .currentIndex ==
                                                            4
                                                        ? const Color(
                                                            0xFF652981)
                                                        : Colors.white,
                                                    textColor: controller
                                                                .currentIndex ==
                                                            4
                                                        ? Colors.white
                                                        : Get.theme.textTheme
                                                            .bodyText1!.color,
                                                    text: 'Bundle'.tr,
                                                    horrizontal: 10,
                                                    vertical: 5,
                                                    radius: 5),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                //   controller.selectedIndex.value = i;
                                                controller
                                                    .mobileNumberFocus.value
                                                    .unfocus();
                                                controller.currentIndex.value =
                                                    5;
                                                controller.getSpecialRate('4');
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Ui.getIconButton(
                                                    color: controller
                                                                .currentIndex ==
                                                            5
                                                        ? const Color(
                                                            0xFF652981)
                                                        : Colors.white,
                                                    textColor: controller
                                                                .currentIndex ==
                                                            5
                                                        ? Colors.white
                                                        : Get.theme.textTheme
                                                            .bodyText1!.color,
                                                    text: 'Special Rate'.tr,
                                                    horrizontal: 10,
                                                    vertical: 5,
                                                    radius: 5),
                                              ),
                                            ),
                                            // GestureDetector(
                                            //   onTap: () {
                                            //     controller.currentIndex.value = 5;
                                            //     // controller.getBundle('3');
                                            //     controller.getCashBackOffer();
                                            //   },
                                            //   child: Padding(
                                            //     padding: const EdgeInsets.all(4.0),
                                            //     child: Ui.getIconButton(
                                            //         color: controller.currentIndex == 5
                                            //             ? Color(0xFF652981)
                                            //             : Colors.white,
                                            //         textColor: controller.currentIndex == 5
                                            //             ? Colors.white
                                            //             : Get
                                            //                 .theme.textTheme.bodyText1!.color,
                                            //         text: 'CashBack'.tr,
                                            //         horrizontal: 10,
                                            //         vertical: 5,
                                            //         radius: 5),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),

                                  Obx(() {
                                    return controller
                                        .pages[controller.currentIndex.value];
                                  }),
                                  // Container(
                                  //   height: 50,
                                  //   child: ListView.separated(
                                  //     scrollDirection:
                                  //     Axis.horizontal,
                                  //     itemCount:
                                  //     activityList.length,
                                  //     itemBuilder:
                                  //         (BuildContext
                                  //     context,
                                  //         index) {
                                  //       return Row(
                                  //         children: [
                                  //           badges.Badge(
                                  //             badgeContent: index ==
                                  //                 0
                                  //                 ? Text(data
                                  //                 .followupLogActivity!
                                  //                 .leadCount
                                  //                 .toString())
                                  //                 : index == 1
                                  //                 ? Text(data
                                  //                 .followupLogActivity!
                                  //                 .quoteCount
                                  //                 .toString())
                                  //                 : index ==
                                  //                 2
                                  //                 ? Text(data.followupLogActivity!.orderCount.toString())
                                  //                 : index == 3
                                  //                 ? Text(data.followupActivity!.call.toString())
                                  //                 : index == 4
                                  //                 ? Text(data.followupActivity!.message.toString())
                                  //                 : index == 5
                                  //                 ? Text(data.followupActivity!.meeting.toString())
                                  //                 : Text(data.followupActivity!.visit.toString()),
                                  //             badgeStyle: badges.BadgeStyle(
                                  //               badgeColor: primaryColorLight,
                                  //             ),
                                  //             child: Card(
                                  //               elevation: 5,
                                  //               child:
                                  //               Container(
                                  //                 width: MediaQuery.of(context)
                                  //                     .size
                                  //                     .width *
                                  //                     .11,
                                  //                 height: 40,
                                  //                 child:
                                  //                 Column(
                                  //                   children: [
                                  //                     InkWell(
                                  //                       onTap:
                                  //                           () {},
                                  //                       child:
                                  //                       CircleAvatar(
                                  //                         radius:
                                  //                         10,
                                  //                         backgroundColor:
                                  //                         Colors.transparent,
                                  //                         child:
                                  //                         activityList[index].icon,
                                  //                       ),
                                  //                     ),
                                  //                     SizedBox(
                                  //                       height:
                                  //                       5,
                                  //                     ),
                                  //                     Expanded(
                                  //                       child:
                                  //                       Text(
                                  //                         activityList[index].activityName!,
                                  //                         style:
                                  //                         TextStyle(color: Colors.grey, fontSize: 7),
                                  //                         overflow:
                                  //                         TextOverflow.ellipsis,
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             width: 10,
                                  //           )
                                  //         ],
                                  //       );
                                  //     },
                                  //     separatorBuilder:
                                  //         (context, index) {
                                  //       return SizedBox(
                                  //         width: 0,
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ));
              }),
            ),
          ));
    });
  }

  // List<Contact> _search(List<Contact>? contactsList) {
  //   controller.searchStart.value = true;
  //   if (controller.searchString.value.isNotEmpty == true ||
  //       controller.searchString.value != "") {
  //     //search logic what you want
  //     return contactsList
  //             ?.where((element) => element.displayName!
  //                 .toLowerCase()
  //                 .contains(controller.searchString.value))
  //             .toList() ??
  //         <Contact>[];
  //   } else {
  //     return controller.contacts.value;
  //   }
  // }

  Future showOperatorLogo(context) async {
    return showModalBottomSheet(
        elevation: 50.0,
        //barrierColor: Colors.white54,
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        context: context,
        builder: (builder) {
          return Container(
            padding: const EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
            //  height: _size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Operator'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancel'.tr,
                        style: const TextStyle(
                          color: Color(0xFF652981),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Choose the current operator of this number'.tr,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                Expanded(
                  child: Container(
                    child: GridView.count(
                        scrollDirection: Axis.vertical,
                        primary: true,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 1.3,
                        children: List.generate(operatorLogos.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              controller.simOperatorLogo.value =
                                  operatorLogos[index].logo!;
                              controller.simOperator.value =
                                  operatorLogos[index].id!.toString();
                              controller
                                  .getOfferList(controller.simOperator.value);
                              Get.back();
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16)),
                                height: 40,
                                width: 40,
                                child: Image.asset(operatorLogos[index].logo!),
                              ),
                            ),
                          );
                        })),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future showPinCode(context) async {
    return showModalBottomSheet(
        elevation: 50.0,
        //barrierColor: Colors.white54,
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        context: context,
        builder: (builder) {
          return GetBuilder<RechargeController>(builder: (ct) {
            return Container(
              padding:
                  const EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
              //  height: _size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Give Your Pin'.tr,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          'Cancel'.tr,
                          style: const TextStyle(
                            color: Color(0xFF652981),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(
                            width: Get.width,
                            //  height: 50,
                            decoration: Ui.getBoxDecoration(radius: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: TextFormField(
                                obscureText: true,
                                controller: controller.pinController.value,
                                cursorColor: AppColors.primaryColor,
                                textAlign: TextAlign.center,
                                maxLength: 6,

                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  hintText: 'Enter PIN here'.tr,
                                  hintStyle: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 15),
                                  prefixIcon: Icon(
                                    CupertinoIcons.lock,
                                    color: AppColors.primaryColor,
                                  ).marginOnly(right: 14),

                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      //        controller.rechargeNumbersFromList();

                                      print("sahed");
                                      controller.pinController.value.clear();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.arrow_right,
                                      color: AppColors.primaryColor,
                                      size: 35,
                                    ).marginOnly(right: 14),
                                  ),
                                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                                  focusColor: AppColors.primaryColor,
                                ),
                                focusNode: controller.pinFocusFocus.value,
                                keyboardType: TextInputType.phone,
                                // validator: (String? value) {
                                //
                                // },
                                onChanged: (input) {
                                  controller.pinNumber.value = input;
                                },
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width * .25,
                              child: Text(
                                "Number",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: Get.width * .2,
                              child: Text(
                                "Amount",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: Get.width * .4,
                              child: Text(
                                "Message",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: Get.height * .25,
                          child: Table(
                              border: TableBorder.all(
                                  width: 1.0, color: Colors.black),
                              children: [
                                for (var data in controller
                                    .rechargeNumberObjectList.value)
                                  TableRow(children: [
                                    TableCell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              width: Get.width * .25,
                                              child:
                                                  Text(data.number.toString())),
                                          Container(
                                              width: Get.width * .2,
                                              child:
                                                  Text(data.amount.toString())),
                                          Container(
                                              width: Get.width * .4,
                                              child: Text(
                                                  data.message.toString())),
                                        ],
                                      ),
                                    )
                                  ])
                              ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  void _insertText(String myText) {
    final text = controller.mobileNumberFocus.value.hasFocus
        ? controller.rechargeNumberController.value.text
        : controller.amountController.value.text;
    final textSelection = controller.rechargeNumberController.value.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    controller.rechargeNumberController.value.text = newText;
    controller.rechargeNumberController.value.selection =
        textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace() {
    final text = controller.amountController.value.text;
    final textSelection = controller.amountController.value.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      controller.amountController.value.text = newText;
      controller.amountController.value.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    controller.amountController.value.text = newText;
    controller.amountController.value.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }
}
