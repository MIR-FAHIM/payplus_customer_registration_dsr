import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/add_balance_model/mfs_list_model.dart';
import 'package:latest_payplus_agent/app/models/mbanking_gateway_model.dart';
import 'package:latest_payplus_agent/app/models/mfsPaymentType.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';

class mfsPaymentTypeRepository {
  Future<List<MFSListModel>> getBusinessType() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.mfsPaymentType, {}, headers);

    print('payment type: ${response}');

    return List.from(
        response.map((item) => MFSListModel.fromJson(item)));
  }


  Future getCardCharge(acc_no, amount) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.getWithHeader(
        "${ApiClient.getCardCharge}$acc_no/$amount", headers);

    print('get card charge: ${response}');

    return response;
  }

  Future <GetMbankingGatewayModel>  getMFSGateWayList() async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.cashInGateWay, {}, headers);

    print('payment type mfs cash in : ${response}');

    return GetMbankingGatewayModel.fromJson(response);
  }






  // mfs list end
  Future<List<MFSPaymentTypeModel>> getPaymentType(int type) async {
    print('++++++++++++++ hlw bro ++++++++');
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.mfsPaymentOPTION, {"payment_method_id": type.toString()}, headers);

    print('payment type hlw bro ++++++++: ${response}');

    return List.from(
        response["data"]["payment_options"].map((item) => MFSPaymentTypeModel.fromJson(item)));
  }
  Future<List<BankkPaymentTypeModel>> getBankPaymentType(int type) async {
    print('++++++++++++++ hlw bro ++++++++');
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.mfsPaymentOPTION, {"payment_method_id": type.toString()}, headers);

    print('payment type hlw bro ++++++++: ${response}');

    return List.from(
        response["data"]["payment_options"].map((item) => BankkPaymentTypeModel.fromJson(item)));
  }
  Future<List<BankChargeListModel>> getBankChargeList(int type) async {
    print('++++++++++++++ hlw bro ++++++++');
    String token = Get.find<AuthService>().currentUser.value.token!;

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.mfsPaymentOPTION, {"payment_method_id": type.toString()}, headers);

    print('payment type hlw bro ++++++++: ${response}');

    return List.from(
        response["data"]["charge_list"].map((item) => BankChargeListModel.fromJson(item)));
  }
  Future getPaymentCollectionUrl(
    String amount,
    String gateway,
  ) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    // print(amount);

    Map paymentCollectionData = {
      'amount': amount,
      'cust_name': Get.find<AuthService>().currentUser.value.customerName ?? '',
      'cust_phone':
          Get.find<AuthService>().currentUser.value.mobileNumber ?? '',
      'cust_email': '',
      'description': 'Add Balance',
      'gateway': gateway,
    };

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.balanceAddpaymentURL, paymentCollectionData, headers);

    print('payment collection url: ${response}');
    return response;
  }


  // New function
  Future getPaymentCollectionUrlProceed(
      {String? amount, String? paymentMethodId, String? paymentOptionId}) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    // print(amount);

    Map paymentCollectionData = {
      'payment_method_id': paymentMethodId,
      'payment_option_id': paymentOptionId,
      'mobile': Get.find<AuthService>().currentUser.value.mobileNumber ?? '',
      'amount': amount,
      'invoice_id': DateTime.now().millisecond.toString() + Get.find<AuthService>().currentUser.value.mobileNumber!,
      'recon_url': "abc.com",
    };

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.paymentProceedWithRequest, paymentCollectionData, headers);

    print('payment collection url: ${response}');
    return response;
  }


  Future confirmBankPay(
      {String? amount, String? paymentOptionId, String? reference, String? invoice,  String? charge}) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    // print(amount);

    Map paymentCollectionData = {
      'gateway_id': paymentOptionId,
      'amount': amount,
      'charge': charge,
      'reference': reference,
      'mobile': Get.find<AuthService>().currentUser.value.mobileNumber ?? '',
      'invoice_id': invoice,
      "recon_url": "abc.com"
    };

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.bankConfirmPay, paymentCollectionData, headers);

    print('payment collection url: ${response}');
    return response;
  }
  Future getCollectionDetails() async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    print("get collection details ++++++++++++++ working ++++++ started2");
    // print(amount);

    Map paymentCollectionData = {
      'no_of_records': "100",
    };

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.collectionDetailsUrl, paymentCollectionData, headers);

    print('payment collection url: ${response}');
    return response;
  }

  Future getAddBalanceHistory() async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    print("get collection details ++++++++++++++ working ++++++ started2");
    // print(amount);

    Map paymentCollectionData = {
      'no_of_records': "1000",
    };

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.getAddBalanceHistory, paymentCollectionData, headers);

    print('payment collection url: ${response}');
    return response;
  }
}
