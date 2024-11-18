import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/daily_report_model.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';

class DailyReportRepo {
  Future<DailyReportModel> getDailyReports(
      String startDate, String endDate) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    Map body = {
      'customer_code':
       Get.find<AuthService>().currentUser.value.customerCode ?? '',  //'9634',
      'date': startDate,
      'end_date': endDate,
    };

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.dailyReport, body, headers);

    print('daily report data: ${response}');

    return DailyReportModel.fromJson(response);
  }

  // Future<Map<String, dynamic>> getDailyReports(String today) async {
  //   String token = Get.find<AuthService>().currentUser.value.token!;

  //   print(today);

  //   print(token);

  //   Map body = {
  //     'customer_code':
  //         Get.find<AuthService>().currentUser.value.customerCode ?? '',
  //     'date': today,
  //   };

  //   var headers = {'token': token};
  //   APIManager _manager = APIManager();
  //   final response = await _manager.postAPICallWithHeader(
  //       ApiClient.dailyReport, body, headers);

  //   print('daily report data: ${response}');
  //   return response;
  // }
}
