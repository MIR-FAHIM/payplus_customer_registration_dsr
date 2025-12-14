import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/controllers/mobile_banking_controller.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class MBankingPinView extends GetView<MobileBankingController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    // print('cashback amount : ${controller.amountController.clear}');

    return Scaffold(
        backgroundColor: Colors.white,
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
              onPressed: () => Get.back(),
            ),
            // actions: [
            //   IconButton(
            //       onPressed: () {},
            //       icon: Icon(
            //         CupertinoIcons.bell,
            //         color: Colors.white70,
            //       )),
            // ]
          ),
        ),
        body: Obx(() {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: _size.width,
              height: _size.height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          height: _size.width * .3,
                          width: _size.width,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mobile Number'.tr,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25.0, top: 5),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: CachedNetworkImage(
                                                    imageUrl: controller
                                                        .imageUrl.value,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            const Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/default_image.png'),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/default_image.png'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: _size.width * .5,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  initialValue: controller
                                                      .numberController
                                                      .value
                                                      .text,
                                                  validator: (input) => input!
                                                              .length <
                                                          11
                                                      ? 'Please provide valid phone number'
                                                      : null,
                                                  style: const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color(0xFF652981),
                                                  ),
                                                  obscureText: false,
                                                  textAlign: TextAlign.start,
                                                  readOnly: true,
                                                  cursorColor:
                                                      const Color(0xFF652981),
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: '01xxxxxxxxx',
                                                    hintStyle: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey,
                                                    ),
                                                    focusColor:
                                                        Color(0xFF652981),
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
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
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: _size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: Ui.getBoxDecoration(
                                    color: Colors.white, radius: 5),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Amount'.tr,
                                            style: const TextStyle(
                                              color: Color(0xFF652981),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            '৳ ${controller.amountController.value.text}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: Ui.getBoxDecoration(
                                    color: Colors.white, radius: 5),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Cash Back'.tr,
                                            style: const TextStyle(
                                              color: Color(0xFF652981),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            '৳ ${controller.commission.value}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    controller.currentTabIndex.value == 1 && controller.gateWayID.value == "5"
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                                width: _size.width,
                                //  height: 50,
                                decoration: Ui.getBoxDecoration(radius: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: controller.otpController.value,
                                    cursorColor: const Color(0xFF652981),
                                    textAlign: TextAlign.center,
                                    maxLength: 6,

                                    decoration: InputDecoration(
                                      counterText: "",
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      hintText: 'Enter OTP here'.tr,
                                      hintStyle: const TextStyle(
                                          color: Color(0xFF652981),
                                          fontSize: 15),
                                      prefixIcon: const Icon(
                                        CupertinoIcons.lock,
                                        color: Color(0xFF652981),
                                      ).marginOnly(right: 14),

                                      // floatingLabelBehavior: FloatingLabelBehavior.never,
                                      focusColor: const Color(0xFF652981),
                                    ),

                                    keyboardType: TextInputType.phone,
                                    // validator: (String? value) {
                                    //
                                    // },
                                    onChanged: (input) {},
                                  ),
                                )),
                          )
                        : Container(),

                    //remark

                    controller.currentTabIndex.value == 2 ?
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          width: _size.width,
                          //  height: 50,
                          decoration: Ui.getBoxDecoration(radius: 5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: TextFormField(
                              obscureText: false,
                              controller: controller.remarkController.value,
                              cursorColor: const Color(0xFF652981),
                              textAlign: TextAlign.center,
                              maxLength: 50,

                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                hintText: 'Enter Remark here'.tr,
                                hintStyle: const TextStyle(
                                    color: Color(0xFF652981), fontSize: 15),



                                // floatingLabelBehavior: FloatingLabelBehavior.never,
                                focusColor: const Color(0xFF652981),
                              ),

                              keyboardType: TextInputType.text,
                              // validator: (String? value) {
                              //
                              // },
                              onChanged: (input) {},
                            ),
                          )),
                    ) :Container(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          width: _size.width,
                          //  height: 50,
                          decoration: Ui.getBoxDecoration(radius: 5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: controller.pinController.value,
                              cursorColor: const Color(0xFF652981),
                              textAlign: TextAlign.center,
                              maxLength: 6,

                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                hintText: 'Enter PIN here'.tr,
                                hintStyle: const TextStyle(
                                    color: Color(0xFF652981), fontSize: 15),
                                prefixIcon: const Icon(
                                  CupertinoIcons.lock,
                                  color: Color(0xFF652981),
                                ).marginOnly(right: 14),

                                suffixIcon: IconButton(
                                  onPressed: () {

                                    if (controller
                                        .pinController.value.text.isNotEmpty) {
                                      if (controller.currentTabIndex.value ==
                                          2) {
                                        print("money transfer >>>>>>>");
                                        if(controller.remarkController.value.text.isEmpty){
                                          Get.showSnackbar(Ui.ErrorSnackBar(
                                              message:
                                              'Enter Remark here'.tr,
                                              title: 'Error'.tr));
                                        }else{
                                          controller.moneyTransferController();
                                        }

                                      } else if (controller
                                              .currentTabIndex.value ==
                                          0) {
                                        if(controller.gateWayID.value == "3"){
                                          controller.sendRequestForCashinRocket(
                                              controller.pinController.value.text,
                                              controller.gateWayID.value);
                                        }else{
                                          controller.sendRequestForCashin(
                                              controller.pinController.value.text,
                                              controller.gateWayID.value);
                                        }

                                      } else {

                                        if(controller.gateWayID.value == "3"){
                                          controller.sendRequestForCashOut(
                                              controller.pinController.value.text,
                                              controller.gateWayID.value,
                                              controller
                                                  .otpController.value.text);
                                        }else{
                                          controller.sendRequestForCashOut(
                                              controller.pinController.value.text,
                                              controller.gateWayID.value,
                                              controller
                                                  .otpController.value.text);
                                        }

                                      }
                                    } else {
                                      Get.showSnackbar(Ui.ErrorSnackBar(
                                          message: "Provide pin number",
                                          title: 'Error'.tr));
                                    }
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.arrow_right,
                                    color: Color(0xFF652981),
                                    size: 35,
                                  ).marginOnly(right: 14),
                                ),
                                // floatingLabelBehavior: FloatingLabelBehavior.never,
                                focusColor: const Color(0xFF652981),
                              ),

                              keyboardType: TextInputType.phone,
                              // validator: (String? value) {
                              //
                              // },
                              onChanged: (input) {},
                            ),
                          )),
                    ),
                    // controller.currentPage
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
