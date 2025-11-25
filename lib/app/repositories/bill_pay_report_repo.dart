import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/billDetails.dart';
import 'package:latest_payplus_agent/app/models/billpayhistorymodel.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';

class BillPayReportRepo {
  Future getBillHistory({String? dateTo, String? dateFrom}) async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    print("getBillHistory rep 455");
    Map body = {
      'bill_type_id': '0',
      'from': dateFrom,
      'to': dateTo,
      'search_key': '0'
    };

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.billHistory, body, headers);

    print('bill history report data: ${response}');

    return response;
  }

  Future<BillPayDetails> getBillDetails(String id) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    Map body = {'id': id};

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.billDetails, body, headers);

    print('daily report data: ${response}');

    return BillPayDetails.fromJson(response);
  }
}
