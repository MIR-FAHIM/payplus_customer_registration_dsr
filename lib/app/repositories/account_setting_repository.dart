import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/service_fee_model.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';

class AccountSettingRepository {
  Future saveAccountInfo(
    String name,
    String nid,
    String email,
    String mobile,
    String divisionId,
    String districtID,
    String thanaId,
    String unionId,
    String wordNo,
    String permAddress,
    String presentAddress,
  ) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    print(token);

    Map accountData = {
      'customer_name': name,
      'nid': nid,
      'email': email,
      'personal_mobile': mobile,
      'division_id': divisionId,
      'district_id': districtID,
      'thana_id': thanaId,
      'union_id': unionId,
      'word_no': wordNo,
      'premanent': permAddress,
      'present': presentAddress
    };

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.saveInfo, accountData, headers);

    print('account save: ${response}');
    return response;
  }
  Future accountInfo() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    print(token);

    Map accountData = {};

    var headers = {
      'x-api-key': "a795943d-e4e9-4de8-b595-4947a856b7cc",
      'Content-Type': "application/json"
    };
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.accountInfo, accountData, headers);

    print('account data: ${response}');
    return response;
  }
  Future checkUserImagePorichoy(Map data) async {
    var headers = {
      'x-api-key': "a795943d-e4e9-4de8-b595-4947a856b7cc",
      'Content-Type': "application/json"
    };
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithEncoded(
        "https://api.porichoybd.com/api/v0/kyc/nid-person-values-image-match",
        data,
        headers);

    print('porichoy image +++++++++++++: ${response}');
    return response;
  }

  Future deactivateAccount(String pin, String msg) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    print(token);

    Map accountData = {
      'pin': pin,
      'comments': msg,
    };

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.deactivateAccount, accountData, headers);

    print('Deactivate result: ${response}');
    return response;
  }

  Future saveAccountInformation() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    print(token);

    Map accountData = {};

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.saveInfo, accountData, headers);

    print('account data: ${response}');
    return response;
  }

  Future<ServiceFeeModel> getServiceFee() async {
    // String token = Get.find<AuthService>().currentUser.value.token!;

    // var headers = {'token': 'loqCAASkg4v9RnKAuQxZkZElJ5eTBYYZZyb19Awn'};

    Map data = {'remark': 'Agent'};

    APIManager _manager = APIManager();
    final response = await _manager.postAPICall(ApiClient.serviceFee, data);

    print('Service Fee Types: ${response}');
    return ServiceFeeModel.fromJson(response);
    // return ServiceFeeModel.fromJson(response);
  }
}
