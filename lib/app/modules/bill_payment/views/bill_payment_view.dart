import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/akash/akash_form.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/favourite_biller_view.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/widgets/bill_drawer.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/widgets/bill_payment_options_widget.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/widgets/billpay_card_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/bill_payment_controller.dart';

class BillPaymentView extends GetView<BillPaymentController> {
  // Future<void> Createpdf() async {
  //   final pdf = pw.Document();

  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) => pw.Center(
  //         child: pw.Text('Hello World!'),
  //       ),
  //     ),
  //   );
  //   final output = await getTemporaryDirectory();
  //   final file = File("${output.path}/example.pdf");
  //   // final file = File('example.pdf');
  //   await file.writeAsBytes(await pdf.save());
  // }

  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: BillDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size(65, 65),
        child: AppBar(
          backgroundColor: const Color(0xFF652981),
          centerTitle: true,
          title: Text('Bill Payment'.tr),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.offAllNamed(Routes.ROOT),
          ),
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
      body: WillPopScope(
        onWillPop: () {
          Get.offAllNamed(Routes.ROOT);
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: _size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.offAll(FavouriteBillerView());
                        },
                        child: Container(
                          height: _size.width * .2,
                          width: _size.width * .45,
                          decoration: Ui.getBoxDecoration(
                              color: Colors.white, radius: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/bill/Account-Save.png',
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      'Favourite Biller'.tr,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Container(
                      //     height: _size.width * .2,
                      //     width: _size.width * .4,
                      //     decoration: Ui.getBoxDecoration(
                      //         color: Colors.white, radius: 10),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Row(
                      //         children: [
                      //           Image.asset(
                      //             'assets/bill/Rosid.png',
                      //             height: 30,
                      //             width: 30,
                      //           ),
                      //           const SizedBox(
                      //             width: 10,
                      //           ),
                      //           Center(
                      //             child: Text(
                      //               'Receipt'.tr,
                      //               style: const TextStyle(color: Colors.black),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: _size.width,
                  decoration:
                      Ui.getBoxDecoration(color: Colors.white, radius: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Select Company Type'.tr,
                      style: TextStyle(color: Get.theme.hintColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              BillPaymentOptionWidget(),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
