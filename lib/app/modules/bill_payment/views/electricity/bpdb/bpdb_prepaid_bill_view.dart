import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/electricity/bpdb_fetch_model.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/controllers/bill_payment_controller.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/bill_payment_view.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/widgets/bill_payment-success_view.dart';
import 'package:latest_payplus_agent/app/modules/global_widgets/block_button_widget.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/common/Color.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class BPDBPrepaidBillView extends GetView<BillPaymentController> {
  BPDBPrepaidBillView({Key? key}) : super(key: key);

  final RxBool isPaying = false.obs; // tracks Pay Bill button state

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    final FetchBpdbModel data = Get.arguments[0];
    final String title = Get.arguments[1];
    final String imageUrl = Get.arguments[2];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: const Color(0xFF652981),
          centerTitle: true,
          title: Text(title),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.off(BillPaymentView()),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          Get.offAllNamed(Routes.BILL_PAYMENT);
          return Future.value(false);
        },
        child: Obx(() {
          if (!controller.billpayLoaded.isTrue) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Center(child: Ui.customLoader()),
            );
          }

          final total = double.parse(data.data!.billTotalAmount) +
              double.parse(controller.online_charge.value) +
              double.parse(controller.servic_fee.value);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),

                // Header with logo + title
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: 40,
                        width: 50,
                        image: NetworkImage(imageUrl),
                      ),
                      const SizedBox(width: 10),
                      Text(title),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      _divider(size),
                      _infoRow(
                        label: "Biller Acc No.",
                        value: data.data!.billNo!,
                      ),
                      _divider(size),
                      _infoRow(
                        label: "Biller Name",
                        value: data.data!.customerName,
                      ),
                      _divider(size),
                      _infoRow(
                        label: "Biller Mobile No.",
                        value: data.data!.billerMobile,
                      ),
                      _divider(size),
                      _infoRow(
                        label: "Bill Payment Status",
                        value:
                        data.data!.isBillPaid == 'Y' ? "Paid" : "Not Paid",
                      ),
                      const SizedBox(height: 15),

                      _infoRow(
                        label: "Amount",
                        value: '৳ ${data.data!.billAmount!}',
                      ),
                      _infoRow(
                        label: "Online Charge",
                        value: '৳ ${controller.online_charge.value}',
                      ),
                      _infoRow(
                        label: "Service Fee",
                        value: '৳ ${controller.servic_fee.value}',
                      ),

                      _divider(size),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total : ",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.homeTextColor1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '৳ $total',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.homeTextColor3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // If already paid
                if (data.data!.isBillPaid == 'Y')
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "আপনার বিলটি ইতিমধ্যে পরিশোধ করা হয়েছে",
                        style: TextStyle(
                          color: AppColors.greenTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                else
                // Pay Bill button with disable-on-click behavior
                  Obx(
                        () => BlockButtonWidget(
                      onPressed: isPaying.value
                          ? null
                          : () async {
                        // prevent double-tap
                        if (isPaying.value) return;
                        isPaying.value = true;

                        try {
                          var result;
                          var preview;

                          var currentBalance;
                          var billAmount;
                          var serviceCharge;
                          var onlineCharge;
                          var grandTotalAmount;

                          Ui.customLoaderDialog();
                          final value = await BillPaymentChargePreview(
                            data.billRef!.billPaymentId,
                            data.billRef!.billReferId,
                          );
                          Get.back();

                          result = value['result'];
                          preview = value['data'];

                          if (result == 'success') {
                            currentBalance = preview['current_balance'];
                            billAmount = preview['bill_amount'];
                            serviceCharge = preview['service_charge'];
                            onlineCharge = preview[
                            'charge_for_online_balance_received'];
                            grandTotalAmount =
                            preview['grand_total_amount'];

                            openBottomSheetBill(
                              currentBalance: currentBalance,
                              billAmount: billAmount,
                              serviceCharge: serviceCharge,
                              onlineCharge: onlineCharge,
                              totalAmount: grandTotalAmount,
                              title: title,
                              image: imageUrl,
                              paymentID: data.billRef!.billPaymentId,
                              referId: data.billRef!.billReferId,
                              meterNum: "",
                            );
                          } else {
                            Get.showSnackbar(
                              Ui.ErrorSnackBar(
                                message: value['message'],
                                title: 'error'.tr,
                              ),
                            );
                          }
                        } finally {
                          // always re-enable button
                          isPaying.value = false;
                        }
                      },
                      color: isPaying.value
                          ? Colors.grey
                          : const Color(0xFF652981),
                      text: Text(
                        isPaying.value
                            ? "Processing...".tr
                            : "Pay Bill".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ).paddingSymmetric(vertical: 10, horizontal: 20),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _divider(Size size) {
    return Container(
      width: size.width,
      height: 1,
      color: AppColors.SectionHighLightCardBg,
    );
  }

  Widget _infoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.homeTextColor3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<dynamic, dynamic>> BillPaymentChargePreview(
      int billPaymentID, String billRefId) async {
    final data = {
      'bill_payment_id': billPaymentID.toString(),
      'bill_refer_id': billRefId,
    };

    final token = Get.find<AuthService>().currentUser.value.token!;
    final headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value,
    };

    final url = '${ApiClient.v3baseUrl}/billpay/charge/preview';

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: data,
    );

    final resp = json.decode(response.body);
    print('Bill Charge : $resp');
    return resp;
  }

  Future<Map<dynamic, dynamic>> BillPayment({
    int? billPaymentID,
    String? billRefId,
    String? billAmount,
    String? serviceCharge,
    String? onlineCharge,
    String? totalAmount,
    String? pin,
  }) async {
    final data = {
      'bill_payment_id': billPaymentID.toString(),
      'bill_refer_id': billRefId,
      'bill_amount': billAmount,
      'service_charge': serviceCharge,
      'charge_for_online_balance_received': onlineCharge,
      'grand_total_amount': totalAmount,
      'pin': pin.toString(),
    };

    final token = Get.find<AuthService>().currentUser.value.token!;
    final headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value,
    };

    final url =
        '${ApiClient.v3baseUrl}/billpay/pay/app-bill-payment-common';

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: data,
    );

    final resp = json.decode(response.body);
    print('Bill Detail : $resp');
    return resp;
  }

  void openBottomSheetBill({
    String? currentBalance,
    String? billAmount,
    String? serviceCharge,
    String? onlineCharge,
    String? totalAmount,
    dynamic title,
    dynamic image,
    dynamic paymentID,
    dynamic referId,
    String? meterNum,
  }) {
    final size = Get.size;
    final hasInsufficientFunds =
        double.parse(totalAmount!) > double.parse(currentBalance!);

    Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Recipient'.tr,
                          style: TextStyle(
                            color: AppColors.homeTextColor3,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      if (hasInsufficientFunds)
                        Text(
                          'insufficient funds'.tr,
                          style: TextStyle(
                            color: AppColors.redTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: IconButton(
                          icon: const Icon(Icons.cancel_rounded),
                          iconSize: 30,
                          color: Colors.grey,
                          splashColor: Colors.purple,
                          onPressed: Get.back,
                        ),
                      ),
                    ],
                  ),

                  // Logo + title
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        Image.network(
                          image,
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Details rows
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 22, top: 15, right: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meter Number'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.homeTextColor3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              meterNum ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Amount'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.homeTextColor3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ $billAmount',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Service Fee'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.homeTextColor3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ $serviceCharge',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),

                        // Right column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Present Balance'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.homeTextColor3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ $currentBalance',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Online Charge'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.homeTextColor3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ $onlineCharge',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Total'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.homeTextColor3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '৳ $totalAmount',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // PIN field (only if enough balance)
            if (!hasInsufficientFunds)
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: size.width,
                  decoration: Ui.getBoxDecoration(radius: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: TextFormField(
                      cursorColor: const Color(0xFF652981),
                      textAlign: TextAlign.center,
                      maxLength: 6,
                      obscureText: true,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        hintText: 'Enter PIN here'.tr,
                        hintStyle: const TextStyle(
                          color: Color(0xFF652981),
                          fontSize: 15,
                        ),
                        prefixIcon: const Icon(
                          CupertinoIcons.lock,
                          color: Color(0xFF652981),
                        ),
                        focusColor: const Color(0xFF652981),
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (input) {
                        controller.pin.value = input;
                      },
                    ),
                  ),
                ),
              ),

            // Bottom action button
            hasInsufficientFunds
                ? BlockButtonWidget(
              onPressed: () {
                Get.toNamed(Routes.Add_Balance_Form_View);
              },
              color: const Color(0xFF652981),
              text: Text(
                "Add Your Balance".tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ).paddingSymmetric(vertical: 10, horizontal: 10)
                : BlockButtonWidget(
              onPressed: () async {
                if (hasInsufficientFunds) return;

                var result;
                var data;
                var datas;

                final res = BillPayment(
                  billPaymentID: paymentID,
                  billRefId: referId,
                  billAmount: billAmount,
                  serviceCharge: serviceCharge,
                  onlineCharge: onlineCharge,
                  totalAmount: totalAmount,
                  pin: controller.pin.value,
                );

                Ui.customLoaderDialog();
                final value = await res;
                Get.back();

                result = value['result'];
                data = value['data'];

                if (result == 'success') {
                  datas = {
                    "title": title,
                    "images": image,
                    "bll_no": data['bill_no'],
                    "bllr_accno": data['biller_acc_no'],
                    "bll_mobno": data['biller_mobile'],
                    "bll_dt_frm": data['bill_from'],
                    "bll_dt_to": data['bill_to'],
                    "bill_due_date": data['bill_due_date'],
                    "bill_total_amount": data['bill_total_amount'],
                    "charge": data['charge'],
                    "transaction_id": data['transaction_id'],
                    "payment_date": data['payment_date'],
                  };
                  Get.offAll(
                    BillPaymentSuccessView(),
                    arguments: datas,
                  );
                } else if (value['message'] == 'Invalid Token.') {
                  Get.find<AuthService>().refreshToken();
                } else {
                  Get.showSnackbar(
                    Ui.ErrorSnackBar(
                      message: value['message'],
                      title: 'error'.tr,
                    ),
                  );
                }
              },
              color: hasInsufficientFunds
                  ? Colors.grey
                  : const Color(0xFF652981),
              text: hasInsufficientFunds
                  ? Text(
                "insufficient Funds".tr,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              )
                  : Text(
                "Confirm Bill Payment".tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ).paddingSymmetric(vertical: 10, horizontal: 20),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
