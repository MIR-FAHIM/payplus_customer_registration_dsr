import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import '../controllers/add_balance_controller.dart';

class CollectionDetailsList extends GetView<AddbalanceController> {
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
          title: Text('Balance Report'.tr),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.addBalanceHistoryList.isNotEmpty) {
          return SingleChildScrollView(
            child: Column(
              children:
                  List.generate(controller.addBalanceHistoryList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Container(
                      height: _size.width * 0.22,
                      width: _size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      height:  60,
                                      width:  60,
                                      decoration:
                                      BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            5),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.addBalanceHistoryList[index].logoLink!,
                                        imageBuilder:
                                            (context,
                                            imageProvider) =>
                                            Container(
                                              decoration:
                                              BoxDecoration(
                                                image:
                                                DecorationImage(
                                                  image:
                                                  imageProvider,
                                                  fit: BoxFit
                                                      .fill,
                                                ),
                                              ),
                                            ),
                                        placeholder: (context,
                                            url) =>
                                        const Padding(
                                          padding:
                                          EdgeInsets
                                              .all(
                                              5.0),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/default_image.png'),
                                          ),
                                        ),
                                        errorWidget: (context,
                                            url,
                                            error) =>
                                        const Padding(
                                          padding:
                                          EdgeInsets
                                              .all(
                                              5.0),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/default_image.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Add Balance'.tr,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        controller.addBalanceHistoryList![index]
                                            .mobile == "" ?   Container() :  Text(
                                          controller.addBalanceHistoryList![index]
                                              .mobile!,
                                          style: TextStyle(
                                            fontSize: 8,
                                          ),
                                        ) ,
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          controller.addBalanceHistoryList[index]
                                              .trxId!,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat.yMMMd().format(controller
                                              .addBalanceHistoryList[index]
                                              .tranTime!) +
                                          ' ' +
                                          DateFormat.jm().format(controller
                                              .addBalanceHistoryList[index]
                                              .tranTime!),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '- ৳ ${controller.addBalanceHistoryList![index].amount!}',

                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF652981),
                                      ),
                                    ),
                                  ],
                                ),
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
          );
        } else {
          return Container(
            height: Get.size.width,
            child: Center(
              child: Ui.customLoader(),
            ),
          );
        }
      }),
    );
  }
}

class bodyItem extends StatelessWidget {
  const bodyItem({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size.width,
      decoration: Ui.getBoxDecoration(
        color: Colors.white,
        radius: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    'assets/images/Group.png',
                    height: 45,
                    width: 45,
                    color: const Color(0xFF652981),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'OTF',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'TK0.00',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
