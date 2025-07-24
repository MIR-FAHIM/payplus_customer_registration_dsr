import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/account_statement/controllers/statement_controller.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class StatementWidget extends GetWidget<AccountStatementController> {
  final _size = Get.size;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.statementList.value.isNotEmpty) {
        return Container(
          height: Get.height * .7,
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: controller.statementList.value.length,
            itemBuilder: (context, index) {
              var data = controller.statementList.value[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.grey[50]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.transaction_name!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: Colors.green,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Amount: ${data.amount}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.blue,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Date: ${data.transaction_time}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.confirmation_number,
                              color: Colors.orange,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Transaction ID: ${data.trx_id}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return Container(
          height: Get.size.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 50,
              ),
              SizedBox(height: 20),
              Text(
                'No Transaction found for you'.tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.offAndToNamed(Routes.ROOT);
                },
                child: Text(
                  'Back To Home'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF652981),
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
