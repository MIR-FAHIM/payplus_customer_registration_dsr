import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/operator_model.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/device_contact_book.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/mobile_number_pad.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/offer_button.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/operator_wise/operatorwise_offer_view.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/recharge_drawer.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../../../../common/custom_data.dart';
import '../controllers/recharge_controller.dart';

class RechargeView extends GetView<RechargeController> {

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
              title: Text('Mobile Recharge'.tr),
              elevation: 0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    if (controller.contactLoad.value == true) {
                      controller.contactLoad.value = false;
                    }else{
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
            if (controller.contactLoad.value == true) {
              controller.contactLoad.value = false;
            }else{
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
                  if (controller.contactLoad.value == true) {
                    return ContactsPanel();
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                              children: [
                                MobileNumberCard(),



                                SizedBox(
                                  height: 15,
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

                                controller.operatorWiseOfferLoad.value == true
                                ? OperatorwiseOfferView()
                                    : Column(
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
                                                  controller.mobileNumberFocus.value
                                                      .unfocus();
                                                  controller.currentIndex.value = 0;
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: Ui.getIconButton(
                                                      color: controller
                                                          .currentIndex ==
                                                          0
                                                          ? const Color(0xFF652981)
                                                          : Colors.white,
                                                      textColor:
                                                      controller.currentIndex ==
                                                          0
                                                          ? Colors.white
                                                          : Get.theme.textTheme
                                                          .bodyMedium!.color,
                                                      text: 'Amount'.tr,
                                                      horrizontal: 10,
                                                      vertical: 5,
                                                      radius: 5),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.mobileNumberFocus.value
                                                      .unfocus();
                                                  controller.currentIndex.value = 1;
                                                  // controller.getBundle('3');
                                                  controller.getCashBackOffer();
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: Ui.getIconButton(
                                                      color: controller
                                                          .currentIndex ==
                                                          1
                                                          ? const Color(0xFF652981)
                                                          : Colors.white,
                                                      textColor:
                                                      controller.currentIndex ==
                                                          1
                                                          ? Colors.white
                                                          : Get.theme.textTheme
                                                          .bodyMedium!.color,
                                                      text: 'CashBack'.tr,
                                                      horrizontal: 10,
                                                      vertical: 5,
                                                      radius: 5),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.mobileNumberFocus.value
                                                      .unfocus();
                                                  controller.currentIndex.value = 2;
                                                  controller.getInternet('1');
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: Ui.getIconButton(
                                                      color: controller
                                                          .currentIndex ==
                                                          2
                                                          ? const Color(0xFF652981)
                                                          : Colors.white,
                                                      textColor:
                                                      controller.currentIndex ==
                                                          2
                                                          ? Colors.white
                                                          : Get.theme.textTheme
                                                          .bodyMedium!.color,
                                                      text: 'Internet'.tr,
                                                      horrizontal: 10,
                                                      vertical: 5,
                                                      radius: 5),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.mobileNumberFocus.value
                                                      .unfocus();
                                                  controller.currentIndex.value = 3;
                                                  controller.getMinute('2');
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: Ui.getIconButton(
                                                      color: controller
                                                          .currentIndex ==
                                                          3
                                                          ? const Color(0xFF652981)
                                                          : Colors.white,
                                                      textColor:
                                                      controller.currentIndex ==
                                                          3
                                                          ? Colors.white
                                                          : Get.theme.textTheme
                                                          .bodyMedium!.color,
                                                      text: 'Minute'.tr,
                                                      horrizontal: 10,
                                                      vertical: 5,
                                                      radius: 5),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.mobileNumberFocus.value
                                                      .unfocus();
                                                  controller.currentIndex.value = 4;
                                                  controller.getBundle('3');
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: Ui.getIconButton(
                                                      color: controller
                                                          .currentIndex ==
                                                          4
                                                          ? const Color(0xFF652981)
                                                          : Colors.white,
                                                      textColor:
                                                      controller.currentIndex ==
                                                          4
                                                          ? Colors.white
                                                          : Get.theme.textTheme
                                                          .bodyMedium!.color,
                                                      text: 'Bundle'.tr,
                                                      horrizontal: 10,
                                                      vertical: 5,
                                                      radius: 5),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.mobileNumberFocus.value
                                                      .unfocus();
                                                  controller.currentIndex.value = 5;
                                                  controller.getSpecialRate('4');
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: Ui.getIconButton(
                                                      color: controller
                                                          .currentIndex ==
                                                          5
                                                          ? const Color(0xFF652981)
                                                          : Colors.white,
                                                      textColor:
                                                      controller.currentIndex ==
                                                          5
                                                          ? Colors.white
                                                          : Get.theme.textTheme
                                                          .bodyMedium!.color,
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
                                              //                 .theme.textTheme.bodyMedium!.color,
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
                                  ],
                                )



                                // controller.currentPage
                              ],
                            )

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
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.asset(operatorLogos[index].logo!),
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
