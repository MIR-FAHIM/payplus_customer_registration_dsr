import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/Gas/jalalabad_gas_bill_view.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class JalalabadGasFormView extends StatefulWidget {
  @override
  State<JalalabadGasFormView> createState() => _JalalabadGasFormViewState();
}

class _JalalabadGasFormViewState extends State<JalalabadGasFormView> {
  late List<DropdownMenuItem<BoxOption>> _boxItems;
  late BoxOption _selectedbox;

  @override
  void initState() {
    List<BoxOption> boxes = BoxOption.allBillerType;

    // Box Number Initialise your items only once
    _boxItems = boxes.map<DropdownMenuItem<BoxOption>>(
      (BoxOption billerOption) {
        return DropdownMenuItem<BoxOption>(
          value: billerOption,
          child: Text(billerOption.fullName),
        );
      },
    ).toList();
    _selectedbox = boxes[0];

    super.initState();
  }

  var acc_number = '';
  var ph_number = '';

  @override
  Widget build(BuildContext context) {
    var _title = Get.arguments['title'];
    var _images = Get.arguments['images'];

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size(65, 65),
          child: AppBar(
            backgroundColor: Color(0xFF652981),
            centerTitle: true,
            title: Text(_title),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.Notification_View);
                  },
                  icon: Icon(
                    CupertinoIcons.bell,
                    color: Colors.white70,
                  )),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF652981),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: 40,
                        width: 50,
                        image: NetworkImage(_images),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(_title),
                    ],
                  ),
                ),
              ),
              TextFieldWidget(
                labelText: "Account Number".tr,
                hintText: "Enter Account Number".tr,
                onChanged: (value) {
                  setState(() {
                    acc_number = value;
                  });
                },

                // onSaved: (input) =>
                // controller.currentUser.value.email = input,
                // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                iconData: null,
                imageData: 'assets/bill/account.png',
              ),
              TextFieldWidget(
                labelText: "Registered Mobile No".tr,
                hintText: "Enter Mobile No.".tr,
                onChanged: (value) {
                  setState(() {
                    ph_number = value;
                  });
                },
                keyboardType: TextInputType.number,
                // onSaved: (input) =>
                // controller.currentUser.value.email = input,
                // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                iconData: CupertinoIcons.device_phone_portrait,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 18, bottom: 8),
                child: Text(
                  'Biller Type'.tr,
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Container(
                  // width: MediaQuery.of(context).size.width * 0.45,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                    ),
                  ),
                  child: DropdownButton<BoxOption>(
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: Icon(Icons.arrow_drop_down,
                        color:Colors.black),
                    value: _selectedbox,
                    items: _boxItems,
                    hint: Text('Select bill'),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedbox = newValue!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BlockButtonWidget(
                onPressed: () {
                  // Get.to(DescoPostpaidBillView());
                  if (ph_number.length == 11) {
                    var result;
                    var data;
                    var datas;
                    double total;
                    var ref;

                    var res =
                        getBillDetail(acc_number, ph_number, _selectedbox.key);
                    Ui.customLoaderDialog();

                    _selectedbox.key == '1'
                        ? ErrorBillerType()
                        : res.then((value) => {
                              Get.back(),
                              result = value['result'],
                              data = value['data'],
                              ref = value['bill_ref'],
                              if (value['result'] == 'success')
                                {
                                  // Ui.SuccessSnackBar(message: value['result']),

                                  datas = {
                                    "title": _title,
                                    "images": _images,
                                    "bllr_accno": data['biller_acc_no'],
                                    "bll_mobno": data['biller_mobile'],
                                    "bll_typ": _selectedbox.key,
                                    "bll_amnt": data['bill_amount'],
                                    "bll_amnt_ttl":
                                            data['bill_total_amount'],
                                    "is_bll_pd": data['is_bill_paid'],
                                    "bll_late_fee": data['bill_late_fee'],
                                    "ekpay_fee": data['ekpay_fee'],
                                    "bllr_id": data['bllr_id'],
                                    "bill_payment_id": ref['bill_payment_id'],
                                    "bill_refer_id": ref['bill_refer_id'],
                                  },
                                  Get.to(JalalabadBillView(), arguments: datas)
                                }
                              else
                                Get.showSnackbar(Ui.ErrorSnackBar(
                                    message: value['message'],
                                    title: 'Failed'.tr))
                            });
                  } else {
                    Get.showSnackbar(Ui.ErrorSnackBar(
                        message: "Phone no not valid", title: 'Failed'.tr));
                  }
                },
                color: Color(0xFF652981),
                text: Text(
                  "SHOW BILL".tr,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ).paddingSymmetric(vertical: 10, horizontal: 20),
            ],
          ),
        ));
  }

  Future<Map<dynamic, dynamic>> getBillDetail(
      String accNumber, String phNumber, String billType) async {
    print(accNumber);
    print(phNumber);
    print(billType);
    Map data = {
      'biller_acc_no': accNumber,
      'biller_mobile_no': phNumber,
      'bill_type': billType,
    };

    var url = 'https://shl.com.bd/api/appapi/billpay/fetch/jalalabad-gas';

    // var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {'token': Get.find<AuthService>().currentUser.value.token!},
        body: data);
    var resp = json.decode(response.body);
    print('Bill Detail : $resp');
    return resp;
  }

  ErrorBillerType() {
    Get.back();
    Get.showSnackbar(Ui.ErrorSnackBar(
        message: 'Please Select Biller Type', title: 'Failed'.tr));
  }
}

class BoxOption {
  final String key;
  final String fullName;

  BoxOption(this.key, this.fullName);

  static List<BoxOption> get allBillerType => [
        BoxOption('1', 'Select Biller Type'.tr),
        BoxOption('M', 'Meter'.tr),
        BoxOption('NM', 'Non-Meter'.tr),
      ];
}
