import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:latest_payplus_agent/app/modules/payment_collection/controllers/payment_collection_controller.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class PaymentCollectionBankSelectionView
    extends GetView<PaymentCollectionController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: PreferredSize(
      //   preferredSize: Size(65, 65),
      //   child: AppBar(
      //     backgroundColor: Color(0xFF652981),
      //     centerTitle: true,
      //     elevation: 0,
      //   ),
      // ),
      body: Obx(() {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 180,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Color(0xFF652981),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF652981).withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5)),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 50),
                  ),
                  Container(
                    decoration: Ui.getBoxDecoration(
                      radius: 100,
                      color: Colors.white,
                      border: Border.all(
                        width: 5,
                        color: Colors.white,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          'assets/Logo.png',
                          fit: BoxFit.contain,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: _size.width * .5,
                decoration: Ui.getBoxDecoration(
                  color: Colors.white,
                  radius: 5,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Pay Station'.tr,
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF652981),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.currentIndex.value = 0;
                        },
                        child: Container(
                          width: _size.width * .3,
                          decoration: Ui.getBoxDecoration(
                            color: controller.currentIndex == 0
                                ? Color(0xFF652981)
                                : Colors.white,
                            radius: 5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Mobile Banking'.tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: controller.currentIndex == 0
                                      ? Colors.white
                                      : Get.theme.textTheme.bodyMedium!.color,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.currentIndex.value = 1;
                        },
                        child: Container(
                          width: _size.width * .3,
                          decoration: Ui.getBoxDecoration(
                            color: controller.currentIndex == 1
                                ? Color(0xFF652981)
                                : Colors.white,
                            radius: 5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Card'.tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: controller.currentIndex == 1
                                      ? Colors.white
                                      : Get.theme.textTheme.bodyMedium!.color,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.currentIndex.value = 2;
                        },
                        child: Container(
                          width: _size.width * .3,
                          decoration: Ui.getBoxDecoration(
                            color: controller.currentIndex == 2
                                ? Color(0xFF652981)
                                : Colors.white,
                            radius: 5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Net Banking'.tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: controller.currentIndex == 2
                                      ? Colors.white
                                      : Get.theme.textTheme.bodyMedium!.color,
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
              controller.pages[controller.currentIndex.value],
              SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      }),
    );
  }
}
