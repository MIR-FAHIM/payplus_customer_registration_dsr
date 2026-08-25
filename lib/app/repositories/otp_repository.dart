import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';

class OTPRepository {
  Future otpSend(String mobileNumber) async {
    print("my mobile no bro $mobileNumber");
    Map number = {
      'number': '$mobileNumber',
      "remark": "DSR",
    };

    var headers = {
      'token':
          'UO49RKyqyc8ePi013wPnPMKrVOL0W6z9r5q4DjRRmX5g08RluPWCgzj8mSInYldXN9TjjeCsr04SRXlL1XOzzInjdzoX2SySyd9S'
    };

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.otpSend, number, headers);
    print('user number: $response');

    print('user number: ${response['message']}');
    return response;
  }

  Future verifyOTP(String mobileNumber, String otp) async {
    Map number = {'number': '$mobileNumber', 'input_value': otp};

    var headers = {
      'token':
          'UO49RKyqyc8ePi013wPnPMKrVOL0W6z9r5q4DjRRmX5g08RluPWCgzj8mSInYldXN9TjjeCsr04SRXlL1XOzzInjdzoX2SySyd9S'
    };

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.verifyOTP, number, headers);

    print('user number: ${response['message']}');
    return response;
  }

  Future verifyOTPWithNID(
      String mobileNumber, String otp, String nidNumber, String dob) async {
    Map data = {
      'number': '$mobileNumber',
      'otp': otp,
      'nid': nidNumber,
      'dob': dob,
    };

    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICall(ApiClient.verifyOTPwithNID, data);

    // print('user number: ${response['message']}');
    return response;
  }
}
