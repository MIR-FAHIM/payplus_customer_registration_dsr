import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/widgets/sales_options_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/sales_controller.dart';

class SalesView extends GetView<SalesController> {
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
          title: Text('Sales'.tr),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.ROOT);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white70,
              )),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Get.toNamed(Routes.Notification_View);
          //       },
          //       icon: Icon(
          //         CupertinoIcons.bell,
          //         color: Colors.white70,
          //       )),
          // ],
        ),
      ),
      body: Obx(() {
        if (controller.buysellLoaded.isTrue) {
          return SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: _size.width,
                    height: _size.width * .2,
                    decoration: Ui.getBoxDecoration(color: Colors.white, radius: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: Column(
                        children: [


                          Text(
                            'Today Sale'.tr,
                            style: const TextStyle(
                              color: Color(0xFF652981),
                            ),
                          ),
                          Text(
                            '৳ ${controller.buysellReport['sell']}',
                            style: TextStyle(
                              color: Color(0xFF652981),
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
                    height: _size.width * .2,
                    decoration: Ui.getBoxDecoration(color: Colors.white, radius: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Today Earnings'.tr,
                                style: const TextStyle(
                                  color: Color(0xFF652981),
                                ),
                              ),
                              Text(
                                '৳ ${controller.buysellReport['sell']}',
                                style: TextStyle(
                                  color: Color(0xFF652981),
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            color: Color(0xFF652981),
                            thickness: 2,
                          ),
                          Column(
                            children: [
                              Text(
                                'Today Payout'.tr,
                                style: const TextStyle(
                                  color: Color(0xFF652981),
                                ),
                              ),
                              Text(
                                '৳ ${controller.buysellReport['expense']}',
                                style: TextStyle(
                                  color: Color(0xFF652981),
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            color: Color(0xFF652981),
                            thickness: 2,
                          ),
                          Column(
                            children: [
                              Text(
                                'Today Buy'.tr,
                                style: const TextStyle(
                                  color: Color(0xFF652981),
                                ),
                              ),
                              Text(
                                '৳ ${controller.buysellReport['buy']}',
                                style: TextStyle(
                                  color: Color(0xFF652981),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                    ),
                  ),
                ),

                SalesOptionWidget(),
              ],
            ),
          );
        } else {
          return Center(child: Ui.customLoader());
        }
      }),
    );
  }
}
