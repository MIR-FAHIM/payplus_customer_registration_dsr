import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_form_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/Water/Kulna_wasa_bill_view.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class KhulnaWasaFormView extends StatefulWidget {
  @override
  State<KhulnaWasaFormView> createState() => _KhulnaWasaFormViewState();
}

class _KhulnaWasaFormViewState extends State<KhulnaWasaFormView> {
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

  final _size = Get.size;
  var bill_number = '';
  BillFormController billpayController = Get.put(BillFormController());
  @override
  Widget build(BuildContext context) {
    var _title = Get.arguments['title'];
    var _images = Get.arguments['images'];
    var _bill_no = Get.arguments['bill_no'];

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
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
        body: Obx(() {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: _size.width,
              height: _size.height,
              child: SingleChildScrollView(
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
                              image: NetworkImage(_images == null
                                  ? "https://shl.com.bd/uploads/billers/dwasa.png"
                                  : _images),
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
                      // keyboardType: numberFormatSymbols,
                      labelText: "Bill No".tr,
                      hintText: "Enter Bill No".tr,
                      onChanged: (value) {
                        setState(() {
                          bill_number = value;
                        });
                      },
                      initialValue: _bill_no,
                      // onSaved: (input) =>
                      // controller.currentUser.value.email = input,
                      // validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                      keyboardType: TextInputType.number,
                      iconData: null,
                      imageData: 'assets/bill/account.png',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 18, bottom: 8),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        child: DropdownButton<BoxOption>(
                          isExpanded: true,
                          underline: SizedBox(),
                          icon: Icon(Icons.arrow_drop_down,
                              color: Colors.black),
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
                      height: 10,
                    ),
                    _bill_no == ''
                        ? Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: billpayController.isChecked.value,
                                  onChanged: (value) {
                                    billpayController.isChecked.value = value!;
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    'Save the account for future payment'.tr,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    billpayController.isChecked.value == true
                        ? TextFieldWidget(
                            // keyboardType: numberFormatSymbols,
                            labelText: "Reference Name".tr,
                            hintText: "Enter Reference Name".tr,
                            onChanged: (value) {
                              billpayController.refName.value = value;
                            },

                            // keyboardType: TextInputType.,
                            iconData: null,
                            imageData: 'assets/bill/Rosid.png',
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    BlockButtonWidget(
                      onPressed: () {
                        // Get.to(DescoPostpaidBillView());

                        var result;
                        var data;
                        var datas;
                        var bill_ref;
                        var Bill_No =
                            bill_number == '' ? _bill_no : bill_number;
                        print('bill numer:  $Bill_No');

                        var res = getBillDetail(
                            Bill_No,
                            _selectedbox.key,
                            billpayController.isChecked.value,
                            billpayController.refName.value);
                        Ui.customLoaderDialog();

                        _selectedbox.key == '1'
                            ? ErrorBillerType()
                            : res.then((value) => {
                                  Get.back(),
                                  result = value['result'],
                                  data = value['data'],
                                  bill_ref = value['bill_ref'],
                                  if (value['result'] == 'success')
                                    {
                                      // Ui.SuccessSnackBar(message: value['result']),

                                      datas = {
                                        "title": _title,
                                        "images": _images,
                                        "bill_payment_id":
                                            bill_ref['bill_payment_id'],
                                        "bill_refer_id":
                                            bill_ref['bill_refer_id'],
                                        "bll_no": data['bill_no'],
                                        "bllr_accno": data['biller_acc_no'],
                                        "bll_dt_frm": data['bill_from'],
                                        "bll_dt_to": data['bill_to'],
                                        "bll_amnt": data['bill_amount'],
                                        "bll_vat": data['bill_vat'],
                                        "bill_total_amount":
                                            data['bill_total_amount'],
                                        "is_bll_pd": data['is_bill_paid'],
                                        "ekpay_fee": data['ekpay_fee'],
                                      },
                                      Get.to(KhulnaWasaBillView(),
                                          arguments: datas)
                                    }
                                  else
                                    Get.showSnackbar(Ui.ErrorSnackBar(
                                        message: value['message'],
                                        title: 'Failed'.tr))
                                });
                      },
                      color: Color(0xFF652981),
                      text: Text(
                        "SHOW BILL".tr,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ).paddingSymmetric(vertical: 10, horizontal: 20),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Future<Map<dynamic, dynamic>> getBillDetail(String billNumber,
      String billType, dynamic isBillSave, String refName) async {
    print(billNumber);
    print(billType);
    print(isBillSave);
    print(refName);
    var billSave = isBillSave.toString();
    Map data = {
      'bill_no': billNumber,
      'bill_type': billType,
      'is_bill_save': billSave,
      'bill_save_nick_name': refName,
    };
    String token = Get.find<AuthService>().currentUser.value.token!;

    // var headers = {'token': 'IMBkVG1UFCE8VABPg5TI14yY44StEfWqF341OAlh'};

    var headers = {'token': token};

    var url = 'https://shl.com.bd/api/appapi/billpay/fetch/khulna-wasa';

    // var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: headers, body: data);
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
      ];
}
