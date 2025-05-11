import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';

import '../controllers/fast_sales_details_controller.dart';

class FastSalesDetailsView extends GetView<FastSalesDetailsController> {
  const FastSalesDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF652981),
              title: Text('Sale Details'.tr),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: Get.size.width * .2,
                    width: Get.size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.person_add_solid,
                                color: Get.theme.primaryColor,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Add Customer'.tr,
                                style: TextStyle(
                                  color: Get.theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Get.theme.primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product List:'.tr,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: List.generate(3, (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            color: Get.theme.primaryColor,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Product Name X 1',
                                            style: TextStyle(
                                              color: Get.theme.primaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'BDT 0.00',
                                            style: TextStyle(
                                              color: Get.theme.primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Discount',
                                style: TextStyle(
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                              Text(
                                '10%',
                                style: TextStyle(
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'BDT 0.00',
                                style: TextStyle(
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: BlockButtonWidget(
            onPressed: () {},
            color: Color(0xFF652981),
            radius: 30,
            text: const Center(
              child: Text(
                'Total BDT 0.00',
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
