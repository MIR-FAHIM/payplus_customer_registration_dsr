import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/add_balance/widgets/addbalance_drawer.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/add_balance_controller.dart';

class MFSListView extends GetView<AddbalanceController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Obx(
            () {
          return Scaffold(
            backgroundColor: Colors.white,
            endDrawer: AddBalanceDrawer(),
            appBar: PreferredSize(
              preferredSize: const Size(65, 65),
              child: AppBar(
                backgroundColor: const Color(0xFF652981),
                centerTitle: true,
                title: controller.paymentMethodId.value == "1" ? Text('MFS Method'.tr)
                    : controller.paymentMethodId.value == "3" ? Text('Bank Method'.tr)
                    : Text('Card Method'.tr) ,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                // actions: [
                //   IconButton(
                //       onPressed: () {},
                //       icon: Icon(
                //         CupertinoIcons.bell,
                //         color: Colors.white70,
                //       )),
                // ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  controller.paymentTypesMFS.value.isEmpty
                      ? Container(
                    height: _size.height,
                    width: _size.width,
                    child: Center(
                      child: Ui.customLoader(),
                    ),
                  )
                      : controller.dailyReportLoaded.isTrue
                      ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                            width: _size.width,
                            height: _size.height * .1,
                            decoration: Ui.getBoxDecoration(
                              color: AppColors.primaryColor.withOpacity(.6),
                              radius: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(controller.amount.value + " BDT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),



                              ],
                            )
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: _size.height,
                          width: _size.width,
                          color: Colors.white,
                          child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              primary: false,
                              shrinkWrap: true,
                              crossAxisCount: 1,
                              crossAxisSpacing: 18.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 4.0,
                              children: controller.paymentTypesMFS.isEmpty ?
                              Ui.customLoaderDialog()
                                  :List.generate(
                                  controller.paymentTypesMFS.where((p) => p.code != "visa" && p.code !="mastercard").toList().length, (index) {
                               var data = controller.paymentTypesMFS.where((p) => p.code != "visa" && p.code !="mastercard").toList()[index];
                                return GestureDetector(
                                  onTap: () {
                                    // var datas = {
                                    //   "name": controller.paymentTypesMFS[index].name!,
                                    //   "images": controller.paymentTypesMFS[index].logo!,
                                    //   "code": controller.paymentTypesMFS[index].code!,
                                    // };
                                    //   Get.toNamed(Routes.Add_Balance_Form_View, arguments: datas);
                                    controller.paymentOptionId.value =
                                       data.id!
                                            .toString();
                                    controller.paymentMethodCode.value =
                                        data.code!
                                            .toString();
                                    print("code is ${ controller.paymentMethodCode.value}");
                                    controller.bankName.value = data.name!;
                                    print(
                                        "hi hih hi hi hi hi ++++++++++++++++++++++++++++++++++${controller.paymentOptionId.value}");

                                    if (controller.paymentMethodId.value == 3) {

                                    } else {
                                      controller
                                          .getAddPaymentUrl()
                                          .then((e) {
                                        if (e == true) {
                                          print(
                                              "hlw moho +++++++++++++++++++++++++++++++++");
                                          Get.toNamed(
                                              Routes.CONFIRM_BANK_PAY);
                                        }
                                      });
                                    }
                                  },
                                  child: AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration:
                                    const Duration(milliseconds: 475),
                                    columnCount: 1,
                                    child: SlideAnimation(
                                      horizontalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Container(
                                          width: _size.width,
                                          height:  _size.height * .02,
                                          decoration: Ui.getBoxDecoration(
                                            color: Colors.white,
                                            radius: 5,
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 15,
                                                      ),

                                                      Container(
                                                        height: controller.grpValue.value == 3?80 : 80,
                                                        width: controller.grpValue.value == 3?80: 80,
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
                                                            imageUrl: data
                                                                .logo!,
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
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        data
                                                            .name!,
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),

                                                      const SizedBox(
                                                        width: 15,
                                                      ),

                                                      // Text(
                                                      //   Get.find<AuthService>()
                                                      //           .currentUser
                                                      //           .value
                                                      //           .mobileNumber ??
                                                      //       '',
                                                      //   style: TextStyle(
                                                      //     fontSize: 12,
                                                      //     color: Colors.black,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    color: StickyColors.colors[controller.random.nextInt(6)].withOpacity(.5),
                                                    border: Border.all(color: StickyColors.colors[controller.random.nextInt(6)].withOpacity(.5), width: 2),

                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(40.0),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      data
                                                          .charge!+ "%",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .homeTextColor3,
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        ),
                      ],
                    ),
                  )
                      : Container(
                    height: _size.height,
                    width: _size.width,
                    child: Center(
                      child: Ui.customLoader(),
                    ),
                  ),

                ],
              ),

            ),
          );
        }
    );
  }
}

class bodyItem extends StatelessWidget {
  const bodyItem({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size.width,
      decoration: Ui.getBoxDecoration(
        color: Colors.white,
        radius: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    'assets/images/Group.png',
                    height: 45,
                    width: 45,
                    color: const Color(0xFF652981),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'OTF',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'TK0.00',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
