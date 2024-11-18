import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/pdfexport/pdfpreview.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/billpay_report_controller.dart';

class BillpayReportView extends GetView<BillpayReportController> {
  const BillpayReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF652981),
        title: Text('Bill History'.tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.billReportLoaded.isTrue) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: List.generate(controller.billReport.value.data!.length,
                  (index) {
                var data = controller.billReport.value.data![index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.BILL_DETAILS,
                        arguments: controller.billReport.value.data![index].id
                            .toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: SizedBox(
                        height: size.width * .4,
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        controller.billReport.value.data![index]
                                            .logo_url!,
                                        height: 40,
                                        width: 40,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: Get.width * .37,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.billReport.value
                                                  .data![index].billerType!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              controller.billReport.value
                                                  .data![index].billName!,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Bill No: ${controller.billReport.value.data![index].billNo!}',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            controller.billReport.value
                                                        .data![index].token ==
                                                    "No Token"
                                                ? Container()
                                                : Text(
                                                    'Token: ${controller.billReport.value.data![index].token!}',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: AppColors
                                                            .primaryColor),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width * .35,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          DateFormat.yMMMd().format(
                                                  DateTime.parse(controller
                                                      .billReport
                                                      .value
                                                      .data![index]
                                                      .createdAt!)) +
                                              ' ' +
                                              DateFormat.jm().format(
                                                  DateTime.parse(controller
                                                      .billReport
                                                      .value
                                                      .data![index]
                                                      .createdAt!)),
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          uniCodeTk +
                                              ' ' +
                                              controller
                                                  .billReport
                                                  .value
                                                  .data![index]
                                                  .billTotalAmount!,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          controller.billReport.value
                                              .data![index].paymentStatus!,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: controller
                                                        .billReport
                                                        .value
                                                        .data![index]
                                                        .paymentStatus!
                                                        .toLowerCase() ==
                                                    'unpaid'
                                                ? Colors.red
                                                : controller
                                                            .billReport
                                                            .value
                                                            .data![index]
                                                            .paymentStatus!
                                                            .toLowerCase() ==
                                                        'paid'
                                                    ? Colors.green
                                                    : Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Get.to(PdfPreviewPage(
                                        title: data.billName,
                                        images: '',
                                        token: data.token,
                                        bllr_accno: data.billerAccNo,
                                        bll_no: data.billName,
                                        bll_mobno: data.billerMobile,
                                        bll_dt_frm: data.billFrom,
                                        bll_dt_to: data.billGenDate,
                                        bll_dt_due: data.billDueDate,
                                        charge: data.charge,
                                        transaction_id: data.transactionId,
                                        bll_amnt_ttl: data.billTotalAmount,
                                        payment_date: data.paymentDate,
                                      ));
                                    },
                                    child: Container(
                                      width: size.width * .5,
                                      height: size.width * .08,
                                      decoration: Ui.getBoxDecoration(
                                          color:
                                              AppColors.primarydeepLightColor,
                                          radius: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.print,
                                                size: 15,
                                                color: AppColors
                                                    .primaryColor, //The color which you want set.
                                              ),
                                              // Image.asset(
                                              //   "assets/sales/sale_from_list.png",
                                              //   width: 20,
                                              //   height: 20,
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  'Print/Share/Save',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Icon(
                                                Icons.download,
                                                size: 15,
                                                color: AppColors
                                                    .primaryColor, //The color which you want set.
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        } else {
          return SizedBox(
            height: Get.size.height,
            child: Center(
              child: Ui.customLoader(),
            ),
          );
        }
      }),
    );
  }
}
