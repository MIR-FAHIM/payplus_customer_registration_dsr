import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/main_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:latest_payplus_agent/app/modules/home/views/home_view.dart';
import 'package:latest_payplus_agent/app/modules/inbox/controllers/inbox_controller.dart';
import 'package:latest_payplus_agent/app/modules/recharge/controllers/recharge_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/offer_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:badges/badges.dart' as badges;

//// ---> Custom Card Design <--- ////

class AddPayer extends GetView<OfferController> {
  const AddPayer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,


      /// ---> appbar <----
      appBar: PreferredSize(
        preferredSize: const Size(65, 65),
        child: AppBar(
          backgroundColor: const Color(0xFF652981),
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Row(
              children: [
                ProfileImage(),

                SizedBox(
                  width: 10,
                ),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Get.find<AuthService>().currentUser.value.outletName ??
                            '',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        Get.find<AuthService>()
                            .currentUser
                            .value
                            .mobileNumber ??
                            '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      // controller.packageLoad.value == true
                      //     ? SizedBox(
                      //         height: 10,
                      //         width: 10,
                      //         child: CircularProgressIndicator())
                      //     : InkWell(
                      //         onTap: () {
                      //           Get.toNamed(Routes.PACKAGELIST);
                      //         },
                      //         child: Text(
                      //           controller.currentPackageModel.value.data!
                      //               .packageName,
                      //           style: const TextStyle(
                      //             fontSize: 12,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //       ),
                    ],
                  );
                }),
                // Ui.offsetPopup()
              ],
            ),
          ),
          elevation: 0,
          actions: [
            Obx(() {
              return Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: Colors.redAccent,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    badgeContent: Text(Get.find<InboxController>()
                        .newNotificationNum
                        .toString()),
                    child: IconButton(
                        onPressed: () {
                          Get.lazyPut<RechargeController>(
                                () => RechargeController(),
                          );
                          Get.find<InboxController>().removeNewMsgNum();
                          Get.toNamed(Routes.Notification_View);
                        },
                        icon: const Icon(
                          CupertinoIcons.bell,
                          color: Colors.white70,
                        )),
                  )
                ],
              );
            }),
            IconButton(
                onPressed: () => {Scaffold.of(context).openEndDrawer()},
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white70,
                )),
          ],
        ),
      ),

      ///---> Body Part Showing coupon cards <---
      // body: Center(
      //   child: Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: Expanded(
      //         child: ListView.builder(
      //             itemCount: 4,
      //             itemBuilder: (context, index) {
      //               return couponWidget(
      //                   context: context,
      //                   cardColor: controller.cardColorList[index],
      //                   offColor: controller.offColorList[index],
      //                   offString: controller.offString[index],
      //                   couponString: controller.couponString[index],
      //                   shopName: controller.shopName[index],
      //                   iconName: controller.iconList[index]);
      //             }),
      //       )),
      // ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
                margin: const EdgeInsets.only(left: 13, right: 15, top: 10, bottom: 10),
                decoration: Ui.getBoxDecoration(
                  color: Colors.white,
                  radius: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Payer Name".tr,
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(
                            "*".tr,
                            style: TextStyle(color: AppColors.redTextColor),
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      // controller: controller.nameController,
                      keyboardType: TextInputType.text,
                      style: Get.textTheme.bodyMedium,
                      onChanged: (input) {

                      },

                      // validator: (input) {
                      //   if (controller.nameController.text.isEmpty) {
                      //     return 'This field is required'.tr;
                      //   } else {
                      //     return null;
                      //   }
                      // },

                      cursorColor: const Color(0xFF652981),
                      decoration: InputDecoration(hintText: "Enter Product Name".tr, border: InputBorder.none),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
                margin: const EdgeInsets.only(left: 13, right: 15, top: 10, bottom: 10),
                decoration: Ui.getBoxDecoration(
                  color: Colors.white,
                  radius: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Payer Mobile".tr,
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(
                            "*".tr,
                            style: TextStyle(color: AppColors.redTextColor),
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      // controller: controller.nameController,
                      keyboardType: TextInputType.number,
                      style: Get.textTheme.bodyMedium,
                      onChanged: (input) {

                      },
                      // validator: (input) {
                      //   if (controller.nameController.text.isEmpty) {
                      //     return 'This field is required'.tr;
                      //   } else {
                      //     return null;
                      //   }
                      // },

                      cursorColor: const Color(0xFF652981),
                      decoration: InputDecoration(hintText: "Enter Stock Amount".tr, border: InputBorder.none),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
                margin: const EdgeInsets.only(left: 13, right: 15, top: 10, bottom: 10),
                decoration: Ui.getBoxDecoration(
                  color: Colors.white,
                  radius: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Payer Address".tr,
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(
                            "*".tr,
                            style: TextStyle(color: AppColors.redTextColor),
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      // controller: controller.nameController,
                      keyboardType: TextInputType.number,
                      style: Get.textTheme.bodyMedium,
                      onChanged: (input) {

                      },
                      // validator: (input) {
                      //   if (controller.nameController.text.isEmpty) {
                      //     return 'This field is required'.tr;
                      //   } else {
                      //     return null;
                      //   }
                      // },

                      cursorColor: const Color(0xFF652981),
                      decoration: InputDecoration(hintText: "Enter Sell Price".tr, border: InputBorder.none),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 14, left: 20, right: 20),
                margin: const EdgeInsets.only(left: 13, right: 15, top: 10, bottom: 10),
                decoration: Ui.getBoxDecoration(
                  color: Colors.white,
                  radius: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Payer Description".tr,
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(
                            "*".tr,
                            style: TextStyle(color: AppColors.redTextColor),
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      // controller: controller.nameController,
                      keyboardType: TextInputType.text,
                      style: Get.textTheme.bodyMedium,
                      onChanged: (input) {

                      },
                      // validator: (input) {
                      //   if (controller.nameController.text.isEmpty) {
                      //     return 'This field is required'.tr;
                      //   } else {
                      //     return null;
                      //   }
                      // },

                      cursorColor: const Color(0xFF652981),
                      decoration: InputDecoration(hintText: "Enter Product Description".tr, border: InputBorder.none),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,

                  boxShadow: [
                    BoxShadow(color: const Color.fromARGB(255, 43, 42, 43).withOpacity(0.2), blurRadius: 2, offset: const Offset(0, -2)),
                  ],
                  //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      width: Get.width,
                      height: Get.width * .1,
                      decoration: Ui.getBoxDecoration(color: const Color(0xFF652981), radius: 10),
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
        ),
      ),
    );
  }

  Widget couponWidget(
      {context,
        offColor,
        cardColor,
        String? offString,
        String? couponString,
        String? shopName,
        required IconData iconName}) {
    return Stack(children: [
      Positioned(
        top: 30.0,
        left: 16.0,
        right: 16.0,
        child: SizedBox(
            child: Row(
              children: [
                Icon(
                  iconName,
                  size: 100,
                  color: Vx.white,
                ),
                SizedBox(
                  width: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    10.heightBox,
                    "You Get".text.size(14).gray200.make(),
                    40.heightBox,
                    shopName!.text.white.size(22).semiBold.make(),
                    5.heightBox,
                    couponString!.text.white.size(15).make(),
                  ],
                )
              ],
            ))
            .box
            .size(Get.width * 0.9, Get.height * 0.2)
            .rounded
            .color(cardColor)
            .make(),
      ),
      Positioned(
          top: 20,
          right: 10,
          child: offString!.text.white
              .size(25)
              .makeCentered()
              .box
              .size(50, 50)
              .color(offColor)
              .roundedFull
              .make())
    ]).box.size(Get.width * 0.9, Get.height * 0.25).make();
  }

  Widget payerWidget(
      {context,
        offColor,
        cardColor,
        String? offString,
        String? couponString,
        String? shopName,
        required IconData iconName}) {
    return Card(
      child: SizedBox(
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                child: Icon(Icons.supervised_user_circle_outlined),
              ),
              SizedBox(
                width: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  10.heightBox,
                  shopName!.text.white.size(14).semiBold.make(),
                  5.heightBox,
                  couponString!.text.white.size(15).make(),
                ],
              )
            ],
          ))
          .box
          .size(Get.width * 0.9, Get.height * 0.2)
          .rounded
          .color(cardColor)
          .make().box.size(Get.width * 0.9, Get.height * 0.1).make(),
    );
  }
}
