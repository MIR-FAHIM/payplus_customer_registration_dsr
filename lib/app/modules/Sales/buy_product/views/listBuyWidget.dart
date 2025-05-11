import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/buysell/product_model.dart';
import 'package:latest_payplus_agent/app/modules/Sales/buy_product/controllers/buy_product_controller.dart';
import 'package:latest_payplus_agent/app/modules/Sales/buy_product/views/buy_payment_view.dart';

import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ListBuyWidget extends GetWidget<BuyProductController> {
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.productLoaded.isTrue
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Column(
                    children:
                        List.generate(controller.cartList.length, (index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),

                            /// Image item
                            child: CachedNetworkImage(
                              height: 60,
                              width: 60,
                              imageUrl: controller.cartList[index].image ?? '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image(
                                  image: AssetImage('assets/Logo.png'),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image(
                                  image: AssetImage('assets/Logo.png'),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, left: 5.0, right: 5.0),
                              child: Column(
                                /// Text Information Item
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 180.0,
                                        child: Text(
                                          controller.cartList[index].name!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Sans",
                                              color: Colors.black87,
                                              fontSize: 14.0),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            controller.cartList.removeWhere(
                                                (element) =>
                                                    element.id ==
                                                    controller
                                                        .cartList[index].id);
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 25,
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Stock ${controller.cartList[index].stockAlert} pcs',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Sofia",
                                        color: Colors.black,
                                        fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 0.0),
                                        child: Container(
                                          width: 140.0,
                                          decoration: const BoxDecoration(
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              /// Decrease of value item
                                              InkWell(
                                                onTap: () {
                                                  if (controller.cartList[index]
                                                          .quantity! >
                                                      1) {
                                                    controller.cartList[index]
                                                        .quantity = controller
                                                            .cartList[index]
                                                            .quantity! -
                                                        1;
                                                    controller.cartList
                                                        .refresh();
                                                  }
                                                },
                                                child: Container(
                                                  height: 20.0,
                                                  width: 20.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black12
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  5.0))),
                                                  child: const Center(
                                                      child: Text(
                                                    "-",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 18.0),
                                                  )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18.0),
                                                child: Text(
                                                  "${controller.cartList[index].quantity}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontFamily: "Sofia",
                                                      fontSize: 14.0),
                                                ),
                                              ),

                                              /// Increasing value of item
                                              InkWell(
                                                onTap: () {
                                                  if (controller.cartList[index]
                                                          .quantity! <
                                                      controller.cartList[index]
                                                          .stockAlert!) {
                                                    controller.cartList[index]
                                                        .quantity = controller
                                                            .cartList[index]
                                                            .quantity! +
                                                        1;
                                                    controller.cartList
                                                        .refresh();
                                                  }
                                                },
                                                child: Container(
                                                  height: 20.0,
                                                  width: 20.0,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color(0xFF652981),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0))),
                                                  child: const Center(
                                                      child: Text(
                                                    "+",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 18.0),
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 5.0, right: 15),
                                        child: Text(
                                          "$uniCodeTk"
                                          ' ${controller.cartList[index].sellingPrice! * controller.cartList[index].quantity!}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Sofia",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        if (controller.cartList.isNotEmpty) {
                          Get.to(BuyPaymentView());
                        }
                      },
                      child: Container(
                        width: _size.width,
                        height: _size.width * .12,
                        decoration: Ui.getBoxDecoration(
                            color: const Color(0xFF652981), radius: 10),
                        child: Stack(
                          children: [
                            Container(
                              width: Get.size.width,
                              height: 45,
                              decoration: Ui.getBoxDecoration(
                                  color: const Color(0xFF652981), radius: 10),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'মোট ৳ ${controller.calculateTotalPrice()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: AppColors.homeCardBg,
                                    ),
                                  ),
                                )),
                            Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.homeCardBg,
                                      size: 20,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //search
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: _size.width * 0.8,
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
                      // Center(
                      //   child: Container(
                      //       width: _size.width * 0.1,
                      //       height: 40.0,
                      //       margin: EdgeInsets.fromLTRB(12, 10, 10, 10),
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,

                      //       )
                      //       child:    Image.asset(
                      //       "assets/icons/avatar.png",
                      //       width: 30,
                      //       height: 30,
                      //     ),,),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, top: 10, bottom: 10, right: 10),
                        child: Image.asset(
                          "assets/search.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ],
                  ),

                  //product
                  Column(
                    children:
                        List.generate(controller.productItems.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          ProductData product = controller.productItems[index];
                          product.quantity = 1;
                          controller.cartList.removeWhere(
                              (element) => element.id == product.id);
                          controller.cartList.add(product);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                height: 65,
                                width: 65,
                                imageUrl:
                                    controller.productItems[index].image ?? '',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Image(
                                    image: AssetImage('assets/Logo.png'),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Image(
                                    image: AssetImage('assets/Logo.png'),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 5.0, right: 5.0),
                                child: Column(
                                  /// Text Information Item
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 180.0,
                                      child: Text(
                                        controller.productItems[index].name!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Sans",
                                            color: Colors.black87,
                                            fontSize: 14.0),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      'Stock ${controller.productItems[index].stockAlert} pcs',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontFamily: "Sofia",
                                          color: Colors.black,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0, right: 15, top: 10),
                                          child: Text(
                                            uniCodeTk +
                                                ' ${controller.productItems[index].sellingPrice}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Sofia",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, right: 20),
                              child: Image.asset(
                                "assets/images/shopping-cart-round.png",
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            )
          : Center(child: Ui.customLoader());
    });
  }
}
