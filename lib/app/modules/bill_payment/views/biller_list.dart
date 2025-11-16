import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/widgets/bill_drawer.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../../../services/location_service.dart';

class BillerList extends GetView {
  final _size = Get.size;
  var _id = Get.arguments['id'];
  var _title = Get.arguments['title'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          centerTitle: true,
          title: Text(_title),
          elevation: 0,
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         CupertinoIcons.bell,
          //         color: Colors.white70,
          //       )),
          // ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: getBillerList(_id),
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    final datas = snapshot.data as Map;
                    List billerList = datas['data'];

                    // print(billerList[1]['bill_code']);
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: List.generate(billerList.length, (index) {
                          var data = billerList[index];
                          return GestureDetector(
                            onTap: () {
                              print(
                                  "biller list ${billerList[index]['bill_code']}");
                              var data = {
                                "title": billerList[index]['name'],
                                "images": billerList[index]['image'],
                                "bill_no": '',
                              };
                              if (billerList[index]['bill_code'] ==
                                  'desco_postpaid') {
                                Get.toNamed(Routes.Desco_Postpaid_List_View,
                                    arguments: data);
                              } else if (billerList[index]['bill_code'] ==
                                  'desco_prepaid') {
                                Get.toNamed(Routes.Desco_Prepaid_From_View,
                                    arguments: data);
                              } else if (billerList[index]['bill_code'] ==
                                  'dpdc_postpaid') {
                                Get.toNamed(Routes.DPDC_Postpaid_From_View,
                                    arguments: data);
                              } else if (billerList[index]['bill_code'] ==
                                  'desco_prepaid') {
                                Get.toNamed(Routes.Desco_Prepaid_From_View,
                                    arguments: data);
                              } else if (billerList[index]['bill_code'] ==
                                  'west_zone_postpaid') {
                                Get.toNamed(Routes.Westzone_Postpaid_From_View,
                                    arguments: data);
                              } else if (billerList[index]['bill_code'] ==
                                  'palli_bidyut_postpaid') {
                                Get.toNamed(Routes.Reb_Postpaid_Form_View,
                                    arguments: data);
                              } else if (billerList[index]['bill_code'] ==
                                  'nesco_postpaid') {
                                Get.toNamed(Routes.nesco_From_View,
                                    arguments: data);
                              } else if (billerList[index]['bill_code'] ==
                                  'bpdb_prepaid') {
                                Get.toNamed(Routes.BPDBFORMVIEW, arguments: data);
                              }
                              // else if (billerList[index]['bill_code'] ==
                              //     'dhaka_wasa') {
                              //   Get.toNamed(Routes.Dhaka_Wasa_From_View,
                              //       arguments: data);
                              // }
                              //
                              // Get.toNamed(Routes.Desco_Postpaid_List_View);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10),
                              child: Container(
                                width: _size.width,
                                decoration: Ui.getBoxDecoration(
                                  color: Colors.white,
                                  radius: 5,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Image.network(
                                          data['image'],
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          data['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }),
          ],
        ),
      ),
    );
  }

  Future<Map<dynamic, dynamic>> getBillerList(int id) async {
    print("my type id in biller is $id");
    Map data = {'type_id': id.toString(), 'code': "6054"};

    String token = Get.find<AuthService>().currentUser.value.token!;



    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    var url = '${ApiClient.v3baseUrl}/billpay/app-biller-list';

    // var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);
    print('Bill List : $resp');
    return resp;
  }
}
