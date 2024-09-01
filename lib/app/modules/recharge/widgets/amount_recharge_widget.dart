import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/package_model.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/num_pad.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class AmountRechargeWidget extends GetWidget<RechargeController> {
  HomeController homeController = Get.put(HomeController());
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: _size.width * .5,
                    width: _size.width,
                    decoration: Ui.getBoxDecoration(color: Colors.white, radius: 8),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            controller.amountOfferFound.isTrue
                                ? GestureDetector(
                                    onTap: () {
                                      buildOfferDialog(controller.amountOffer.value);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 25,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: const Color(0xFF652981),
                                            ),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: const Center(
                                            child: Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: Text(
                                            'Offer',
                                            style: TextStyle(
                                              color: Color(0xFF652981),
                                            ),
                                          ),
                                        )),
                                      ),
                                    ),
                                  )
                                : Wrap(),
                            GestureDetector(
                              onTap: () {
                                controller.amountController.value.text = '30';
                                controller.amountCheck();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 25,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(0xFF652981),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(
                                      '৳ 30',
                                      style: TextStyle(
                                        color: Color(0xFF652981),
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.amountController.value.text = '50';
                                controller.amountCheck();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 25,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(0xFF652981),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(
                                      '৳ 50',
                                      style: TextStyle(
                                        color: Color(0xFF652981),
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.amountController.value.text = '100';
                                controller.amountCheck();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 25,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(0xFF652981),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(
                                      '৳ 100',
                                      style: TextStyle(
                                        color: Color(0xFF652981),
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
                              keyboardType: TextInputType.phone,
                              controller: controller.amountController.value,
                              onTap: () {
                                controller.keyboardText.value = 'amount';
                              },
                              autofocus: controller.rechargeNumber.value.length == 11 ? true : false,
                              onChanged: (input) {
                                controller.amount.value = input;
                                controller.amountCheck();
                                // controller.getCommission();
                              },
                              // validator: (input) => double.parse(input!.toString()) < 2 ? 'Minimum recharge amount is TK 2'.tr : null,
                              style: const TextStyle(
                                fontSize: 35.0,
                                color: Color(0xFF652981),
                              ),
                              obscureText: false,
                              focusNode: controller.amountFocusFocus.value,
                              textAlign: TextAlign.center,
                              cursorColor: const Color(0xFF652981),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(fontSize: 35),
                                hintText: '৳ 0',
                                hintStyle: TextStyle(fontSize: 35),
                                focusColor: const Color(0xFF652981),
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                              ),
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: () {
                            // Get.to(TestPage());
                            print(controller.amountController.value.text);
                            print(homeController.balance.value);

                            // if (controller.rechargeNumber.value.length == 11 &&
                            //     double.parse(homeController.balance.value) >
                            //         double.parse(
                            //             controller.amountController.text)) {
                            //   print("done");
                            // } else {
                            //   print("not done");
                            // }

                            if (controller.amountController.value.text.isEmpty) {
                              controller.amountController.value.text = '0';
                            }

                            if (controller.rechargeNumber.value.length == 11) {
                              // if (double.parse(homeController.balance.value) >
                              //     double.parse(
                              //         controller.amountController.text))
                              //          {


                                if (double.parse(controller.amountController.value.text) >= 2) {
                                  controller.pinFocusFocus.value.requestFocus();
                                  controller.getCommission();
                                } else {
                                  if (double.parse(controller.amountController.value.text) == 0) {
                                    Get.showSnackbar(Ui.ErrorSnackBar(message: 'Enter Recharge Amount', title: 'Error'.tr));
                                  } else {
                                    Get.showSnackbar(Ui.ErrorSnackBar(message: 'Minimum recharge amount is TK 2', title: 'Error'.tr));
                                  }
                                }


                              //   print("done");
                              // } else {
                              //   Get.showSnackbar(Ui.ErrorSnackBar(
                              //       message:
                              //           'Your balance is insufficient, Please add your balance'
                              //               .tr,
                              //       title: 'Low Balance'.tr));
                              // }

                            } else {
                              Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please provide valid phone number'.tr, title: 'Error'.tr));
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 15),
                            child: Image(
                              height: 35,
                              width: 35,
                              image: AssetImage('assets/images/arrow_for.png'),
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
                          'Your Balance: ৳ ${homeController.balance.value}',
                          style: const TextStyle(color: Color(0xFF652981)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // NumPad(
              //   buttonSize: 40,
              //   buttonColor: AppColors.backgroundColor,
              //   iconColor: AppColors.primaryColor,
              //   controller: controller.amountController,
              //   delete: () {
              //     controller.amountController.text = controller.amountController.text.substring(0, controller.amountController.text.length - 1);
              //   },
              //   // do something with the input numbers
              //   onSubmit: () {
              //     debugPrint('Your code: ${controller.amountController.text}');
              //     showDialog(
              //         context: context,
              //         builder: (_) => AlertDialog(
              //               content: Text(
              //                 "You code is ${controller.amountController.text}",
              //                 style: const TextStyle(fontSize: 30),
              //               ),
              //             ));
              //   },
              // ),

              // GestureDetector(
              //   onTap: () {
              //     buildOfferDialog();
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(15.0),
              //     child: Container(
              //       width: _size.width,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(8),
              //           border: Border.all(
              //             width: 2,
              //             color: Color(0xFF652981),
              //           )),
              //       child: Center(
              //         child: Padding(
              //           padding: const EdgeInsets.all(5.0),
              //           child: Text(
              //             'See Your Offer'.tr,
              //             style: TextStyle(color: Color(0xFF652981), fontWeight: FontWeight.w600),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ));
    });
  }

  buildOfferDialog(PackageModel offer) {
    return Get.defaultDialog(
        title: 'Recharge this amount and take the following offer'.tr,
        titlePadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        titleStyle: const TextStyle(fontSize: 16),
        contentPadding: const EdgeInsets.all(10),
        radius: 8,
        content: Container(
          width: Get.size.width,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        offer.offerName == 'Internet'
                            ? 'assets/recharge/gb.png'
                            : offer.offerName == 'Minute'
                                ? 'assets/recharge/min.png'
                                : offer.offerName == 'Bundle'
                                    ? 'assets/recharge/cash.png'
                                    : 'assets/recharge/min.png',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        offer.package!,
                        style: const TextStyle(
                          color: const Color(0xFF652981),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/clock.png',
                        height: 18,
                        width: 18,
                        color: const Color(0xFF652981),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        offer.offerValidity!,
                        style: const TextStyle(
                          color: Color(0xFF652981),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xFF652981)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/taka.png',
                          height: 10,
                          width: 10,
                          color: Colors.white,
                        ),
                        Text(
                          offer.offerAmount!.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: Ui.getBoxDecoration(color: Colors.white, radius: 8),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2, bottom: 2),
                    child: Center(
                      child: Text(
                        'Change Amount'.tr,
                        style: const TextStyle(
                          color: Color(0xFF652981),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (controller.rechargeNumber.value.length == 11) {
                    Get.toNamed(Routes.RECHARGEPIN);
                  } else {
                    Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please provide valid phone number'.tr, title: 'Error'.tr));
                  }
                },
                child: Container(
                  decoration: Ui.getBoxDecoration(color: const Color(0xFF652981), radius: 8),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2, bottom: 2),
                    child: Center(
                      child: Text(
                        'Done'.tr,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]);
  }

  buildPinDialog() {
    return Get.defaultDialog(
        title: 'Confirm PIN Number'.tr,
        titlePadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        titleStyle: const TextStyle(fontSize: 20),
        contentPadding: const EdgeInsets.all(10),
        radius: 8,
        content: Container(
          width: Get.size.width,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Number'.tr,
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Text(
                        'Taka'.tr,
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: _size.width * .45,
                            //  height: 50,
                            decoration: Ui.getBoxDecoration(radius: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: TextFormField(
                                cursorColor: const Color(0xFF652981),
                                readOnly: true,
                                initialValue: controller.rechargeNumber.value,

                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  hintText: '017xxxxxxxx'.tr,

                                  hintStyle: TextStyle(color: Get.theme.hintColor, fontSize: 15),
                                  prefixIcon: Image.asset(
                                    'assets/images/phone1.png',
                                  ).marginOnly(
                                    right: 10,
                                    left: 8,
                                    top: 2,
                                  ),
                                  prefixIconConstraints: const BoxConstraints.expand(width: 30, height: 30),
                                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                                  focusColor: const Color(0xFF652981),
                                ),
                                keyboardType: TextInputType.phone,
                                // validator: (String? value) {
                                //
                                // },
                                onChanged: (String value) {},
                              ),
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                            width: _size.width * .25,
                            //  height: 50,
                            decoration: Ui.getBoxDecoration(radius: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: TextFormField(
                                cursorColor: const Color(0xFF652981),
                                readOnly: true,
                                initialValue: controller.amount.value,

                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  hintText: 'Amount'.tr,
                                  hintStyle: TextStyle(color: Get.theme.hintColor, fontSize: 15),
                                  focusColor: const Color(0xFF652981),
                                ),
                                keyboardType: TextInputType.phone,
                                // validator: (String? value) {
                                //
                                // },
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: _size.width,
                      //  height: 50,
                      decoration: Ui.getBoxDecoration(radius: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: TextFormField(
                          cursorColor: const Color(0xFF652981),

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: 'Enter PIN here'.tr,
                            hintStyle: const TextStyle(color: const Color(0xFF652981), fontSize: 15),

                            // floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusColor: const Color(0xFF652981),
                          ),
                          keyboardType: TextInputType.phone,
                          // validator: (String? value) {
                          //
                          // },
                          onChanged: (input) {
                            controller.pinNumber.value = input;
                          },
                        ),
                      )),
                ],
              )),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: Ui.getBoxDecoration(color: Colors.white, radius: 8),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2, bottom: 2),
                    child: Center(
                      child: Text(
                        'Cancel'.tr,
                        style: const TextStyle(
                          color: Color(0xFF652981),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (controller.pinNumber.value.length >= 4) {
                    controller.recharge();
                  }
                },
                child: Container(
                  decoration: Ui.getBoxDecoration(color: const Color(0xFF652981), radius: 8),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2, bottom: 2),
                    child: Center(
                      child: Text(
                        'Confirm'.tr,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]);
  }
}
