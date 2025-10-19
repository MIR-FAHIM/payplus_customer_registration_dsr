import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/cashback_offer_model.dart';
import 'package:latest_payplus_agent/app/models/package_model.dart';
import 'package:latest_payplus_agent/app/models/recharge/robiairtelmodel.dart';
import 'package:latest_payplus_agent/app/models/recharge_report_model.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';

class RechargeRepository {
  Future recharge(
    String number,
    String amount,
    String operatorID,
    String numberType,
    String pin,
  ) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    Map rechargeData = {
      'number': number,
      'amount': '$amount',
      'operator': '$operatorID',
      'number_type': numberType == 'Prepaid'
          ? 'pre-paid'
          : numberType == 'Postpaid'
              ? 'post-paid'
              : numberType == 'Skitto'
                  ? 'skitto'
                  : '',
      'pin': '$pin',
      'remark': 'Agent'
    };
    print(rechargeData);
    print(token);

    var headers = {'token': token};

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.recharge, rechargeData, headers);

    print('recharge number: ${response}');
    return response;
  }

  Future taskAddController() async {
    Map<String, String> bodyString = {
      "operator_id": "2",
      "package_type_id": "1",
    };

    Uri url = Uri.parse("https://shl.com.bd/api/appapi/offer-list-post");
    final responsse = await http.post(
      url,
      body: bodyString,
      headers: {'token': 'upAnzac03X2r6lkH4iHLlqTtjaUBNfwd9ZsbxQv1'},
    );
    print("my resposnse repo ${responsse.statusCode}");
    print("my resposnse repo ${responsse.body}");
    String data = responsse.body;

    return data;
  }

  Future<List<PackageModel>> getPackages(
      String operatorId, String packageId) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    Map packageData = {'operator_id': operatorId, 'package_type_id': packageId};
    print(packageData);
    print(token);

    var headers = {'token': "upAnzac03X2r6lkH4iHLlqTtjaUBNfwd9ZsbxQv1"};

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        'https://shl.com.bd/api/appapi/offer-list-post', packageData, headers);

    print('Get packages: ${response}');

    return List.from(response.map((item) => PackageModel.fromJson(item)));
  }

  Future<RechargeReportModel> getRechargeReports(String date) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    Map numberCheck = {
      'token': '$token',
      'recharge_number': 'no_num',
      "date": date,
    };
    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager
        .postAPICallWithHeader(ApiClient.rechargeReport, numberCheck, {});
    return RechargeReportModel.fromJson(response);
  }

  Future<RechargeReportModel> getRechargeReportsSearch(String number) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    Map numberCheck = {
      'token': '$token',
      'recharge_number': number,
    };
    // print(packageData);
    print(token);

    var headers = {'token': token};

    APIManager _manager = APIManager();
    final response = await _manager
        .postAPICallWithHeader(ApiClient.rechargeReport, numberCheck, {});

    print('recharge report: ${response}');
    return RechargeReportModel.fromJson(response);
  }

  Future getRobiAirtelOffer(String operatorID, String number) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    print(token);
    Map operatorId = {
      'operator_id': operatorID,
      'number': number,
      'amount': "0"
    };
    var headers = {'token': token};
    print("robi ++++++++$operatorID token +++++++++++$token");

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.robiairtelOffer, operatorId, headers);

    print('recharge offer: ${response}');

    return response;
  }

  Future getSpecialOffer(String operatorID, String number) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    print('operstor id is $operatorID');
    Map operatorId = {
      'operator_id': operatorID,
      'number': number,

    };
    var headers = {'token': token};
    print("special+++++$operatorID token +++++++++++$token");

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.specialOfferRecharge, operatorId, headers);

    print('special recharge offer: ${response}');

    return response;
  }

  Future<List<PackageModel>> getAmountOffer(String operatorId) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    print(token);

    var headers = {'token': token};

    APIManager _manager = APIManager();
    final response = await _manager.get(ApiClient.amountOffer + operatorId);

    print('recharge pffer: ${response}');
    return List.from(
        response['data'].map((item) => PackageModel.fromJson(item)));
  }

  Future<CashBackReportModel> getCashBackOffer(String operator) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    var id = operator.toString() == "" ? "0" : operator.toString();
    print('oparetor : $operator');

    Map operatorId = {
      'operator_id': id,
    };
    print(token);

    var headers = {'token': token};

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.cashbackOffer, operatorId, headers);

    print('CashBack Offer: ${response}');
    return CashBackReportModel.fromJson(response);
  }

  Future getCommission(String amount, String operatorId) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    Map comCheck = {'operator_id': operatorId, 'amount': amount};
    // print(packageData);
    print(token);

    var headers = {'token': token};

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.commisionCheck, comCheck, headers);

    print('commission: ${response}');
    return response;
  }

  Future rechargeRobiAirtel(
      {String? amount,
      String? operatorId,
      String? number,
      String? pin,
      String? adminCom,
      String? cusCom,
      String? com,
      String? packageId,
      String? rechargeCom}) async
  {
    String token = Get.find<AuthService>().currentUser.value.token!;
    print(
        "offer recharge amount ++++++++++++ $amount  ++++++$token ++++++ $number++++++++++++$packageId++++++++++++++++$operatorId");
    Map comCheck = {
      'operator_id': operatorId,
      'amount': amount,
      "number": number,
      'package_id': packageId,
      "cust_commission": cusCom,
      "commission": com,
      "admin_commission": adminCom,
      "recharge_commission": rechargeCom,
      "pin": pin
    };
    // print(packageData);

    var headers = {'token': token};

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.rechargeRobiAirtel, comCheck, headers);

    print('commission: ${response}');
    return response;
  }

  Future rechargeSpecialOffer(
      {
      required  String? amount,
        required   String? operatorId,
        required String? number,
        required String? pin,
        required String? simNUmber,
        required  String? commision,
        required  String? campaignID,
        required  String? optInKeyword,
        required String? packageId,
        required  String? rechargeCom,
        required  String? sessionContext
      }) async
  {
    String token = Get.find<AuthService>().currentUser.value.token!;
    print(
        "offer recharge amount ++++++++++++ $amount  ++++++$token ++++++ $number++++++++++++$packageId++++++++++++++++$operatorId");
    Map comCheck = {
      'operator_id': operatorId,
      'amount': amount,
      "number": number,
      'offerId': packageId,
      'optInKeyword':optInKeyword,
      'campaignID':campaignID,
      'sim_number': simNUmber,
      "retailerCommission": commision,
      "recharge_commission": rechargeCom,
      "sessionContext": sessionContext,
      "pin": pin
    };


    var headers = {'token': token};

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.specialOfferRecharge, comCheck, headers);

    print('commission: ${response}');
    return response;
  }
}
