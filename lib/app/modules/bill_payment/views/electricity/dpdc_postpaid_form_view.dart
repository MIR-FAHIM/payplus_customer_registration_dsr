import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_form_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_payment_controller.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/text_field_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class DPDCPostpaidFormView extends StatefulWidget {
  // const DPDCPostpaidFormView({Key? key}) : super(key: key);

  @override
  State<DPDCPostpaidFormView> createState() => _DPDCPostpaidFormViewState();
}

class _DPDCPostpaidFormViewState extends State<DPDCPostpaidFormView> {
  BillFormController billpayController = Get.put(BillFormController());
  BillPaymentController billpaymentController = Get.put(BillPaymentController());

  var bill_number = '';

  DateTime initialDate = DateTime.now();
  DateTime? selectedDate;
  var myFormat = DateFormat('yyyy-MM');
  var myFormat1 = DateFormat('MMMM, y');

  @override
  void initState() {
    super.initState();

    selectedDate = initialDate;
  }

  // DateTime _selectedDate = DateTime.now();
  // var myFormat = DateFormat('yyyy-MM');
  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: _selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != _selectedDate)
  //     setState(() {
  //       _selectedDate = picked;
  //     });
  // }

  selectMonth(BuildContext context) {
    // showMonthPicker(
    //   context: context,
    //   firstDate: DateTime(DateTime.now().year - 1, 5),
    //   lastDate: DateTime(DateTime.now().year + 1, 9),
    //   initialDate: selectedDate ?? initialDate,
    //   // locale: Locale("en"),
    // ).then((date) {
    //   if (date != null) {
    //     setState(() {
    //       selectedDate = date;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    var _title = Get.arguments['title'] ?? '';
    var _images = Get.arguments['images'] ?? '';
    var _bill_no = Get.arguments['bill_no'] ?? '';

    print(_bill_no);
    final _size = Get.size;
    String _startMonth = "${myFormat.format(selectedDate!)}";
    String monthName = "${myFormat1.format(selectedDate!)}";

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
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     _title,
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       color: Color(0xFF652981),
                    //     ),
                    //   ),
                    // ),
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
                              image: NetworkImage(_images == null ? "https://shl.com.bd/uploads/billers/dwasa.png" : _images),
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
                      labelText: "Account No".tr,
                      hintText: "Enter Account No".tr,
                      initialValue: _bill_no,
                      onChanged: (value) {
                        setState(() {
                          bill_number = value;
                        });
                      },
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
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Choose Month To Pay : '.tr + " :",
                        style: TextStyle(fontSize: 18, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {
                        billpayController.openBottomSheetBill();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 8,top: 8),
                        child: Container(
                          height: Get.height * .08,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                  const Color(0xFF652981).withOpacity(0.2),
                                  blurRadius: 2,
                                  offset: const Offset(0, 2)),
                            ],
                            //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${billpayController.getMonthName(billpayController.selectedMonth.value)}, ${billpayController.selectedYear.value}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                    // BlockButtonWidget(
                    //   onPressed: () {
                    //     selectMonth(context);
                    //   },
                    //   color: Color(0xFF652981),
                    //   text: Text(
                    //     'Choose Month To Pay'.tr,
                    //     style: TextStyle(color: Colors.white, fontSize: 16),
                    //   ),
                    // ).paddingSymmetric(vertical: 10, horizontal: 20),
                    SizedBox(
                      height: 10,
                    ),
                    BlockButtonWidget(
                      onPressed: () {
                        // Get.to(DescoPostpaidBillView());

                        var result;
                        var data;
                        var datas;
                        var ref;
                        var Bill_No = bill_number == '' ? _bill_no : bill_number;
                        print(Bill_No);
                        var res = getBillDetail(Bill_No, _startMonth, billpayController.isChecked.value, billpayController.refName.value);
                        Ui.customLoaderDialog();
                        res.then((value) => {
                              Get.back(),
                              result = value['result'],
                              data = value['data'],
                              ref = value['bill_ref'],
                              print(data),
                              if (value['result'] == 'success')
                                {
                                  // Ui.SuccessSnackBar(message: value['result']),
                                  print(data['bllr_accno']),
                                  billpaymentController.billPaymentChargePreview(

                                    bill_payment_id:value['bill_ref']['bill_payment_id'],

                                    bill_refer_id: value['bill_ref']['bill_refer_id'],
                                  ),
                                  datas = {
                                    "title": _title,
                                    "images": _images,
                                    "bill_payment_id": ref['bill_payment_id'],
                                    "bill_refer_id": ref['bill_refer_id'],
                                    "bll_no": data['bill_no'],
                                    "bllr_accno": data['biller_acc_no'],
                                    "bll_dt_frm": data['bill_from'],
                                    "bll_dt_to": data['bill_to'],
                                    "bll_dt_due": data['bill_due_date'],
                                    "bll_amnt": data['bill_amount'],
                                    "bll_vat": data['bill_vat'],
                                    "bll_amnt_ttl": data['bill_total_amount'],
                                    "is_bill_paid": data['is_bill_paid'],
                                    "ekpay_fee": data['ekpay_fee'],
                                  },
                                  Get.toNamed(Routes.DPDC_Postpaid_Billview, arguments: datas)
                                }
                              else{
                                Get.showSnackbar(Ui.ErrorSnackBar(message: value['message'], title: 'error'.tr))
                              }

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

  Future<Map<dynamic, dynamic>> getBillDetail(String billNumber, String selectedMonth, dynamic isBillSave, String refName) async {
    print(billNumber);
    print(selectedMonth);
    print(isBillSave);
    print(refName);
    var billSave = isBillSave.toString();
    Map data = {
      'biller_acc_no': billNumber,
      'bill_period': selectedMonth,
      'is_bill_save': billSave,
      'bill_save_nick_name': refName,
    };

    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    // var headers = {'token': 'IMBkVG1UFCE8VABPg5TI14yY44StEfWqF341OAlh'};

    var url = '${ApiClient.v3baseUrl}/billpay/fetch/dpdc-postpaid';

    // var body = json.encode(data);

    var response = await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);
    // print('Bill Detail : $resp');
    return resp;
  }
}
class MonthList extends StatelessWidget {
  final int selectedYear;

  MonthList(this.selectedYear);

  @override
  Widget build(BuildContext context) {
    List<String> months = List.generate(12, (index) {
      DateTime date = DateTime(selectedYear, index + 1, 1);
      return DateFormat('MMMM').format(date);
    });

    return Column(
      children: [
        Text('Months for $selectedYear:'),
        Column(
          children: months
              .map((month) => ListTile(
            title: Text(month),
          ))
              .toList(),
        ),
      ],
    );
  }
}