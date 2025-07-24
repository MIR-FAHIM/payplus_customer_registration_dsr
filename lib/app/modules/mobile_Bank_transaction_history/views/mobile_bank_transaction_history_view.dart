import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/custom_data.dart';
import 'package:latest_payplus_agent/common/helper.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../controllers/mobile_bank_transaction_history_controller.dart';

class MobileBankTransactionHistoryView
    extends GetView<MobileBankTransactionHistoryController> {
  const MobileBankTransactionHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String searchType = Get.arguments[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,
        elevation: 0,
        title: Text('Transaction History'.tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.historyLoaded.isTrue) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    child: TextField(
                      onChanged: (e) {
                        controller.setSearchText(e);
                        // controller.contactsResult.value =
                        //     _search(controller.contacts.value);
                      },
                      controller: controller.searchController.value,
                      decoration: InputDecoration(
                          labelText: "Search by number",
                          hintText: "Search by number",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                ),
                searchType == "all"
                    ? Column(
                        children: List.generate(
                            controller.filteredHistory!.length, (index) {
                          var data = controller.filteredHistory![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: size.width * .27,
                                width: size.width,
                                color: (data.trxStatus == "FAILED" || data.trxStatus == "PROCESSING")
                                    ? Colors.redAccent.withOpacity(.1)
                                    : AppColors.primaryColor.withOpacity(.1),
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildMfsInfo(data),
                                    const SizedBox(width: 10),
                                    buildTransactionDetails(data),
                                    buildAmountAndTime(data),
                                  ],
                                ),
                              ),
                            )

                          );
                        }),
                      )
                    : Column(
                        children: List.generate(
                            controller.filteredHistory!
                                .where((e) => e.typeName == searchType)
                                .toList()
                                .length, (index) {
                          var data = controller.filteredHistory!
                              .where((e) => e.typeName == searchType)
                              .toList()[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: size.width * .27,
                                width: size.width,
                                color: (data.trxStatus == "FAILED" || data.trxStatus == "PROCESSING")
                                    ? Colors.redAccent.withOpacity(.1)
                                    : AppColors.primaryColor.withOpacity(.1),
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildMfsInfo(data),
                                    const SizedBox(width: 10),
                                    buildTransactionDetails(data),
                                    buildAmountAndTime(data),
                                  ],
                                ),
                              ),
                            )
                          );
                        }),
                      ),
              ],
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

  Widget buildTransactionDetails(data) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.typeName == "Money Transfer" ? "Withdraw" : data.typeName ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Text(
            data.number ?? '',
            style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 5),
          if (data.trxStatus == "FAILED" || data.trxStatus == "PROCESSING")
            Row(
              children: [
                Image.asset(
                  "assets/icons/cancel.png",
                  height: Get.height * .02,
                  width: Get.width * .06,
                ),
                const SizedBox(width: 5),
                const Text(
                  'Failed',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ],
            )
          else
            Text(
              'Trans ID: ${data.trxId}',
              style: const TextStyle(fontSize: 10),
            ),
        ],
      ),
    );


  }

  Widget buildAmountAndTime(data) {
    final isFailedOrProcessing = data.trxStatus == "FAILED" || data.trxStatus == "PROCESSING";
    final amountPrefix = data.typeName?.toLowerCase() == 'cashout' ? '- ৳' : '+৳';
    final dateTime = DateTime.parse(data.trxTime ?? '');

    return SizedBox(
      width: Get.width * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            isFailedOrProcessing
                ? '$amountPrefix ${data.amount}'
                : '-৳ ${data.amount}',
            style: TextStyle(
              fontSize: 18,
              color: isFailedOrProcessing ? Colors.green : Colors.red,
            ),
          ),
          Text(
            'Cashback: $uniCodeTk ${data.commission}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            '${DateFormat.yMMMd().format(dateTime)}, ${DateFormat.jm().format(dateTime)}',
            style: const TextStyle(fontSize: 12),
          ),

          data.remark == '' ? Container():
          Text(
            'Remark: ${data.remark}',
            style: const TextStyle(fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  Widget buildMfsInfo(data) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: CachedNetworkImageProvider(data.logo ?? ''),
          onBackgroundImageError: (_, __) => const AssetImage('assets/images/default_image.png'),
        ),
        const SizedBox(height: 5),
        Text(
          data.mfsName ?? '',
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }

}
