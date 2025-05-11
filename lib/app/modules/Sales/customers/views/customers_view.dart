import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/Sales/sale_now/controllers/sale_now_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';

import '../controllers/customers_controller.dart';

class CustomersView extends GetView<CustomersController> {
  const CustomersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF652981),
              title:
                  Text('Customers'.tr, style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: Obx(() {
              if (controller.customerListLoaded.isTrue) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      //search
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: Get.size.width * 0.8,
                              margin: const EdgeInsets.fromLTRB(15, 5, 0, 1),
                              padding: const EdgeInsets.only(top: 18, left: 20),
                              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(235, 235, 235, 1),
                                borderRadius: BorderRadius.circular(8.5),
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  controller.filterSearchResults(value);
                                },
                                controller: controller.searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search Customer'.tr,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                top: 10,
                                bottom: 10,
                              ),
                              child: Image.asset(
                                "assets/search.png",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: Get.height * .7,
                          child: ListView.builder(
                              itemCount: controller.customerNewList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (controller.isFromSaleNow.isTrue) {
                                      Get.find<SaleNowController>()
                                              .selectedCustomer
                                              .value =
                                          controller.customerNewList[index];
                                      print(
                                          'customer: ${Get.find<SaleNowController>().selectedCustomer.value.toJson()}');
                                      Get.back();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 1),
                                    child: Container(
                                      height: Get.size.width * .22,
                                      width: Get.size.width,
                                      decoration: const BoxDecoration(
                                        color: Colors.white70,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                height: Get.size.width * .15,
                                                image: const AssetImage(
                                                  'assets/images/user.png',
                                                ),
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: Get.size.width * .03,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    controller
                                                        .customerNewList[index]
                                                        .name!,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Get.size.width * .01,
                                                  ),
                                                  Text(
                                                    controller
                                                        .customerNewList[index]
                                                        .mobile!,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    controller
                                                        .customerNewList[index]
                                                        .address!,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: BlockButtonWidget(
            onPressed: () {
              Get.toNamed(Routes.CUSTOMER_ADD)?.then((value) {
                controller.getCustomerList();
              });
            },
            color: const Color(0xFF652981),
            radius: 30,
            text: Center(
              child: Text(
                '+ Add Customer'.tr,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
