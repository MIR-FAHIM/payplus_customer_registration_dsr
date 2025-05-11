import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/models/buysell/expenses_details_by_head_model.dart';

import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/expenses_details_by_head_controller.dart';

class ExpensesDetailsByHeadView
    extends GetView<ExpensesDetailsByHeadController> {
  ExpensesDetailsByHeadView({Key? key}) : super(key: key);
  final _size = Get.size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(65, 65),
        child: AppBar(
          backgroundColor: const Color(0xFF652981),
          centerTitle: true,
          title: Obx(() {
            return Text(controller.expensesDetailsLoaded.isTrue
                ? controller.expenseHeadTitle.value
                : '');
          }),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
        ),
      ),
      body: Obx(() {
        if (controller.expensesDetailsLoaded.isTrue) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      // width: _size.width * 0.45,
                      // height: 100,
                      // color: AppColors.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    'Select Start Date'.tr,
                                    style: TextStyle(
                                        color: AppColors.homeTextColor3,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.selectDate(context, 'start');
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    decoration: BoxDecoration(
                                      color: AppColors.primarydeepLightColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(width: 20),
                                          Image.asset(
                                            'assets/icons/calender.png',
                                            height: 10,
                                            width: 10,
                                            color: AppColors.homeTextColor1,
                                          ),
                                          IconGap(),
                                          Text(
                                            "তারিখ",
                                            style: TextStyle(
                                                color: AppColors.homeTextColor1,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          ),
                                          const SizedBox(width: 20),
                                          Image.asset(
                                            'assets/icons/down_arrow.png',
                                            height: 10,
                                            width: 10,
                                            color: AppColors.homeTextColor1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    'Select End Date'.tr,
                                    style: TextStyle(
                                        color: AppColors.homeTextColor3,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.selectDate(context, 'end');
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    decoration: BoxDecoration(
                                      color: AppColors.primarydeepLightColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(width: 20),
                                          Image.asset(
                                            'assets/icons/calender.png',
                                            height: 10,
                                            width: 10,
                                            color: AppColors.homeTextColor1,
                                          ),
                                          IconGap(),
                                          Text(
                                            "তারিখ",
                                            style: TextStyle(
                                                color: AppColors.homeTextColor1,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          ),
                                          const SizedBox(width: 20),
                                          Image.asset(
                                            'assets/icons/down_arrow.png',
                                            height: 10,
                                            width: 10,
                                            color: AppColors.homeTextColor1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                    //       margin: const EdgeInsets.only(top: 3),
                    //       width: MediaQuery.of(context).size.width * 0.42,
                    //       decoration: BoxDecoration(
                    //         color: AppColors.homeCardBg,
                    //         border: Border.all(
                    //             color: Theme.of(context).primaryColor, width: 1),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             const SizedBox(width: 10),
                    //             Text(
                    //               "Select Section".tr,
                    //               style: TextStyle(
                    //                   color: AppColors.primaryColor,
                    //                   fontWeight: FontWeight.w400,
                    //                   fontSize: 13),
                    //             ),
                    //             const SizedBox(width: 8),
                    //             Image.asset(
                    //               'assets/icons/down_arrow.png',
                    //               height: 10,
                    //               width: 10,
                    //               color: AppColors.homeTextColor1,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                          children: List.generate(
                              controller.expensesDetails.value.data!.length,
                              (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, bottom: 15),
                          child: InkWell(
                            onTap: () {
                              openBottomSheet(controller
                                  .expensesDetails.value.data![index]);

                              // Get.bottomSheet(InputPartialPayment());
                            },
                            child: Container(
                              width: _size.width,
                              decoration: Ui.getBoxDecoration(
                                color: Colors.white,
                                radius: 8,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CachedNetworkImage(
                                            height: 60,
                                            width: 60,
                                            imageUrl: controller.expensesDetails
                                                    .value.data![index].image ??
                                                '',
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/Logo.png'),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/Logo.png'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5.0),
                                          child: Column(
                                            /// Text Information Item
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                controller.expensesDetails.value
                                                    .data![index].expenseHead!,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Sans",
                                                    color: Colors.black87,
                                                    fontSize: 12.0),
                                                overflow: TextOverflow.clip,
                                              ),
                                              // const SizedBox(
                                              //   height: 3.0,
                                              // ),
                                              // Text(
                                              //   'সময় : ${controller.expensesDetails.value.data![index].expenseDate}',
                                              //   style: TextStyle(
                                              //       fontFamily: "Sofia",
                                              //       color: AppColors.homeTextColor3,
                                              //       fontSize: 10),
                                              //   overflow: TextOverflow.ellipsis,
                                              // ),
                                              const SizedBox(
                                                height: 3.0,
                                              ),
                                              Text(
                                                'তারিখ : ${controller.expensesDetails.value.data![index].expenseDate}',
                                                style: TextStyle(
                                                    fontFamily: "Sofia",
                                                    color: AppColors
                                                        .homeTextColor3,
                                                    fontSize: 10),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            '৳ ${controller.expensesDetails.value.data![index].amount}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Sofia",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          // SizedBox(
                                          //   width: 10,
                                          // ),
                                          // Image.asset(
                                          //   "assets/icons/edit_icon02.png",
                                          //   width: 12,
                                          //   height: 12,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,

                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(255, 43, 42, 43)
                            .withOpacity(0.2),
                        blurRadius: 2,
                        offset: const Offset(0, -2)),
                  ],
                  //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.ADD_NEW_EXPENSES);
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
                            "+ " + 'Add New Expense'.tr,
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
          );
        } else {
          return Center(child: Ui.customLoader());
        }
      }),
    );
  }

  void openBottomSheet(ExpensesDetailsByHead expensesDetails) {
    Get.bottomSheet(
      Container(
        height: Get.size.width * .8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.cancel_rounded),
                      iconSize: 30,
                      color: Colors.grey,
                      splashColor: Colors.purple,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      height: 60,
                      width: 60,
                      imageUrl: expensesDetails.image ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image(
                          image: AssetImage('assets/Logo.png'),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image(
                          image: AssetImage('assets/Logo.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'কারণ :  ${expensesDetails.expenseHead}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                // const Center(
                //   child: Text(
                //     'সময় : ১১:০৯ PM',
                //     style: TextStyle(fontSize: 14, color: Colors.grey),
                //   ),
                // ),
                Center(
                  child: Text(
                    'তারিখ :  ${expensesDetails.expenseDate}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 8),
                //   child: GestureDetector(
                //     onTap: () {
                //       //  Get.dialog(ConfirmDialog());
                //       // Get.to(SalePaymentSystem());
                //     },
                //     child: Container(
                //       width: _size.width * 0.4,
                //       height: _size.width * .12,
                //       decoration:
                //           Ui.getBoxDecoration(color: const Color(0xFF652981), radius: 10),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Icon(
                //             Icons.edit,
                //             color: AppColors.homeCardBg,
                //             size: 15,
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           Text(
                //             'Edit'.tr,
                //             style: TextStyle(
                //               fontSize: 14,
                //               color: AppColors.homeCardBg,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      controller.deleteExpense(expensesDetails.id.toString());
                    },
                    child: Container(
                      width: _size.width * 0.4,
                      height: _size.width * .12,
                      decoration: Ui.getBoxDecoration(
                          color: const Color(0xFF652981), radius: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: AppColors.homeCardBg,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Delete'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.homeCardBg,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            // OutlinedButton(
            //   onPressed: () {
            //     Get.back();
            //   },
            //   child: const Text('Close'),
            // ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  SizedBox IconGap() {
    return const SizedBox(
      width: 4,
    );
  }
}
