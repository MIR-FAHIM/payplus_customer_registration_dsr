import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/buysell/customer_model.dart';
import 'package:latest_payplus_agent/app/models/nid_data_model.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';

class AuthRepository {
  final userdata = GetStorage();

  ///User Registration api call
  Future userRegistration(Map data) async {
    print(data);

    APIManager _manager = APIManager();
    final _response = await _manager.postAPICall(ApiClient.registration, data);

    print('user registration: ${_response['Status']}');

    return _response;
  }

  // new registrationApi

  Future newNIDVerify(Map data) async {
    print(data);

    APIManager _manager = APIManager();
     String token = Get.find<AuthService>().currentUser.value.token!;
    var headers = {
      'token': token,
      'X-Device-IMEI': Get.find<LocationService>().imei.value
    };
    final _response = await _manager.postAPICallWithHeader(
        ApiClient.newNIDVerify,
        data,
        headers);

    print('user registration: ${_response['Status']}');

    return _response;
  }

  Future newUserRegistration(Map data) async {
    print(data);

    APIManager _manager = APIManager();
    final _response =
        await _manager.postAPICall(ApiClient.newRegitration, data);

    print('user registration: ${_response['Status']}');

    return _response;
  }

  // end new registration

  ///nid verification
  ///

  Future<NIDDataModel> nidVerification(String nid, String dob) async {
    NIDDataModel nidData = NIDDataModel();
    print('nid:$nid');
    print('dob:$dob');
    Map userData = {"national_id": nid, "team_tx_id": "", "person_dob": dob};

    var headers = {
      'x-api-key': 'cabc420e-5348-4566-9b43-8ef5921886bc',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('https://api.porichoybd.com/api/v2/verifications/autofill'));
    request.body =
        '''{\r\n  "nidNumber": "$nid",\r\n  "englishTranslation": true,\r\n  "dateOfBirth": "$dob"\r\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      nidData = NIDDataModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      print(response.reasonPhrase);
    }

    return nidData;
  }

  ///duplicate nid check
  Future duplicateNIDCheck(String nid) async {
    print(nid);
    Map nidData = {'nid': nid};

    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICall(ApiClient.duplicateNIDCheck, nidData);

    print('user nid check: ${response}');
    return response;
  }

  ///User login api call
  userLogin(String phoneNumber, String pass, String imei) async {
    Map _loginData = {
      'mobile': phoneNumber,
      'password': '$pass',
      'type': '7',
      'imei': '$imei',
      'remark': 'Agent'
    };

    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICall(ApiClient.loginWithImei, _loginData);

    print('user login: ${response}');

    return response;
  }

  customerCheck(String phoneName, String model, String lat, String lon, String token, String cusCode) async {
print("i am here $phoneName $model $lat ");

print("i am here $token ");
    APIManager _manager = APIManager();
    try{
      final response =
      await _manager.postAPICallWithHeader(ApiClient.sendCustomerCheck,
          {
           "acc_no" : cusCode,
            "phone_model":"Device:$phoneName model: $model" ,
                "customer_latitude":lat,
            "customer_longitude":lon
          },
          {
            "token":token
          });

      print('user check: ${response}');
      return response;
    }catch(e){
      print("error is $e");
    }



  }

  ///pin chnage

  Future pinChange(String oldPin, String newPin) async {
    String token = Get.find<AuthService>().currentUser.value.token!;
    Map pinData = {
      'old_pin': oldPin,
      'new_pin': newPin,
    };

    var headers = {'token': token};

    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.pinChange, pinData, headers);

    print('user pin: ${response}');
    return response;
  }

//Forget Password
  Future forgetPassword(String newPassword, String mobileNum) async {
    //var imei = userdata.read('imeiNumber');
    var imei = Get.find<LocationService>().imei.value;

    print(imei);
    print("mobile num is _______12 $mobileNum");
    Map pinData = {
      'number': mobileNum,
      'new_password': newPassword,
      'imei': imei,
    };

    // var headers = {'token': token};

    APIManager _manager = APIManager();
    final response =
    await _manager.postAPICall(ApiClient.forgetPassword, pinData);

    print('user pin: ${response}');
    return response;
  }

  Future sendDeviceToken(String customer_code, String deviceToken) async {
    APIManager _manager = APIManager();
    final response = await _manager
        .get(ApiClient.deviceToken + '$customer_code/$deviceToken');

    print('device token resp: ${response}');

    return response;
  }


  @override
  Future nidUploadWithoutPass(userModel) async {
    APIManager _apiManagerInterface = APIManager();
    final _response = await _apiManagerInterface.postAPICall(ApiClient.uploadNidImage, userModel);

    print('nid upload : ${_response['Status']}');
    return _response;
  }
  Future updatePass(userModel) async {
    APIManager _apiManagerInterface = APIManager();
    final _response = await _apiManagerInterface.postAPICall(ApiClient.updatePass, userModel);

    print('nid upload : ${_response['Status']}');
    return _response;
  }
}
