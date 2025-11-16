import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_form_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_payment_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/widgets/billpay_card_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';

class BillPaymentOptionWidget extends GetWidget<BillPaymentController> {
  // BillFormController billpayController = Get.put(BillFormController());
  final _size = Get.size;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: _size.width * .28,
      width: _size.width,
      color: Colors.white,
      child: FutureBuilder(
          future: controller.postRequest(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              final datas = snapshot.data as Map;

              var billType = datas['data'];
              // print(billType[0]['image']);
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    // crossAxisCount: 2,
                    maxCrossAxisExtent: 160,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: billType.length,
                  // itemCount: 3,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      // onTap: billPayment[index].press,
                      onTap: () {
                        if (billType[index]['id'] == 1) {
                          var data = {
                            "id": billType[index]['id'],
                            "title": billType[index]['type_name_bn'],
                          };
                          Get.toNamed(Routes.Biller_List_View, arguments: data);
                        } else if (billType[index]['id'] == 2) {
                          var data = {
                            "id": billType[index]['id'],
                            "title": billType[index]['type_name_bn'],
                          };
                          Get.toNamed(Routes.Gas_Biller_List_View, arguments: data);
                          // Get.to(WaterBillerList(), arguments: data);
                        } else if (billType[index]['id'] == 3) {
                          var data = {
                            "id": billType[index]['id'],
                            "title": billType[index]['type_name_bn'],
                          };
                          Get.toNamed(Routes.Water_Biller_List_View, arguments: data);
                          // Get.to(WaterBillerList(), arguments: data);
                        }
                      },
                      child: AnimationConfiguration.staggeredGrid(
                        position: 1,
                        duration: const Duration(milliseconds: 475),
                        columnCount: 3,
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: BillpayCardWidget(
                              width: 35,
                              aspectRetio: 1.2,
                              image: billType[index]['image'],
                              // allpadding: 0.0,
                              // name: billPayment[index].title!.tr,
                              // image: billPayment[index].image,
                              allpadding: 0.0,
                              name: billType[index]['type_name_bn'],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
//1002036521355
  Future<Map<dynamic, dynamic>> postRequest() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    var url = '${ApiClient.v3baseUrl}/billpay/bill-type';

    // var url =
    //     'http://103.219.160.235:8989/paystation/public/api/appapi/billpay/bill-type';

    var response = await http.post(Uri.parse(url), headers: headers);
    print(response);
    var resp = json.decode(response.body);
    // print('Bill type : $resp');
    return resp;
  }
}
