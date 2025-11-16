import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_form_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/Water/khulna_wasa_form_view.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/Water/rajshahi_wasa_form_view.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class FavouriteBillerView extends GetView<BillFormController> {
  BillFormController billpayController = Get.put(BillFormController());
  final _size = Get.size;
  @override
  Widget build(BuildContext context) {
    // getFavBill() async {
    //   // print(billNumber);

    //   // String token = Get.find<AuthService>().currentUser.value.token!;

    //   var headers = {'token': 'loqCAASkg4v9RnKAuQxZkZElJ5eTBYYZZyb19Awn'};

    //   // var headers = {'token': token};

    //   var url = 'https://shl.com.bd/api/appapi/billpay/get-favourite-biller';

    //   // var body = json.encode(data);

    //   var response = await http.post(Uri.parse(url), headers: headers);
    //   var resp = json.decode(response.body);
    //   var datas = resp['data'];

    //   print('Bill Charge : $resp');
    //   // favBillerLoaded.value = true;
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF652981),
        title: Text('Favourite Biller'.tr),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.offAllNamed(Routes.BILL_PAYMENT),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [


              Obx(() {
                if (billpayController.favBillerLoaded.isTrue) {
                  if (billpayController.favBillList.value.result == 'success') {
                    return Column(
                      children: List.generate(
                          billpayController.favBillList.value.data!.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                var data = {
                                  "title": billpayController
                                      .favBillList.value.data![index].name
                                      .toString(),
                                  "images": billpayController
                                      .favBillList.value.data![index].image
                                      .toString(),
                                  "bill_no": billpayController.favBillList.value
                                      .data![index].saved_bill_no
                                      .toString(),
                                  // "nick_name": billpayController.favBillList.value
                                  //     .data![index].saved_nick_name
                                  //     .toString(),
                                };

                                if (billpayController.favBillList.value
                                        .data![index].bill_code
                                        .toString() ==
                                    'desco_postpaid') {
                                  Get.toNamed(Routes.Desco_Postpaid_List_View,
                                      arguments: data);
                                } else if (billpayController.favBillList.value
                                        .data![index].bill_code
                                        .toString() ==
                                    'dpdc_postpaid') {
                                  Get.toNamed(Routes.DPDC_Postpaid_From_View,
                                      arguments: data);
                                }  else if (billpayController.favBillList.value
                                    .data![index].bill_code
                                    .toString() ==
                                    'bpdb_prepaid') {

                                  billpayController.meterNo.value = billpayController.favBillList.value
                                      .data![index].saved_bill_no;
                                  print("saved bill is ${billpayController.meterNo.value}");
                                  Get.toNamed(Routes.BPDBFORMVIEW,
                                      arguments: data);
                                } else if (billpayController.favBillList.value
                                        .data![index].bill_code
                                        .toString() ==
                                    'west_zone_postpaid') {
                                  Get.toNamed(
                                      Routes.Westzone_Postpaid_From_View,
                                      arguments: data);
                                } else if (billpayController.favBillList.value
                                        .data![index].bill_code
                                        .toString() ==
                                    'dhaka_wasa') {
                                  Get.toNamed(Routes.Dhaka_Wasa_From_View,
                                      arguments: data);
                                } else if (billpayController.favBillList.value
                                        .data![index].bill_code
                                        .toString() ==
                                    'khulna_wasa') {
                                  Get.to(KhulnaWasaFormView(), arguments: data);
                                } else if (billpayController.favBillList.value
                                        .data![index].bill_code
                                        .toString() ==
                                    'rajshahi_wasa') {
                                  Get.to(RajshahiWasaFormView(),
                                      arguments: data);
                                }
                              },
                              child: Container(
                                height: _size.width * 0.22,
                                width: _size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.network(
                                                    billpayController
                                                        .favBillList
                                                        .value
                                                        .data![index]
                                                        .image,
                                                    height: 45,
                                                    width: 45,
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
                                                    billpayController
                                                                .favBillList
                                                                .value
                                                                .data![index]
                                                                .name ==
                                                            null
                                                        ? ''
                                                        : billpayController
                                                            .favBillList
                                                            .value
                                                            .data![index]
                                                            .name,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    "Acc No : " +
                                                                billpayController
                                                                    .favBillList
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    .saved_bill_no
                                                                    .toString() ==
                                                            null
                                                        ? ''
                                                        : billpayController
                                                            .favBillList
                                                            .value
                                                            .data![index]
                                                            .saved_bill_no
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Ref : " +
                                                        billpayController
                                                            .favBillList
                                                            .value
                                                            .data![index]
                                                            .saved_nick_name,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: () {
                                              billpayController.bill_id.value =
                                                  billpayController
                                                      .favBillList
                                                      .value
                                                      .data![index]
                                                      .saved_bill_id
                                                      .toString();

                                              billpayController.DeleteBiller();
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: AppColors.homeTextColor3,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return Container(
                        height: Get.size.height,
                        width: Get.size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.size.height * 0.2),
                            new Image.asset(
                              'assets/images/bill_pay.png',
                              width: 100.0,
                              height: 100.0,
                              color: AppColors.homeTextColor3,
                            ),
                            SizedBox(height: Get.size.height * 0.05),
                            Text(
                              'Your favorites list is empty'.tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.homeTextColor3),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.offAndToNamed(Routes.ROOT);
                                },
                                child: Text(
                                  'Back To Home'.tr,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF652981),
                                  ),
                                )),
                          ],
                        ));
                  }
                } else {
                  return Container(
                    height: Get.size.width,
                    child: Center(
                      child: Ui.customLoader(),
                    ),
                  );
                }
              }),
            ],
          )),
    );
  }

  // Container Logo(int index) {
  //   var gp = "assets/sim/gp.png";
  //   var airtel = "assets/sim/art.png";
  //   var banglalink = "assets/sim/bl.png";
  //   var robi = "assets/sim/robi.png";
  //   var teletalk = "assets/sim/teletalk.png";

  //   var operator = controller.rechargeReport.value.data![index].operator!;

  //   dynamic Operator() {
  //     if (operator == "Grameen phone") {
  //       return gp;
  //     } else if (operator == "Airtel") {
  //       return airtel;
  //     } else if (operator == "Banglalink") {
  //       return banglalink;
  //     } else if (operator == "Robi") {
  //       return robi;
  //     } else if (operator == "Teletalk") {
  //       return teletalk;
  //     } else
  //       return gp;
  //   }

  //   var _operatorImage = Operator();

  // return
  // Container(
  //   decoration: BoxDecoration(
  //     color: Colors.grey.shade100,
  //     borderRadius: BorderRadius.circular(50),
  //   ),
  //   child: Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Image.asset(
  //       _operatorImage,
  //       height: 25,
  //       width: 25,
  //     ),
  //   ),
  // );
  // }
}
