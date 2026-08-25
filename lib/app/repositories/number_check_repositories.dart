import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';

class NumberCheckRepository {
  Future checkNumberDuplicacy(String mobileNumber) async {
    Map number = {'number': '$mobileNumber'};

    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICallWithHeader(ApiClient.numberDuplicacyCheck, number, {'remark': 'DSR'});

    print('user checkNumberDuplicacy: ${response['message']}');
    return response;
  }

  Future checkNumberDuplicacyForRegister(String mobileNumber, String remark) async {
    Map number = {'number': '$mobileNumber'};

    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICallWithHeader(ApiClient.numberDuplicacyCheckForRegister, number, {'remark': remark});

    print('user checkNumberDuplicacy: ${response['message']}');
    return response;
  }
Future checkPgwEmail(String email) async {
    Map emailData = {'email': '$email'};

    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICall(ApiClient.checkPgwEmail, emailData);

    print('user checkPgwEmail: ${response['message']}');
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
