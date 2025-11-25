import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latest_payplus_agent/app/models/buysell/customer_model.dart';
import 'package:latest_payplus_agent/app/repositories/balance_check_repository.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/service/shared_pref.dart';

import 'settings_service.dart';

class AuthService extends GetxService {
  final currentUser = CustomerModel().obs;
  late GetStorage _box;
  final used = false.obs;
  final newAccessToken = ''.obs;
  final alreadyLogged = false.obs;

  AuthService() {
    _box = GetStorage();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    _box = GetStorage();
    getLogged();
    getUsed();
    getCurrentUser();
    super.onInit();
  }

  void updateToken(String newToken) async {
    // Update the current model in memory
    currentUser.update((user) {
      user?.token = newToken;
    });

    // Save the updated model back to GetStorage
    _box.write('current_user', currentUser.value.toJson());
  }

  void setUser(CustomerModel customer) async {
    _box.write('current_user', customer.toJson());

    getCurrentUser();
  }

  void setFirstUseOrNot() async {
    _box.write('used', true);
    getUsed();
  }

  void setFirstLoggedOrNot() async {
    _box.write('alreadyLogged', true);
    getUsed();
  }

  getLogged() {
    if (_box.hasData('alreadyLogged')) {
      alreadyLogged.value = _box.read('alreadyLogged');
    }
  }

  Future getUsed() async {
    if (_box.hasData('used')) {
      used.value = await _box.read('used');
    }
  }

  Future getCurrentUser() async {
    if (_box.hasData('current_user')) {
      currentUser.value =
          CustomerModel.fromJson(await _box.read('current_user'));
    }
    print('customer data: ${currentUser.value.customerName}');
  }

  logOutApi(removeLoggedIn) async {
    BalanceCheckRepository().logOut().then((resp) {
      print("log out $resp");
      removeCurrentUser(removeLoggedIn);
    });
  }

  Future removeCurrentUser(removeLoggedIn) async {
    currentUser.value = CustomerModel();
    if(removeLoggedIn == true){
      await _box.remove('alreadyLogged');
    }

    await _box.remove('current_user');

    Get.toNamed(Routes.SPLASHSCREEN);
  }

  bool get isAuth => currentUser.value.token == null ? false : true;

  refreshToken() async {
    print("refresh token 23435656");
    BalanceCheckRepository().refreshToken().then((resp) {
      if (resp['code'] == 200) {
        print("refresh token $resp");
        newAccessToken.value = resp['access_token'];
        print("new access token is ${newAccessToken.value}");

        updateToken(newAccessToken.value);
      } else if (resp['message'] == 'Invalid or expired refresh token' ||
          resp['message'] == 'Invalid Token.') {
        SharedPreff.to.prefss.remove("logindate");
        logOutApi(false);
      }
    });
  }
}
