import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sale_now_controller.dart';

class SaleNowView extends GetView<SaleNowController> {
  const SaleNowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          title: Text('Sell'.tr, style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: controller.currentPage,
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          child: Container(
            height: 60,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: const Color(0xFF652981).withOpacity(0.2),
                  blurRadius: 2,
                  offset: const Offset(0, 2)),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  minWidth: 30,
                  onPressed: () {
                    controller.currentIndex.value = 0;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        height: 16,
                        width: 16,
                        image: AssetImage('assets/icons/shopping-cart.png'),
                        color: controller.currentIndex.value == 0
                            ? Color(0xFF652981)
                            : Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'দ্রুত বিক্রি'.tr,
                          style: TextStyle(
                            color: controller.currentIndex.value == 0
                                ? const Color(0xFF652981)
                                : Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 30,
                  onPressed: () {
                    controller.currentIndex.value = 1;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        height: 16,
                        width: 16,
                        image: AssetImage('assets/icons/shopping-bag.png'),
                        color: controller.currentIndex.value == 1
                            ? Color(0xFF652981)
                            : Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'লিস্ট থেকে বিক্রি'.tr,
                          style: TextStyle(
                            color: controller.currentIndex.value == 1
                                ? Color(0xFF652981)
                                : Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
