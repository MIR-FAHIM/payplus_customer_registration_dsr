import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';

class NumberCheckRepository {
  Future checkNumberDuplicacy(String mobileNumber) async {
    Map number = {'number': '$mobileNumber'};

    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICall(ApiClient.numberDuplicacyCheck, number);

    print('user checkNumberDuplicacy: ${response['message']}');
    return response;
  }


  Future paymentCheck(String mbl) async {
    print(mbl);
    Map nidData = {'number': mbl};

    APIManager _manager = APIManager();
    final response = await _manager.postAPICall(ApiClient.checkPayment, nidData);

    print('user nid check: ${response}');
    return response;
  }
}
