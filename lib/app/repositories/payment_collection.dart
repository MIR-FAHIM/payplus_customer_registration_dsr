import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';

class PaymentCollectionRepository {
  Future getPaymentCollectionUrl(
    String amount,
    String name,
    String phone,
    String email,
    String desc,
  ) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    print(token);

    Map paymentCollectionData = {
      'amount': amount,
      'cust_name': name,
      'cust_phone': phone,
      'cust_email': email,
      'description': desc
    };

    var headers = {'token': token};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.paymentCollectionUrl, paymentCollectionData, headers);

    print('payment collection url: ${response}');
    return response;
  }


  Future createBanglaQR() async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    String customerCode = Get.find<AuthService>().currentUser.value.customerCode!;




    print('createBanglaQR res___customer code__________: ${customerCode}');


    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
      "${ApiClient.createBanglaQR}$customerCode",{}, {'token': token} ,
    );

    print('createBanglaQR res_____________: ${response}');
    return response;
  }
}
