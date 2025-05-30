// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String? status;
  DataPro? data;

  ProfileModel({
    this.status,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        data: DataPro.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class DataPro {
  String? customerName;
  String? outlet_name;
  String? nid;
  String? email;
  String? personalMobile;
  String? nidFront;
  String? nidBack;
  String? tradeFront;
  String? orgImage;
  String? tradeBack;
  String? tradeLicenseNum;
  int? divisionId;
  int? districtId;
  int? thanaId;
  int? unionId;
  String? wordNo;
  String? premanent;
  String? present;
  String? businessType;
  String? tradeExpireDate;
  int? kyc;
  int? allowUtility;
  int? allowRecharge;
  int? allowCollection;

  DataPro({
    this.customerName,
    this.nid,
    this.email,
    this.orgImage,
    this.outlet_name,
    this.personalMobile,
    this.divisionId,
    this.districtId,
    this.thanaId,
    this.unionId,
    this.wordNo,
    this.premanent,
    this.present,
    this.businessType,
    this.kyc,
    this.allowUtility,
    this.allowRecharge,
    this.allowCollection,
    this.tradeExpireDate,
    this.tradeLicenseNum,
    this.nidFront,
    this.nidBack,
    this.tradeFront,
    this.tradeBack,
  });

  factory DataPro.fromJson(Map<String, dynamic> json) => DataPro(
        customerName: json["customer_name"],
    outlet_name: json["outlet_name"],
    orgImage: json["org_image"],
        nid: json["nid"] ?? "No Data",
        email: json["email"] ?? "No Data",
        personalMobile: json["personal_mobile"] ?? "No Data",
        divisionId: json["division_id"],
        districtId: json["district_id"],
        thanaId: json["thana_id"],
        unionId: json["union_id"],
        wordNo: json["word_no"] ?? "No Data",
        premanent: json["premanent"] ?? "No Data",
        present: json["present"] ?? "No Data",
        businessType: json["business_type"] ?? "No Data",
        kyc: json["kyc"],
        allowUtility: json["allow_utility"],
        allowRecharge: json["allow_recharge"],
        allowCollection: json["allow_collection"],
        tradeExpireDate: json["trade_license_expire_date"] ?? "No Data",
        tradeLicenseNum: json["trade_license_number"] ?? "No Data",
        nidFront: json["nid_image"],
        nidBack: json["nid_back"],
        tradeFront: json["trade_license"],
        tradeBack: json["trade_license2"],
      );

  Map<String, dynamic> toJson() => {
        "customer_name": customerName,
        "outlet_name": outlet_name,
        "nid": nid,
        "org_image": orgImage,
        "email": email,
        "personal_mobile": personalMobile,
        "division_id": divisionId,
        "district_id": districtId,
        "thana_id": thanaId,
        "union_id": unionId,
        "word_no": wordNo,
        "premanent": premanent,
        "present": present,
        "business_type": businessType,
        "kyc": kyc,
        "allow_utility": allowUtility,
        "allow_recharge": allowRecharge,
        "allow_collection": allowCollection,
        "trade_license_expire_date": tradeExpireDate,
        "trade_license_number": tradeLicenseNum,
        "nid_image": nidFront,
        "nid_back": nidBack,
        "trade_license": tradeFront,
        "trade_license2": tradeBack,
      };
}
