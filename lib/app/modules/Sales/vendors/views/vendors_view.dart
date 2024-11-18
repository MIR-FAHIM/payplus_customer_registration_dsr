import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/Sales/buy_product/controllers/buy_product_controller.dart';

import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';

import '../controllers/vendors_controller.dart';

class VendorsView extends GetView<VendorsController> {
  const VendorsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF652981),
              title:
                  const Text('Vendors', style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            body: Obx(() {
              if (controller.vendorListLoaded.isTrue) {
                return Column(
                  children: [
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
                                hintText: 'Search Vendor'.tr,
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
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: List.generate(controller.vendorNewList.length,
                            (index) {
                          return GestureDetector(
                            onTap: () {
                              if (controller.isFromSaleNow.isTrue) {
                                Get.find<BuyProductController>()
                                    .selectedVendor
                                    .value = controller.vendorNewList[index];
                                print(
                                    'customer: ${Get.find<BuyProductController>().selectedVendor.value.toJson()}');
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
                                                  .vendorNewList[index].name!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.size.width * .01,
                                            ),
                                            Text(
                                              controller
                                                  .vendorNewList[index].mobile!,
                                              style: const TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              controller.vendorNewList[index]
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
                                      padding: EdgeInsets.only(right: 8.0),
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
                        }),
                      ),
                    ),
                  ],
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
              Get.toNamed(Routes.VENDOR_ADD)?.then((value) {
                controller.getVendorList();
              });
            },
            color: const Color(0xFF652981),
            radius: 30,
            text: const Center(
              child: Text(
                '+ Add Vendor',
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
