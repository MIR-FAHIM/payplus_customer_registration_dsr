import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:flutter/cupertino.dart';
import '../controllers/product_list_for_buy_controller.dart';

class ProductListForBuyView extends GetView<ProductListForBuyController> {
  ProductListForBuyView({Key? key}) : super(key: key);
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(65, 65),
        child: AppBar(
          backgroundColor: const Color(0xFF652981),
          centerTitle: true,
          title: Text('Product List'.tr, style: TextStyle(color: Colors.white)),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.Notification_View);
                },
                icon: const Icon(
                  CupertinoIcons.bell,
                  color: Colors.white70,
                )),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.productLoaded.isTrue) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  //search
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: _size.width * 0.9,
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
                            hintText: 'Search Product'.tr,
                            // icon: Image.asset(
                            //   "assets/images/cart.png",
                            //   width: 15,
                            //   height: 15,
                            // ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: _size.width,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2), // Shadow position
                          blurRadius: 6, // Blur radius
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16), // Uniform padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Product'.tr +
                                " : ${controller.productList.value.data!.length}",
                            style: TextStyle(
                              fontSize: 16, // Increase font size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                          Text(
                            'Buy Price'.tr +
                                ": ৳ ${controller.calculateBuyingPrice()}",
                            style: TextStyle(
                              fontSize: 16, // Increase font size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  //product
                  SingleChildScrollView(
                    child: Column(
                      children: List.generate(controller.productItems.length,
                          (index) {
                        return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.PRODUCT_DETAILS,
                                  arguments: controller.productItems[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryLightColor,
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.1),
                                    blurRadius: 4.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, // Align items at the top
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15.0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black12.withOpacity(0.1),
                                            blurRadius: 2.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl: controller
                                                  .productItems[index].image ??
                                              '',
                                          height: _size.width * .15,
                                          width: _size.width * .15,
                                          placeholder: (context, url) =>
                                              const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Image(
                                              image:
                                                  AssetImage('assets/Logo.png'),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Image(
                                              image:
                                                  AssetImage('assets/Logo.png'),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                // Allow text to take available space
                                                child: Text(
                                                  controller.productItems[index]
                                                      .name!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Sans",
                                                    color: AppColors
                                                        .homeTextColor3,
                                                    fontSize: 14.0,
                                                  ),
                                                  overflow: TextOverflow
                                                      .ellipsis, // Handle overflow
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: controller
                                                                .productItems[
                                                                    index]
                                                                .isActive ==
                                                            1
                                                        ? Colors.green
                                                        : Colors.red,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                child: Center(
                                                  child: Text(
                                                    controller
                                                                .productItems[
                                                                    index]
                                                                .isActive ==
                                                            1
                                                        ? 'Active'
                                                        : 'Deactivate',
                                                    style: TextStyle(
                                                      color: controller
                                                                  .productItems[
                                                                      index]
                                                                  .isActive ==
                                                              1
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              _buildStockInfo(
                                                  'In Stock'.tr,
                                                  controller.productItems[index]
                                                      .stockAlert!),
                                              _buildPriceInfo(
                                                  'Buy Price'.tr,
                                                  controller.productItems[index]
                                                      .buyingPrice!
                                                      .toDouble()),
                                              _buildPriceInfo(
                                                  'Sell Price'.tr,
                                                  controller.productItems[index]
                                                      .sellingPrice!
                                                      .toDouble()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                      "assets/icons/right_arrow.png",
                                      width: 15,
                                      height: 15,
                                    ),
                                  ),
                                ],
                              ),
                            )

// Helper methods to create price and stock info

                            );
                      }),
                    ),
                  ),
                  const SizedBox(height: 3),
                  // Container(
                  //   color: AppColors.SecondbackgroundColor,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: <Widget>[
                  //       Padding(
                  //           padding: const EdgeInsets.all(10.0),
                  //
                  //           /// Image item
                  //           child: Container(
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius:
                  //                       const BorderRadius.all(const Radius.circular(15.0)),
                  //                   image: const DecorationImage(
                  //                       image: const AssetImage('assets/images/shop.png')),
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                         color: Colors.black12.withOpacity(0.1),
                  //                         blurRadius: 0.5,
                  //                         spreadRadius: 0.1)
                  //                   ]),
                  //               child: Container(
                  //                 height: 65.0,
                  //                 width: 65.0,
                  //                 decoration: const BoxDecoration(
                  //                   borderRadius:
                  //                       const BorderRadius.all(Radius.circular(15.0)),
                  //                   image: const DecorationImage(
                  //                       image: AssetImage('assets/images/shop.png')),
                  //                 ),
                  //               ))),
                  //       Flexible(
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                  //           child: Column(
                  //             /// Text Information Item
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: <Widget>[
                  //               Row(
                  //                 children: [
                  //                   Container(
                  //                     width: 100.0,
                  //                     child: const Text(
                  //                       'Dell Monitor',
                  //                       style: TextStyle(
                  //                           fontWeight: FontWeight.w600,
                  //                           fontFamily: "Sans",
                  //                           color: Colors.black87,
                  //                           fontSize: 14.0),
                  //                       overflow: TextOverflow.clip,
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     // width:
                  //                     //     MediaQuery.of(context).size.width * 0.4,
                  //                     // height: 25,
                  //                     decoration: BoxDecoration(
                  //                       color: Theme.of(context).secondaryHeaderColor,
                  //                       border: Border.all(color: Colors.green, width: 1),
                  //                       borderRadius: BorderRadius.circular(10),
                  //                     ),
                  //                     child: const Padding(
                  //                       padding: EdgeInsets.only(
                  //                           left: 8, right: 8, top: 3, bottom: 3),
                  //                       child: const Center(
                  //                         child: Text(
                  //                           'Active',
                  //                           style: TextStyle(
                  //                               color: Colors.green,
                  //                               fontWeight: FontWeight.bold,
                  //                               fontSize: 12),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               const SizedBox(
                  //                 height: 8.0,
                  //               ),
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //                 children: [
                  //                   Column(
                  //                     children: [
                  //                       Text(
                  //                         'In Stock'.tr,
                  //                         style: TextStyle(
                  //                             fontWeight: FontWeight.w300,
                  //                             fontFamily: "Sofia",
                  //                             color: AppColors.homeTextColor3,
                  //                             fontSize: 12),
                  //                         overflow: TextOverflow.ellipsis,
                  //                       ),
                  //                       const Padding(
                  //                         padding: EdgeInsets.only(bottom: 5.0, top: 5),
                  //                         child: const Text(
                  //                           '১০',
                  //                           style: const TextStyle(
                  //                               color: Colors.black,
                  //                               fontFamily: "Sofia",
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w700),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   Column(
                  //                     children: [
                  //                       Text(
                  //                         'Buy Price'.tr,
                  //                         style: TextStyle(
                  //                             fontWeight: FontWeight.w300,
                  //                             fontFamily: "Sofia",
                  //                             color: AppColors.homeTextColor3,
                  //                             fontSize: 12),
                  //                         overflow: TextOverflow.ellipsis,
                  //                       ),
                  //                       const Padding(
                  //                         padding: EdgeInsets.only(bottom: 5.0, top: 5),
                  //                         child: const Text(
                  //                           '৳ ৪৫০',
                  //                           style: const TextStyle(
                  //                               color: Colors.black,
                  //                               fontFamily: "Sofia",
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w700),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   Column(
                  //                     children: [
                  //                       Text(
                  //                         'Sell Price'.tr,
                  //                         style: TextStyle(
                  //                             fontWeight: FontWeight.w300,
                  //                             fontFamily: "Sofia",
                  //                             color: AppColors.homeTextColor3,
                  //                             fontSize: 12),
                  //                         overflow: TextOverflow.ellipsis,
                  //                       ),
                  //                       const Padding(
                  //                         padding: EdgeInsets.only(bottom: 5.0, top: 5),
                  //                         child: const Text(
                  //                           '৳ ৫০০',
                  //                           style: TextStyle(
                  //                               color: Colors.black,
                  //                               fontFamily: "Sofia",
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w700),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(right: 20),
                  //         child: Image.asset(
                  //           "assets/icons/right_arrow.png",
                  //           width: 15,
                  //           height: 15,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 43, 42, 43).withOpacity(0.2),
                blurRadius: 2,
                offset: const Offset(0, -2)),
          ],
          //  border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.ADD_PRODUCT);
            },
            child: Container(
              width: _size.width,
              height: _size.width * .1,
              decoration: Ui.getBoxDecoration(
                  color: const Color(0xFF652981), radius: 10),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "+ " + 'Add New Item'.tr,
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
    );
  }

  Widget _buildStockInfo(String title, int stock) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontFamily: "Sofia",
            color: AppColors.homeTextColor3,
            fontSize: 12,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '$stock',
            style: TextStyle(
              color: AppColors.homeTextColor3,
              fontFamily: "Sofia",
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInfo(String title, double price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontFamily: "Sofia",
            color: AppColors.homeTextColor3,
            fontSize: 12,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '৳ $price',
            style: TextStyle(
              color: AppColors.homeTextColor3,
              fontFamily: "Sofia",
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
