import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/account_statement_model.dart';
import 'package:latest_payplus_agent/app/models/account_statement_summery_model.dart';
import 'package:latest_payplus_agent/app/models/all_notification_model.dart';
import 'package:latest_payplus_agent/app/models/notification_model.dart';
import 'package:latest_payplus_agent/app/models/transaction_report_model.dart';
import 'package:latest_payplus_agent/app/models/transaction_type_model.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';

class NotificationRepository {
  Future<NotificationModel> getNotifications() async {
    String acc_no = Get.find<AuthService>().currentUser.value.customerCode!;
    Map notificationData = {
      'acc_no': acc_no,
      'type': 'Retailer',
    };

    APIManager _manager = APIManager();
    final response = await _manager
        .postAPICallWithHeader(ApiClient.notifications, notificationData, {});

    print('notifications: ${response}');
    return NotificationModel.fromJson(response);
  }
  Future changeNotificationStatus(notiID) async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    // String acc_no = Get.find<AuthService>().currentUser.value.customerCode!;
    // Map notificationData = {
    //   'acc_no': acc_no,
    //   'type': 'Retailer',
    // };
    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };
    Map notificationData = {
      'notification_id': notiID.toString(),
      'activity_status': '0',
    };
    APIManager _manager = APIManager();
    final response =
    await _manager.postAPICallWithHeader(ApiClient.changeNotificationStatus, notificationData, headers);

    print('notifications: ${response}');
    return response;
  }
  Future<AllNotificationModel> getAllNotifications() async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    // String acc_no = Get.find<AuthService>().currentUser.value.customerCode!;
    // Map notificationData = {
    //   'acc_no': acc_no,
    //   'type': 'Retailer',
    // };
    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICallHeader(ApiClient.allnotifications, headers);

    print('notifications: ${response}');
    return AllNotificationModel.fromJson(response);
  }

  Future<List<TransactionTypeModel>> gettransactionType() async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };
    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICallWithHeader(ApiClient.transactionType, {}, headers);

    print('transaction type: ${response}');
    return List.from(response.map((item) => TransactionTypeModel.fromJson(item)));
  }

  // Future<List<TransactionReportModel>> gettransactionReport(
  //     {String type = '0', String from = '', String to = ''}) async {
  //   String token = Get.find<AuthService>().currentUser.value.token!;

  //   Map data = {'type': type, 'from': from, 'to': to};

  //   var headers = {'token': token};
  //   APIManager _manager = APIManager();
  //   final response = await _manager.postAPICallWithHeader(
  //       ApiClient.transactionReport, data, headers);

  //   print('transaction report: ${response}');
  //   return List.from(
  //       response.map((item) => Datum.fromJson(item)));
  // }

  Future<dynamic> gettransactionReport(
      {String type = '0', String from = '', String to = ''}) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    // Map data = {'type': type, 'from': from, 'to': to};
    Map data = {'searchvalue': '01711242148'};

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(ApiClient.transactionReport, {},
       headers);

    print('transaction report: ${response}');
    return TransactionReportModel.fromJson(response);
  }

  Future<AccountStatementModel> getAccountStatement() async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    // String acc_no = Get.find<AuthService>().currentUser.value.customerCode!;
    // Map notificationData = {
    //   'acc_no': acc_no,
    //   'type': 'Retailer',
    // };
    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICallHeader(ApiClient.account_statement, headers);

    print('Acount Statement: ${response}');
    return AccountStatementModel.fromJson(response);
  }

  Future<AccountStatemenSummerytModel> getAccountStatementSummery(String month) async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    // String acc_no = Get.find<AuthService>().currentUser.value.customerCode!;
    Map data = {'month': month};
    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.account_statement_summery, data, headers);

    print('Acount Statement: ${response}');
    return AccountStatemenSummerytModel.fromJson(response);
  }

  Future<AccountStatemenSummerytModel> getAccountStatementSummeryWithMonth(month) async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    // String acc_no = Get.find<AuthService>().currentUser.value.customerCode!;
    Map data = {'month': month};
    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.account_statement_summery, data, headers);

    print('Acount Statement: ${response}');
    return AccountStatemenSummerytModel.fromJson(response);
  }
}
