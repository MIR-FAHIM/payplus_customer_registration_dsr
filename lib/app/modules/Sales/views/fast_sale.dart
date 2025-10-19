// import 'dart:html';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/Page/sale_payment_system.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/sales_controller.dart';

class FastSalesView extends GetView<SalesController> {
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
          title: Text('Fast Sale'.tr),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.bell,
                  color: Colors.white70,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  Get.to(SalePaymentSystem());
                },
                child: Container(
                  width: _size.width,
                  height: _size.width * .1,
                  decoration:
                      Ui.getBoxDecoration(color: const Color(0xFF652981), radius: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/shopping-cart.png",
                            width: 20,
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Sell'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10.0),

                    /// Image item
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/list.png')),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.1)
                            ]),
                        child: Container(
                          height: 65.0,
                          width: 65.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                                image: AssetImage('assets/images/list.png')),
                          ),
                        ))),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                    child: Column(
                      /// Text Information Item
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 180.0,
                          child: const Text(
                            'Samsung Mobile',
                            style: TextStyle(
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
                        const Text(
                          'Stock 10 pcs',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: "Sofia",
                              color: Colors.black,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 0.0),
                              child: Container(
                                width: 140.0,
                                decoration: const BoxDecoration(color: Colors.white),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    /// Decrease of value item
                                    InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   value =
                                        //       value - 1;
                                        //   value =
                                        //       (value > 0
                                        //           ? value
                                        //           : 0);
                                        //   pay = items[position]
                                        //           .price *
                                        //       value;
                                        //   total = pay +
                                        //       delivery;
                                        // });
                                      },
                                      child: Container(
                                        height: 20.0,
                                        width: 20.0,
                                        decoration: BoxDecoration(
                                            color: Colors.black12.withOpacity(0.1),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: const Center(
                                            child: Text(
                                          "-",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18.0),
                                        )),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                                      child: Text(
                                        "2",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "Sofia",
                                            fontSize: 14.0),
                                      ),
                                    ),

                                    /// Increasing value of item
                                    InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   value =
                                        //       value + 1;
                                        //   pay = items[position]
                                        //           .price *
                                        //       value *
                                        //       2;
                                        //   total = pay +
                                        //       delivery;
                                        // });
                                      },
                                      child: Container(
                                        height: 20.0,
                                        width: 20.0,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFF652981),
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(5.0))),
                                        child: const Center(
                                            child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18.0),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 5.0, right: 15),
                              child: Text(
                                "\$" + '20',
                                style: TextStyle(
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10.0),

                    /// Image item
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/hand.png')),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.1)
                            ]),
                        child: Container(
                          height: 65.0,
                          width: 65.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                                image: AssetImage('assets/images/hand.png')),
                          ),
                        ))),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                    child: Column(
                      /// Text Information Item
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 180.0,
                          child: const Text(
                            'Oppo Mobile',
                            style: TextStyle(
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
                        const Text(
                          'Stock 08 pcs',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: "Sofia",
                              color: Colors.black,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 0.0),
                              child: Container(
                                width: 140.0,
                                decoration: const BoxDecoration(color: Colors.white),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    /// Decrease of value item
                                    InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   value =
                                        //       value - 1;
                                        //   value =
                                        //       (value > 0
                                        //           ? value
                                        //           : 0);
                                        //   pay = items[position]
                                        //           .price *
                                        //       value;
                                        //   total = pay +
                                        //       delivery;
                                        // });
                                      },
                                      child: Container(
                                        height: 20.0,
                                        width: 20.0,
                                        decoration: BoxDecoration(
                                            color: Colors.black12.withOpacity(0.1),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: const Center(
                                            child: Text(
                                          "-",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18.0),
                                        )),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                                      child: Text(
                                        "1",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "Sofia",
                                            fontSize: 14.0),
                                      ),
                                    ),

                                    /// Increasing value of item
                                    InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   value =
                                        //       value + 1;
                                        //   pay = items[position]
                                        //           .price *
                                        //       value *
                                        //       2;
                                        //   total = pay +
                                        //       delivery;
                                        // });
                                      },
                                      child: Container(
                                        height: 20.0,
                                        width: 20.0,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFF652981),
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(5.0))),
                                        child: const Center(
                                            child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18.0),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 5.0, right: 15),
                              child: Text(
                                "\$" + '15',
                                style: TextStyle(
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
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: 0.1,
              color: Colors.black,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    "Total ",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Sofia",
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    " \$ " + "35",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Sofia",
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),

            //search
            Row(
              children: <Widget>[
                Container(
                  height: 40,
                  width: _size.width * 0.75,
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 1),
                  padding: const EdgeInsets.only(top: 18, left: 20),
                  // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(235, 235, 235, 1),
                    borderRadius: BorderRadius.circular(8.5),
                  ),
                  child: TextField(
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
                Center(
                  child: Container(
                      width: _size.width * 0.1,
                      height: 40.0,
                      margin: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage("assets/images/qr-code.png"),
                            fit: BoxFit.contain),
                        // borderRadius: BorderRadius.circular(8),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 0.5,
                        //     blurRadius: 0.5,
                        //     offset:
                        //         Offset(1, 1), // changes position of shadow
                        //   ),
                        // ]
                      )),
                ),
              ],
            ),

            //product
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10.0),

                    /// Image item
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/hand.png')),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.1)
                            ]),
                        child: Container(
                          height: 65.0,
                          width: 65.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                                image: AssetImage('assets/images/hand.png')),
                          ),
                        ))),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                    child: Column(
                      /// Text Information Item
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 180.0,
                          child: const Text(
                            'Oppo Mobile',
                            style: TextStyle(
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
                        const Text(
                          'Stock 08 pcs',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: "Sofia",
                              color: Colors.black,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(top: 10.0, left: 0.0),
                            //   child: Container(
                            //     width: 140.0,
                            //     decoration: BoxDecoration(color: Colors.white),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceAround,
                            //       children: <Widget>[
                            //         /// Decrease of value item
                            //         InkWell(
                            //           onTap: () {
                            //             // setState(() {
                            //             //   value =
                            //             //       value - 1;
                            //             //   value =
                            //             //       (value > 0
                            //             //           ? value
                            //             //           : 0);
                            //             //   pay = items[position]
                            //             //           .price *
                            //             //       value;
                            //             //   total = pay +
                            //             //       delivery;
                            //             // });
                            //           },
                            //           child: Container(
                            //             height: 20.0,
                            //             width: 20.0,
                            //             decoration: BoxDecoration(
                            //                 color:
                            //                     Colors.black12.withOpacity(0.1),
                            //                 borderRadius: BorderRadius.all(
                            //                     Radius.circular(5.0))),
                            //             child: Center(
                            //                 child: Text(
                            //               "-",
                            //               style: TextStyle(
                            //                   color: Colors.black,
                            //                   fontWeight: FontWeight.w800,
                            //                   fontSize: 18.0),
                            //             )),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 18.0),
                            //           child: Text(
                            //             "1",
                            //             style: TextStyle(
                            //                 color: Colors.black,
                            //                 fontWeight: FontWeight.w800,
                            //                 fontFamily: "Sofia",
                            //                 fontSize: 14.0),
                            //           ),
                            //         ),

                            //         /// Increasing value of item
                            //         InkWell(
                            //           onTap: () {
                            //             // setState(() {
                            //             //   value =
                            //             //       value + 1;
                            //             //   pay = items[position]
                            //             //           .price *
                            //             //       value *
                            //             //       2;
                            //             //   total = pay +
                            //             //       delivery;
                            //             // });
                            //           },
                            //           child: Container(
                            //             height: 20.0,
                            //             width: 20.0,
                            //             decoration: BoxDecoration(
                            //                 color: Color(0xFF652981),
                            //                 borderRadius: BorderRadius.all(
                            //                     Radius.circular(5.0))),
                            //             child: Center(
                            //                 child: Text(
                            //               "+",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontWeight: FontWeight.w800,
                            //                   fontSize: 18.0),
                            //             )),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5.0, right: 15, top: 10),
                              child: Text(
                                "\$" + '15',
                                style: TextStyle(
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
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Image.asset(
                    "assets/images/shopping-cart-round.png",
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10.0),

                    /// Image item
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/shop.png')),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.1)
                            ]),
                        child: Container(
                          height: 65.0,
                          width: 65.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                                image: AssetImage('assets/images/shop.png')),
                          ),
                        ))),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                    child: Column(
                      /// Text Information Item
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 180.0,
                          child: const Text(
                            'Vivo Mobile',
                            style: TextStyle(
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
                        const Text(
                          'Stock 10 pcs',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: "Sofia",
                              color: Colors.black,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(top: 10.0, left: 0.0),
                            //   child: Container(
                            //     width: 140.0,
                            //     decoration: BoxDecoration(color: Colors.white),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceAround,
                            //       children: <Widget>[
                            //         /// Decrease of value item
                            //         InkWell(
                            //           onTap: () {
                            //             // setState(() {
                            //             //   value =
                            //             //       value - 1;
                            //             //   value =
                            //             //       (value > 0
                            //             //           ? value
                            //             //           : 0);
                            //             //   pay = items[position]
                            //             //           .price *
                            //             //       value;
                            //             //   total = pay +
                            //             //       delivery;
                            //             // });
                            //           },
                            //           child: Container(
                            //             height: 20.0,
                            //             width: 20.0,
                            //             decoration: BoxDecoration(
                            //                 color:
                            //                     Colors.black12.withOpacity(0.1),
                            //                 borderRadius: BorderRadius.all(
                            //                     Radius.circular(5.0))),
                            //             child: Center(
                            //                 child: Text(
                            //               "-",
                            //               style: TextStyle(
                            //                   color: Colors.black,
                            //                   fontWeight: FontWeight.w800,
                            //                   fontSize: 18.0),
                            //             )),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 18.0),
                            //           child: Text(
                            //             "2",
                            //             style: TextStyle(
                            //                 color: Colors.black,
                            //                 fontWeight: FontWeight.w800,
                            //                 fontFamily: "Sofia",
                            //                 fontSize: 14.0),
                            //           ),
                            //         ),

                            //         /// Increasing value of item
                            //         InkWell(
                            //           onTap: () {
                            //             // setState(() {
                            //             //   value =
                            //             //       value + 1;
                            //             //   pay = items[position]
                            //             //           .price *
                            //             //       value *
                            //             //       2;
                            //             //   total = pay +
                            //             //       delivery;
                            //             // });
                            //           },
                            //           child: Container(
                            //             height: 20.0,
                            //             width: 20.0,
                            //             decoration: BoxDecoration(
                            //                 color: Color(0xFF652981),
                            //                 borderRadius: BorderRadius.all(
                            //                     Radius.circular(5.0))),
                            //             child: Center(
                            //                 child: Text(
                            //               "+",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontWeight: FontWeight.w800,
                            //                   fontSize: 18.0),
                            //             )),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),

                            Padding(
                              padding: EdgeInsets.only(bottom: 5.0, right: 15, top: 10),
                              child: Text(
                                "\$" + '20',
                                style: TextStyle(
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
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Image.asset(
                    "assets/images/shopping-cart-round.png",
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10.0),

                    /// Image item
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/phone.png')),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.1)
                            ]),
                        child: Container(
                          height: 65.0,
                          width: 65.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                                image: AssetImage('assets/images/phone.png')),
                          ),
                        ))),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                    child: Column(
                      /// Text Information Item
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 180.0,
                          child: const Text(
                            ' Mobile',
                            style: TextStyle(
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
                        const Text(
                          'Stock 10 pcs',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: "Sofia",
                              color: Colors.black,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(top: 10.0, left: 0.0),
                            //   child: Container(
                            //     width: 140.0,
                            //     decoration: BoxDecoration(color: Colors.white),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceAround,
                            //       children: <Widget>[
                            //         /// Decrease of value item
                            //         InkWell(
                            //           onTap: () {
                            //             // setState(() {
                            //             //   value =
                            //             //       value - 1;
                            //             //   value =
                            //             //       (value > 0
                            //             //           ? value
                            //             //           : 0);
                            //             //   pay = items[position]
                            //             //           .price *
                            //             //       value;
                            //             //   total = pay +
                            //             //       delivery;
                            //             // });
                            //           },
                            //           child: Container(
                            //             height: 20.0,
                            //             width: 20.0,
                            //             decoration: BoxDecoration(
                            //                 color:
                            //                     Colors.black12.withOpacity(0.1),
                            //                 borderRadius: BorderRadius.all(
                            //                     Radius.circular(5.0))),
                            //             child: Center(
                            //                 child: Text(
                            //               "-",
                            //               style: TextStyle(
                            //                   color: Colors.black,
                            //                   fontWeight: FontWeight.w800,
                            //                   fontSize: 18.0),
                            //             )),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 18.0),
                            //           child: Text(
                            //             "2",
                            //             style: TextStyle(
                            //                 color: Colors.black,
                            //                 fontWeight: FontWeight.w800,
                            //                 fontFamily: "Sofia",
                            //                 fontSize: 14.0),
                            //           ),
                            //         ),

                            //         /// Increasing value of item
                            //         InkWell(
                            //           onTap: () {
                            //             // setState(() {
                            //             //   value =
                            //             //       value + 1;
                            //             //   pay = items[position]
                            //             //           .price *
                            //             //       value *
                            //             //       2;
                            //             //   total = pay +
                            //             //       delivery;
                            //             // });
                            //           },
                            //           child: Container(
                            //             height: 20.0,
                            //             width: 20.0,
                            //             decoration: BoxDecoration(
                            //                 color: Color(0xFF652981),
                            //                 borderRadius: BorderRadius.all(
                            //                     Radius.circular(5.0))),
                            //             child: Center(
                            //                 child: Text(
                            //               "+",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontWeight: FontWeight.w800,
                            //                   fontSize: 18.0),
                            //             )),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),

                            Padding(
                              padding: EdgeInsets.only(bottom: 5.0, right: 15, top: 10),
                              child: Text(
                                "\$" + '20',
                                style: TextStyle(
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
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Image.asset(
                    "assets/images/shopping-cart-round.png",
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
