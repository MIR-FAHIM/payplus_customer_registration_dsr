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

  Color _statusColor(String status) {
    final s = status.toLowerCase();
    if (s == 'paid') return Colors.green;
    if (s == 'unpaid') return Colors.red;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    final purple = Color(0xFF652981);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: Text('Bill History'.tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.billReportLoaded.isFalse) {
          return Center(child: Ui.customLoader());
        }

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: controller.billReport.value.length,
          itemBuilder: (context, index) {
            final data = controller.billReport.value[index];
            final created = DateTime.parse(data.createdAt!);

            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.BILL_DETAILS,
                  arguments: data.id.toString(),
                );
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // Top section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              data.logo_url!,
                              height: 42,
                              width: 42,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Icon(Icons.image),
                            ),
                          ),
                          SizedBox(width: 10),

                          // Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.billerType!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  data.billName!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Bill No: ${data.billNo!}',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: purple,
                                      fontWeight: FontWeight.w500),
                                ),
                                if (data.token != "No Token") ...[
                                  SizedBox(height: 4),
                                  Text(
                                    'Token: ${data.token!}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: purple,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // Amount + Date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                DateFormat.yMMMd().format(created),
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                DateFormat.jm().format(created),
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '$uniCodeTk ${data.billTotalAmount!}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: _statusColor(data.paymentStatus!)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  data.paymentStatus!,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: _statusColor(data.paymentStatus!),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 14),
                      Divider(height: 1),
                      SizedBox(height: 10),

                      // Print / Share / Download button
                      InkWell(
                        onTap: () {
                          Get.to(PdfPreviewPage(
                            title: data.billName,
                            images: '',
                            token: data.token,
                            bllr_accno: data.billerAccNo,
                            bll_no: data.billNo,
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
                          height: 44,
                          decoration: Ui.getBoxDecoration(
                              color: AppColors.primarydeepLightColor,
                              radius: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.print,
                                  size: 16, color: AppColors.primaryColor),
                              SizedBox(width: 6),
                              Text(
                                "Print / Share / Save",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.download,
                                  size: 16, color: AppColors.primaryColor),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
