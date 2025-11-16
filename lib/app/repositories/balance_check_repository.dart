import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/ad_banner_model.dart';
import 'package:latest_payplus_agent/app/models/dashboardReportModel.dart';
import 'package:latest_payplus_agent/app/models/get_permission_model.dart';
import 'package:latest_payplus_agent/app/models/get_profile_info_model.dart';
import 'package:latest_payplus_agent/app/models/transaction_verify_payment.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';

class BalanceCheckRepository {
  Future balanceCheck() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    var body = {
      'token': token,
      'accNo': Get.find<AuthService>().currentUser.value.customerCode ?? '',
      'accNoOrPhone':
          Get.find<AuthService>().currentUser.value.mobileNumber ?? '',
    };
    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.balanceCheck, body, headers);

    print('balance check: ${response}');
    return response;
  }

  Future<DahsboardReportModel> dashboardData() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    print(headers);

    APIManager _manager = APIManager();
    final response =
        await _manager.getWithHeader(ApiClient.dashboardData, headers);

    print('dashboard data: ${response}');
    return DahsboardReportModel.fromJson(response);
  }

//profile info ++++++++++++++++++++
  Future getProfileInfo() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    print(headers);

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.getProfileInfo, {}, headers);

    print('profile data: ${response}');
    return response;
  }

  Future logOut() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    print(headers);

    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICallWithHeader(ApiClient.v3logOut, {}, headers);

    print('log out: ${response}');
    return response;
  }

  Future refreshToken() async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICall(ApiClient.refreshToken, {
      'refresh_token': Get.find<AuthService>().currentUser.value.refreshToken
    });

    print('profile data: ${response}');
    return response;
  }

  // profile info end

  //get all disable permission
  Future<GetPermissionModel> getDisablePermission() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    print(headers);

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.getPermissionData, {}, headers);

    print('permission data ****** ****** ******: ${response}');
    return GetPermissionModel.fromJson(response);
  }

  Future<GetPermissionModel> getFeaturePermissionOnCustomer() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };

    print(headers);

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.appFeaturePermissionOnCustomer, {}, headers);

    print('permission data customer feature****** ****** ******: ${response}');
    return GetPermissionModel.fromJson(response);
  }

  // get all disable permission

  Future<List<AdBannerModel>> getBanner() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    print(token);

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.advertisementBanner, {'app_for': 'Agent'}, headers);

    print('banner: ${response}');
    return List.from(response.map((item) => AdBannerModel.fromJson(item)));
  }

  Future<List<TransactionVerifyPaymentModel>>
      getTransactionPaymentMethods() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    print(token);

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.transactionVerifyPaymentMethod,
        {'for_trx_verify': '1'},
        headers);

    print('transaction verify: ${response}');
    return List.from(
        response.map((item) => TransactionVerifyPaymentModel.fromJson(item)));
  }

  Future transactionVerify(
    String paymentMethod,
    String txid,
  ) async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    String referenceNo =
        Get.find<AuthService>().currentUser.value.mobileNumber!;
    print(token);

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.transactionVerify, {
      'payment_method_code': paymentMethod,
      'trxId': txid,
      'referenceNo': referenceNo
    }, {});

    print('transaction verify: ${response}');
    return response;
  }
}
