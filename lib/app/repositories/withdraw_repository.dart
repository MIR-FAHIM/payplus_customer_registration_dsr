import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';


class WithdrawRepository {
  Future withdrawMoney(String bankId, String amount, String pin) async {
    String token = Get.find<AuthService>().currentUser.value.token!;

    print(token);

    Map withdrawData = {
      'banking_id': bankId,
      'amount': amount,
      'remark':'Agent',
      'pin' : pin,
    };

    var headers = {
      'token': token,
      'X-Device-IMEI' : Get.find<LocationService>().imei.value,
    };
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(ApiClient.withdrawMoneyApi, withdrawData, headers);

    print('withdraw info: ${response}');
    return response;
  }
}
