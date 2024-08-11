import 'dart:convert';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/add_product_model.dart';
import 'package:latest_payplus_agent/app/models/barcode_product_model.dart';
import 'package:latest_payplus_agent/app/models/buy_model.dart';
import 'package:latest_payplus_agent/app/models/categoriesmodel.dart';
import 'package:latest_payplus_agent/app/models/customerlistmodel.dart';
import 'package:latest_payplus_agent/app/models/notification/popup_image_notification.dart';
import 'package:latest_payplus_agent/app/models/package%20model/package_list_model.dart';
import 'package:latest_payplus_agent/app/models/product_model.dart';
import 'package:latest_payplus_agent/app/models/sell_model.dart';
import 'package:latest_payplus_agent/app/models/shop_info_model.dart';
import 'package:latest_payplus_agent/app/models/vendorlistmodel.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';

import '../models/package model/my_current_package_model.dart';

class BuySellRepository {
  Future addCustomer(String name, String phone, String address) async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(ApiClient.addCustomer,
        jsonEncode({"name": name, "mobile": phone, "address": address}), {
      'token': '${Get.find<AuthService>().currentUser.value.token}',
      'Content-Type': 'application/json'
    });

    print('customer list: ${response}');
    return response;
  }

  Future<CustomerListModel> getCustomer() async {
    APIManager _manager = APIManager();
    final response = await _manager.getWithHeader(ApiClient.customerlist,
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('customer list: ${response}');
    return CustomerListModel.fromJson(response);
  }

  Future<VendorListModel> getVendor() async {
    APIManager _manager = APIManager();
    final response = await _manager.getWithHeader(ApiClient.vendorlist,
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('customer list: ${response}');
    return VendorListModel.fromJson(response);
  }

  Future addVendor(String name, String phone, String address) async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(ApiClient.addVendor,
        jsonEncode({"name": name, "mobile": phone, "address": address}), {
      'token': '${Get.find<AuthService>().currentUser.value.token}',
      'Content-Type': 'application/json'
    });

    print('customer list: ${response}');
    return response;
  }
  Future<PackageListModel> getPackages() async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(ApiClient.packageList, {},
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('package list: ${response}');
    return PackageListModel.fromJson(response);
  }
  Future<CurrentPackageModel> currentPackage() async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(ApiClient.currentPackage, {},
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('package list: ${response}');
    return CurrentPackageModel.fromJson(response);
  }


  Future<PopUpImageNotificarionModel> getPopUpImageNotification() async {
    APIManager _manager = APIManager();
    final response = await _manager.get("${ApiClient.getPopUpImageNotification}${Get.find<AuthService>().currentUser.value.customerCode.toString()}/Agent",);

    print('notification image popup list: ${response}');
    return PopUpImageNotificarionModel.fromJson(response);
  }



    Future buyPackage(id, pin, packageId, gateway) async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(ApiClient.buyPackage,
        {
          "package_id" : id.toString(),
          "pin": pin,
          "package_purchase" : packageId,
          "gateway": gateway,
        },
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('package list: ${response}');
    return response;
  }
  Future<ProductModel> getProducts() async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(ApiClient.productList, {},
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('product list: ${response}');
    return ProductModel.fromJson(response);
  }

  Future<ProductModel> getProductByBarcode(String barcode) async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.productByBarcode,
        json.encode({"barcode": barcode}),
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('barcode product: ${response}');
    return ProductModel.fromJson(response);
  }

  Future<CategoriesModel> getCategories() async {
    APIManager _manager = APIManager();
    final response = await _manager.getWithHeader(ApiClient.categories,
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('cat list: ${response}');
    return CategoriesModel.fromJson(response);
  }

  Future<SubCategoriesModel> getSubCategories(String id) async {
    APIManager _manager = APIManager();
    final response = await _manager.getWithHeader(ApiClient.subCategories + id,
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('sub cat list: ${response}');
    return SubCategoriesModel.fromJson(response);
  }

  Future getDonationProjectList() async {
    APIManager _manager = APIManager();
    final response = await _manager.get(ApiClient.getDonationProjectList);

    print('donation project list: ${response}');
    return response;
  }

  Future<ShopInfoModel> getShopInfo() async {
    APIManager _manager = APIManager();
    final response = await _manager.getWithHeader(ApiClient.shopinfo,
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('shopinfo: ${response}');
    return ShopInfoModel.fromJson(response);
  }

  Future getDivision() async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(ApiClient.division, {},
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('div list: ${response}');
    return response;
  }

  Future getDistrict(String divisionId) async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.district,
        {"division_id": divisionId},
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('div list: ${response}');
    return response;
  }

  Future getUpazila(String districtId) async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.upazila,
        {"district_id": districtId},
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('div list: ${response}');
    return response;
  }

  Future updateShop(
    String id,
    String name,
    String address,
    String div,
    String dist,
    String upazila,
    String postal,
  ) async {
    APIManager _manager = APIManager();
    final response = await _manager.multipartPostAPI(
        ApiClient.updateshopinfo + id,
        {
          'shop_name': name,
          'address': address,
          'division_id': div,
          'district_id': dist,
          'upazila_id': upazila,
          'post_code': postal
        },
        [],
        '',
        {
          'token': '${Get.find<AuthService>().currentUser.value.token}',
        });

    print('shop list: ${response}');
    return response;
  }

  Future addProduct(AddProductModel product, List image) async {
    APIManager _manager = APIManager();
    final response = await _manager
        .multipartPostAPI(ApiClient.addProduct, product.toJson().cast(), image, 'image', {
      'token': '${Get.find<AuthService>().currentUser.value.token}',
    });

    print('shop list: ${response}');
    return response;
  }

  Future salePlaceOrder(SellModel sellModel) async {
    APIManager _manager = APIManager();
    final response = await _manager
        .postAPICallWithHeader(ApiClient.salePlaceOrder, jsonEncode(sellModel.toJson()), {
      'token': '${Get.find<AuthService>().currentUser.value.token}',
      'Content-Type': 'application/json'
    });

    print('sale order: ${response}');
    return response;
  }

  Future buyPlaceOrder(BuyModel sellModel) async {
    APIManager _manager = APIManager();
    final response = await _manager
        .postAPICallWithHeader(ApiClient.buyPlaceOrder, jsonEncode(sellModel.toJson()), {
      'token': '${Get.find<AuthService>().currentUser.value.token}',
      'Content-Type': 'application/json'
    });

    print('sale order: ${response}');
    return response;
  }

  Future getBuySellReport() async {
    APIManager _manager = APIManager();
    final response = await _manager.getWithHeader(ApiClient.buysellReport,
        {'token': '${Get.find<AuthService>().currentUser.value.token}'});

    print('buysell list: ${response}');
    return response;
  }


  // test

  Future getAllCompany() async {
    APIManager _manager = APIManager();
    final response = await _manager.get("http://192.168.10.209:8000/api/v1/companies/",);

    print('company list: ${response}');
    return response;
  }

}
