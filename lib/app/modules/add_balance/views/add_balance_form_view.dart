import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/add_balance/controllers/add_balance_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../../../../common/Color.dart';
import '../../../routes/app_pages.dart';

class AddBalanceFormView extends GetView<AddbalanceController> {
  @override
  Widget build(BuildContext context) {
    // var _name = Get.arguments['name'];
    // var _images = Get.arguments['images'];
    // var _code = Get.arguments['code'];
    // var _name = controller.mfsName.value;
    // var _images = controller.mfsLogo.value;
    //controller.gateway.value = _code;
    final _size = Get.size;
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text("Add Balance".tr),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.getCollectionDetailsController();
                    Get.toNamed(Routes.COLLECTION);
                  },
                  icon: Icon(
                    CupertinoIcons.time,
                    color: Colors.white70,
                  )),
              // IconButton(
              //     onPressed: () {},
              //     icon: Icon(
              //       CupertinoIcons.filter,
              //       color: Colors.white70,
              //     )),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Obx(() {
            return Container(
              // width: _size.width,
              height: _size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // Center(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Text(
                    //       _name,
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //         color: Color(0xFF652981),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // Container(
                    //   height: 80,
                    //   width: 80,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(30),
                    //     child: CachedNetworkImage(
                    //       imageUrl: _images,
                    //       imageBuilder: (context, imageProvider) => Container(
                    //         decoration: BoxDecoration(
                    //           image: DecorationImage(
                    //             image: imageProvider,
                    //             fit: BoxFit.fill,
                    //           ),
                    //         ),
                    //       ),
                    //       placeholder: (context, url) => Padding(
                    //         padding: const EdgeInsets.all(5.0),
                    //         child: Image(
                    //           image: AssetImage('assets/images/default_image.png'),
                    //         ),
                    //       ),
                    //       errorWidget: (context, url, error) => Padding(
                    //         padding: const EdgeInsets.all(5.0),
                    //         child: Image(
                    //           image: AssetImage('assets/images/default_image.png'),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    TextFieldWidget(
                      keyboardType: TextInputType.number,
                      labelText: "Amount".tr,
                      hintText: "Enter Amount".tr,
                      onChanged: (input) {
                        controller.amount.value = input;
                      },
                      // onSaved: (input) =>
                      // controller.currentUser.value.email = input,
                      // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                      iconData: null,
                      imageData: 'assets/icons/price.png',
                    ),

                    TextFieldWidget(
                      labelText: "Mobile No".tr,
                      hintText: "Enter Mobile No.".tr,
                      readOnly: true,
                      initialValue: Get.find<AuthService>()
                              .currentUser
                              .value.mobileNumber??
                          '',
                      // onSaved: (input) =>
                      // controller.currentUser.value.email = input,
                      // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                      iconData: CupertinoIcons.device_phone_portrait,
                    ),
                    // Container(
                    //   child: CheckBoxWidget(
                    //     title: 'Save the account'.tr,


                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: _size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: _size.width * .3,
                            child: RadioListTile(
                              tileColor: Colors.purpleAccent.withOpacity(.2),
                              title: Text(
                                "MFS",
                                style: TextStyle(fontSize: 12),
                              ),
                              value: 1,
                              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              groupValue: controller.grpValue.value,
                              onChanged: (value) {
                                controller.grpValue.value =
                                    int.parse(value.toString());
                              },
                            ),
                          ),
                          Container(
                            height: Get.height *.05,
                            width: 2,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: _size.width * .3,
                            child: RadioListTile(
                              tileColor: Colors.purpleAccent.withOpacity(.2),
                              title: Text(
                                "Bank",
                                style: TextStyle(fontSize: 12),
                              ),
                              value: 3,
                              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              groupValue: controller.grpValue.value,
                              onChanged: (value) {
                                // controller.grpValue.value = 3;
                                // Get.snackbar("hlw bro", "Is everything okay");
                                Get.showSnackbar(
                                    Ui.ErrorSnackBar(message: "Coming soon.....", title: 'Error'.tr));
                                // controller.grpValue.value =
                                //     int.parse(value.toString());
                                //
                                print("+++++++${controller.grpValue.value}");
                              },
                            ),
                          ),
                          Container(
                            height: Get.height *.05,
                            width: 2,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: _size.width * .35,
                            child: RadioListTile(
                              tileColor: Colors.purpleAccent.withOpacity(.2),
                              title: Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/master.png',
                                    height: Get.size.width * .07,
                                    width: Get.size.width *.08,

                                  ),
                                  Text("/"),
                                  Image.asset(
                                    'assets/icons/visa.png',
                                    height: Get.size.width * .07,
                                    width: Get.size.width *.08,
                                  ),
                                ],
                              ),
                              value: 2,
                              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              groupValue: controller.grpValue.value,
                              onChanged: (value) {
                                // Get.showSnackbar(Ui.ErrorSnackBar(
                                //     message: "Coming Soon...",
                                //     title: 'Error'.tr));
                                controller.grpValue.value =
                                    int.parse(value.toString());

                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    BlockButtonWidget(
                      onPressed: () {
                        if (controller.amount.value.isEmpty) {
                          Get.showSnackbar(Ui.ErrorSnackBar(
                              message: "Please give an amount",
                              title: 'error'.tr));
                        } else {
                          controller.paymentMethodId.value =
                              controller.grpValue.value.toString();
                          if (controller.grpValue.value == 3) {
                            print("working here ___________ hlw 1");
                            controller
                                .getPaymentTypeController(
                                    controller.grpValue.value)
                                .then((e) {
                              if (controller.grpValue.value == 3) {
                                controller.getBankChargeListController(3);
                              }
                            });
                          } else if (controller.grpValue.value == 2) {
                            // print("working here ___________ hlw 2");
                            // controller
                            //     .getPaymentTypeController(
                            //         controller.grpValue.value)
                            //     .then((e) {
                            //   if (controller.grpValue.value == 3) {
                            //     controller.getBankChargeListController(3);
                            //   } else {
                            //     Get.toNamed(Routes.Add_Balance_Dashboard_View);
                            //   }
                            // });

                            if(int.parse(controller.amount.value) <2000 ){
                              Get.showSnackbar(Ui.ErrorSnackBar(
                                  message: "Minimum Payment amount is 2000 Taka.",
                                  title: 'error'.tr));
                            }else{
                              controller.getPaymentType().then((e) {
                                controller.getCardCharge();

                              });
                            }
                          } else {
                            controller.getPaymentType().then((e) {
                              Get.toNamed(Routes.MFSLIST);
                            });
                          }
                        }

                        //  print(_code);

                        //controller.getAddPaymentUrl();
                      },
                      color: Color(0xFF652981),
                      text: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          "Proceed to Pay".tr,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ).paddingSymmetric(vertical: 10, horizontal: 20),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
