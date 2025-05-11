import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/models/shop_info_model.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
import 'package:latest_payplus_agent/common/ui.dart';

class ShopInfoController extends GetxController {
  //TODO: Implement ShopInfoController

  final shopInfo = ShopInfoModel().obs;
  final shopInfoLoaded = false.obs;

  final divisionList = <String>[].obs;
  final divisionLoaded = false.obs;

  final districtList = [].obs;
  final districtLoaded = false.obs;

  final upazilaList = [].obs;
  final upazilaLoaded = false.obs;

  final shopname = ''.obs;
  final address = ''.obs;
  final postal = ''.obs;
  final divisionId = ''.obs;
  final districtId = ''.obs;
  final upazilaId = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getShopData();
    getDivisionData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getShopData() async {
    BuySellRepository().getShopInfo().then((response) {
      if (response.result == 'success') {
        shopInfo.value = response;
        shopname.value = shopInfo.value.shopdata!.shopName!;
        address.value = shopInfo.value.shopdata!.address!;
        postal.value = shopInfo.value.shopdata!.postCode!;
        divisionId.value = shopInfo.value.shopdata!.divisionId!.toString();
        districtId.value = shopInfo.value.shopdata!.districtId!.toString();
        upazilaId.value = shopInfo.value.shopdata!.upazilaId!.toString();
        shopInfoLoaded.value = true;
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: response.message.toString(), title: 'Error'.tr));
      }
    }).catchError(((onError) {
      throw (onError);
    }));
  }

  getDivisionData() async {
    BuySellRepository().getDivision().then((response) {
      divisionList.value = response;
      divisionLoaded.value = true;
    }).catchError(((onError) {
      throw (onError);
    }));
  }

  getDistrictData() async {
    Ui.customLoaderDialog();
    BuySellRepository().getDistrict(divisionId.value).then((response) {
      districtList.value = response;
      districtLoaded.value = true;
      Get.back();
    }).catchError(((onError) {
      throw (onError);
    }));
  }

  getUpazilaData() async {
    Ui.customLoaderDialog();
    BuySellRepository().getUpazila(districtId.value).then((response) {
      upazilaList.value = response;
      upazilaLoaded.value = true;
      Get.back();
    }).catchError(((onError) {
      throw (onError);
    }));
  }

  updateShop() async {
    Ui.customLoaderDialog();
    BuySellRepository()
        .updateShop(
            shopInfo.value.shopdata!.id!.toString(),
            shopname.value,
            address.value,
            districtId.value,
            districtId.value,
            upazilaId.value,
            postal.value)
        .then((response) {
      Get.back();
      if (response['result'] == 'success') {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: response['message'], title: 'Success'.tr));
        //getShopData();
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: response['message'], title: 'Error'.tr));
      }
    }).catchError(((onError) {
      throw (onError);
    }));
  }
}
