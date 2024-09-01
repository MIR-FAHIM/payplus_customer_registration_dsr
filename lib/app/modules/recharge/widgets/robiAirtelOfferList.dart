import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/text_field_pin_code_dialog.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class RobiAirtelPackageWidget extends GetWidget<RechargeController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return  Obx(() {
        if (controller.amountOfferListLoaded.isTrue) {
          if (controller.robiAirtelOfferList.value.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF652981),

                title: Text(
                  "Offer".tr
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
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
                                                  // controller
                                                  //     .contactListClicked
                                                  //     .value = true;
                                                },
                                                child: Image.asset(
                                                  'assets/icons/phnbk.png',
                                                  height: 30,
                                                  width: 30,
                                                  // color: Get.theme.primaryColor,
                                                ),
                                              ),
                                              SizedBox(width: 20,),
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
                                                  child: Text(controller.rechargeNumber.value, style: TextStyle(fontSize: 16),)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                right: 15.0),
                                            child: controller
                                                .simOperatorLogo
                                                .value !=
                                                '' &&
                                                controller
                                                    .rechargeNumberController.value
                                                    .text
                                                    .isNotEmpty
                                                ? GestureDetector(
                                              onTap: () {

                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    decoration:
                                                    BoxDecoration(
                                                      color: Colors
                                                          .grey
                                                          .shade100,
                                                      borderRadius:
                                                      BorderRadius.circular(50),
                                                    ),
                                                    child:
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: Image
                                                          .asset(
                                                        controller.rechargeNumberController.value.text.isNotEmpty
                                                            ? controller.simOperatorLogo.value
                                                            : '',
                                                        height:
                                                        35,
                                                        width:
                                                        35,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child:
                                                    Container(
                                                      height:
                                                      15,
                                                      width:
                                                      15,
                                                      decoration:
                                                      const BoxDecoration(
                                                        color:
                                                        Color(0xFF652981),
                                                        shape:
                                                        BoxShape.circle,
                                                      ),
                                                      child:
                                                      const Center(
                                                        child:
                                                        Icon(
                                                          Icons.edit,
                                                          size:
                                                          10,
                                                          color:
                                                          Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                                : const Text('')),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),

                    Obx(
                       () {
                      return Column(

                          children: List.generate(
                              controller.robiAirtelOfferList.value.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                controller.robiOfferCusComission.value = controller.robiAirtelOfferList.value[index].custCommission!.toString();
                                controller.robiOfferName.value = controller.robiAirtelOfferList.value[index].offerName!.toString();
                                controller.robiOfferID.value = controller.robiAirtelOfferList.value[index].packageId!.toString();
                                controller.robiRechargeCom.value = controller.robiAirtelOfferList.value[index].rechargeCom!.toString();
                                controller.amount.value = controller.robiAirtelOfferList.value[index].amount!.toString();

                                controller.robiOfferAdminComission.value = controller.robiAirtelOfferList.value[index].adminCommission!.toString();
                                controller.robiOfferComission.value = controller.robiAirtelOfferList.value[index].commission!.toString();
                                controller.pinPage.value = true;
                                Get.toNamed(Routes.RECHARGEPINROBI);
                                // Get.dialog(
                                //    PinCodeDialog());

                                //controller.rechargeRobiAirtelOffer();
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: _size.width,
                                    decoration: Ui.getBoxDecoration(
                                        color: Colors.white, radius: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, bottom: 6, left: 0, right: 10),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: Get.theme.primaryColor,
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Text(
                                                  'CashBack'.tr,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: _size.width,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Image.asset(
                                                            'assets/recharge/world.png',
                                                            height: 15,
                                                            width: 15,
                                                          ),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Expanded(
                                                              child: Text(
                                                            controller.robiAirtelOfferList
                                                                .value[index].offerName!,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 12),
                                                            maxLines: 2,
                                                          )),
                                                          Container(
                                                            height: 30,
                                                            width: 70,
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Get.theme.primaryColor,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      10.0),
                                                            ),
                                                            child: Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets.all(
                                                                        4.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      '৳${controller.robiAirtelOfferList.value[index].amount!}',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: 12,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        // Row(
                                                        //   children: [
                                                        //     Padding(
                                                        //         padding:
                                                        //             const EdgeInsets.only(
                                                        //                 top: 2, left: 0),
                                                        //         child: Icon(
                                                        //           Icons.lock_clock,
                                                        //           color: Get.theme
                                                        //               .primaryColorLight,
                                                        //         )),
                                                        //     SizedBox(
                                                        //       width: 4,
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                        top: 2, left: 0),
                                                                child: Icon(
                                                                  Icons
                                                                      .star_border_purple500_sharp,
                                                                  color: Get.theme
                                                                      .primaryColorLight,
                                                                )),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              controller
                                                                  .robiAirtelOfferList
                                                                  .value[index].custCommission!
                                                                  .toString() +
                                                                  "Tk Cashback",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .homeTextColor2,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            );
                          }),
                        );
                      }
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: _size.width,
              child: Center(
                child: Text('No Offer Avilable'),
              ),
            );
          }
        } else {
          return Container(
            height: _size.width,
            child: Center(
              child: Ui.customLoader(),
            ),
          );
        }
      });

  }

  Container Logo(int index) {
    var gp = "assets/sim/gp.png";
    var airtel = "assets/sim/art.png";
    var banglalink = "assets/sim/bl.png";
    var robi = "assets/sim/robi.png";
    var teletalk = "assets/sim/teletalk.png";

    var operator = controller.cashBackOffer.value.data![index].operatorName!;

    dynamic Operator() {
      if (operator == "Grameen phone") {
        return gp;
      } else if (operator == "Airtel") {
        return airtel;
      } else if (operator == "Banglalink") {
        return banglalink;
      } else if (operator == "Robi") {
        return robi;
      } else if (operator == "Teletalk") {
        return teletalk;
      } else
        return gp;
    }

    var _operatorImage = Operator();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          _operatorImage,
          height: 15,
          width: 15,
        ),
      ),
    );
  }

  simOparetor(int index) {
    var operator = controller.cashBackOffer.value.data![index].operatorName!;
    if (operator == "Grameen phone") {
      return "1";
    } else if (operator == "Banglalink") {
      return "2";
    } else if (operator == "Airtel") {
      return "3";
    } else if (operator == "Robi") {
      return "4";
    } else if (operator == "Teletalk") {
      return "5";
    } else
      return "0";
  }
}
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// height: 88,
// width: _size.width,
// decoration: Ui.getBoxDecoration(color: Colors.white, radius: 10),
// child: Padding(
// padding: const EdgeInsets.only(
// top: 13.0, bottom: 6, left: 15, right: 10),
// child: Column(
// // mainAxisAlignment:
// //     MainAxisAlignment.spaceBetween,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// children: [
// Image.asset(
// 'assets/recharge/cash.png',
// height: 20,
// width: 20,
// ),
// SizedBox(
// width: 4,
// ),
// Text(
// controller.cashBackOffer.value.data![index]
// .packageName!,
// maxLines: 2,
// ),
// ],
// ),
// Logo(index),
// ],
// ),
//
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SizedBox(
// width: 2,
// ),
// Image.asset(
// 'assets/icons/price.png',
// height: 16,
// width: 16,
// ),
// SizedBox(
// width: 4,
// ),
// Expanded(
// child: Text(
// controller.cashBackOffer.value.data![index]
// .cashbackAmount!
// .toString() +
// "Tk Cash Back",
// maxLines: 2,
// ),
// ),
// ],
// ),
// SizedBox(
// width: 5,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// children: [
// Padding(
// padding: const EdgeInsets.only(top: 2, left: 22),
// child: Text(
// 'Expiration:'.tr,
// style: TextStyle(
// color: AppColors.homeTextColor3,
// fontSize: 14),
// ),
// ),
// SizedBox(
// width: 4,
// ),
// Text(
// controller.cashBackOffer.value.data![index]
// .packageValidity!,
// style: TextStyle(
// color: AppColors.homeTextColor3,
// fontSize: 13),
// ),
// ],
// ),
// Container(
// child: Row(
// children: [
// Text(
// '৳ ${controller.cashBackOffer.value.data![index].offerAmount!.toString()}',
// style: TextStyle(
// color: AppColors.primaryColor,
// fontSize: 16,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(
// width: 4,
// ),
// Icon(
// Icons.arrow_forward_ios,
// color: Color(0xFF652981),
// size: 14,
// ),
// ],
// ),
// ),
// ],
// ),
// // Row(
// //   children: [
// //     Icon(
// //       Icons.access_time_sharp,
// //       color: Color(0xFF652981),
// //     ),
// //     SizedBox(
// //       width: 4,
// //     ),
// //     Text(controller.cashBackOffer.value
// //         .data![index].packageValidity!),
// //   ],
// // ),
// // Container(
// //   decoration: Ui.getBoxDecoration(
// //       color: Color(0xFF652981), radius: 8),
// //   child: Padding(
// //     padding: const EdgeInsets.only(
// //         left: 8.0, right: 8, top: 4, bottom: 4),
// //     child: Text(
// //       '৳' +
// //           controller.cashBackOffer.value
// //               .data![index].offerAmount!
// //               .toString(),
// //       style: TextStyle(color: Colors.white),
// //     ),
// //   ),
// // ),
// ],
// ),
// ),
// )),
