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
                                color: data.trxStatus == "FAILED" ||
                                        data.trxStatus == "PROCESSING"
                                    ? Colors.redAccent.withOpacity(.1)
                                    : AppColors.primaryColor.withOpacity(.1),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: CachedNetworkImage(
                                                      imageUrl: data.logo!,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder:
                                                          (context, url) =>
                                                              const Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child: Image(
                                                          image: AssetImage(
                                                              'assets/images/default_image.png'),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child: Image(
                                                          image: AssetImage(
                                                              'assets/images/default_image.png'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  data.mfsName!,
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: data.typeName ==
                                                            "Money Transfer"
                                                        ? Text(
                                                            "Withdraw",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          )
                                                        : Text(
                                                            data.typeName!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      data.number!,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  data.trxStatus == "FAILED" ||
                                                          data.trxStatus ==
                                                              "PROCESSING"
                                                      ? Row(
                                                          children: [
                                                            SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        .02,
                                                                width:
                                                                    Get.width *
                                                                        .06,
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      "assets/icons/cancel.png"),
                                                                )),
                                                            Text(
                                                              'Failed',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Expanded(
                                                          child: Text(
                                                            'Trans ID:' +
                                                                data.trxId!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            data.trxStatus == "FAILED" ||
                                                    data.trxStatus ==
                                                        "PROCESSING"
                                                ? Text(
                                                    data.typeName!
                                                                .toLowerCase() ==
                                                            'cashout'
                                                        ? '- ৳ ${data.amount}'
                                                        : '+৳ ${data.amount}',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.green),
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '-৳ ',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.red),
                                                      ),
                                                      Text(
                                                        '${data.amount}',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ],
                                                  ),
                                            Text(
                                              'Cashback: ' +
                                                  uniCodeTk +
                                                  ' ' +
                                                  data.commission!,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                //  controller.history.value.data![index].trxTime!,
                                                DateFormat.yMMMd().format(
                                                        DateTime.parse(
                                                            data.trxTime!)) +
                                                    ', ' +
                                                    DateFormat.jm().format(
                                                        DateTime.parse(
                                                            data.trxTime!)),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                                color: data.trxStatus == "FAILED" ||
                                        data.trxStatus == "PROCESSING"
                                    ? Colors.redAccent.withOpacity(.1)
                                    : AppColors.primaryColor.withOpacity(.1),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: CachedNetworkImage(
                                                      imageUrl: data.logo!,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder:
                                                          (context, url) =>
                                                              const Padding(
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        child: Image(
                                                          image: AssetImage(
                                                              'assets/images/default_image.png'),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Padding(
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        child: Image(
                                                          image: AssetImage(
                                                              'assets/images/default_image.png'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  data.mfsName!,
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: data.typeName ==
                                                            "Money Transfer"
                                                        ? Text(
                                                            "Withdraw",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          )
                                                        : Text(
                                                            data.typeName!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      data.number!,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  data.trxStatus == "FAILED" ||
                                                          data.trxStatus ==
                                                              "PROCESSING"
                                                      ? Row(
                                                          children: [
                                                            SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        .02,
                                                                width:
                                                                    Get.width *
                                                                        .06,
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      "assets/icons/cancel.png"),
                                                                )),
                                                            Text(
                                                              'Failed',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Expanded(
                                                          child: Text(
                                                            'Trans ID:' +
                                                                data.trxId!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            data.trxStatus == "FAILED" ||
                                                    data.trxStatus ==
                                                        "PROCESSING"
                                                ? Text(
                                                    data.typeName!
                                                                .toLowerCase() ==
                                                            'cashout'
                                                        ? '- ৳ ${data.amount}'
                                                        : '+৳ ${data.amount}',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.green),
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '-৳ ',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.red),
                                                      ),
                                                      Text(
                                                        '${data.amount}',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ],
                                                  ),
                                            Text(
                                              'Cashback: ' +
                                                  uniCodeTk +
                                                  ' ' +
                                                  data.commission!,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                //  controller.history.value.data![index].trxTime!,
                                                DateFormat.yMMMd().format(
                                                        DateTime.parse(
                                                            data.trxTime!)) +
                                                    ', ' +
                                                    DateFormat.jm().format(
                                                        DateTime.parse(
                                                            data.trxTime!)),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
}
