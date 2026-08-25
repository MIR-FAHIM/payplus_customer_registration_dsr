import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/address/get_area_model.dart';
import 'package:latest_payplus_agent/app/models/address/get_city_model.dart';
import 'package:latest_payplus_agent/app/models/district_model.dart';
import 'package:latest_payplus_agent/app/models/thana_model.dart';
import 'package:latest_payplus_agent/app/models/union_model.dart';

import '../models/address/get_zone_model.dart';

class DivisionDistrictsRepository {
  Future<List<DistrictModel>> getdistrictType() async {
    // var headers = {'token': 'mCSBThHZH1tJxQJi4ifBdIDjTxFD0GBLFd6QpV1i'};
    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICallWithOutHeader(ApiClient.districtType);

    print('District: ${response}');

    return List.from(response.map((item) => DistrictModel.fromJson(item)));
  }
  Future<CityModel> getCityType() async {
    // var headers = {'token': 'mCSBThHZH1tJxQJi4ifBdIDjTxFD0GBLFd6QpV1i'};
    APIManager _manager = APIManager();
    final response =
    await _manager.postAPICallWithOutHeader(ApiClient.cityType);

    print('city: ${response}');

    return CityModel.fromJson(response);
  }
  Future<ZoneModel> getZoneType(id) async {
    // var headers = {'token': 'mCSBThHZH1tJxQJi4ifBdIDjTxFD0GBLFd6QpV1i'};
    APIManager _manager = APIManager();
    final response =
    await _manager.postAPICall(ApiClient.zoneType, {'city_id': id});

    print('zone: ${response}');

    return ZoneModel.fromJson(response);
  }
  Future<AreaModel> getAreaType(id) async {
    // var headers = {'token': 'mCSBThHZH1tJxQJi4ifBdIDjTxFD0GBLFd6QpV1i'};
    APIManager _manager = APIManager();
    final response =
    await _manager.postAPICall(ApiClient.areaType,{'zone_id': id});

    print('area: ${response}');

    return AreaModel.fromJson(response);
  }

  @override
  Future<List<ThanaModel>> getThana(dynamic id) async {
    // var headers = {'token': 'mCSBThHZH1tJxQJi4ifBdIDjTxFD0GBLFd6QpV1i'};
    Map district_id = {'district_id': id.toString()};
    APIManager _manager = APIManager();
    final response = await _manager.postAPICall(ApiClient.thanaUrlType, district_id);

    print('thana: ${response}');

    return List.from(response.map((item) => ThanaModel.fromJson(item)));
  }

  Future<List<UnionModel>> getUnion(dynamic thanaId) async {
    Map location = {'upazilla_id': thanaId};

    APIManager _manager = APIManager();
    final response =
        await _manager.postAPICall(ApiClient.unionUrlType, location);

    print('union: ${response}');
    return List.from(response.map((item) => UnionModel.fromJson(item)));
  }
}
