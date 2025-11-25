import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';

class BillPaymentController extends GetxController {
  //TODO: Implement BillPaymentController

  final count = 0.obs;
  final pin = "".obs;
  final disable = false.obs;
  final isPaying = false.obs;
  final payment_id = ''.obs;
  final subscription_id = ''.obs;
  final amount = 0.0.obs;
  final refer_id = ''.obs;
  final servic_fee = ''.obs;
  final online_charge = ''.obs;
  final billpayLoaded = false.obs;
  final isChecked = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  billPaymentChargePreview(
      {required bill_payment_id, required bill_refer_id}) async {
    print("my preview data is $bill_payment_id and $bill_refer_id");
    Map data = {
      'bill_payment_id': bill_payment_id.toString(),
      'bill_refer_id': bill_refer_id.toString()
    };

    print("my charge parameter inbo are $data");

    String token = Get.find<AuthService>().currentUser.value.token!;

    // var headers = {'token': token};
    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    var url = '${ApiClient.v3baseUrl}/billpay/charge/preview';

    // var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);
    print("my charge payment structure are ${resp['data']}");
    var datas = resp['data'];

    servic_fee.value = datas['service_charge'];

    online_charge.value = datas['charge_for_online_balance_received'];
    print('Bill Charge : $resp');
    billpayLoaded.value = true;
  }

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

  akashPayment() async {
    print("aksh called");
    Map data = {
      'subscriber_id': "45000002",
      'amount': "44",
    };

    String token = Get.find<AuthService>().currentUser.value.token!;

    // var headers = {'token': token};
    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    var url =
        '${ApiClient.v3baseUrl}/agent-app/tv/bill/akash/confirm-subscription-payment';

    // var body = json.encode(data);

    var response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    var resp = json.decode(response.body);

    billpayLoaded.value = true;
  }
}
