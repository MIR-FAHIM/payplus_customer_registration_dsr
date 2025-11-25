// To parse this JSON data, do
//
//     final getProfileInfo = getProfileInfoFromJson(jsonString);

import 'dart:convert';

GetProfileInfo getProfileInfoFromJson(String str) => GetProfileInfo.fromJson(json.decode(str));

String getProfileInfoToJson(GetProfileInfo data) => json.encode(data.toJson());

class GetProfileInfo {
  String? result;
  String? profileImageUrl;
  Data? data;

  GetProfileInfo({
     this.result,
     this.profileImageUrl,
     this.data,
  });

  factory GetProfileInfo.fromJson(Map<String, dynamic> json) => GetProfileInfo(
    result: json["result"],
    profileImageUrl: json["profile_image_url"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "profile_image_url": profileImageUrl,
    "data": data!.toJson(),
  };
}

class Data {
  String accNo;
  String mobileNo;
  double balance;
  String stockBalance;
  String dealerId;
  String customerName;
  String outletName;
  String acc_no;
  String outletAddress;
  String personalMobile;
  dynamic email;
  dynamic districtName;
  dynamic father;
  dynamic mother;
  dynamic gender;
  dynamic spouse;
  dynamic premanentAddress;
  dynamic presentAddress;
  int packageId;
  DateTime packageStartDate;
  String packageEndDate;
  String kyc_status;
  dynamic image;

  Data({
    required this.accNo,
    required this.mobileNo,
    required this.balance,
    required this.stockBalance,
    required this.acc_no,
    required this.dealerId,
    required this.customerName,
    required this.outletName,
    required this.outletAddress,
    required this.personalMobile,
    required this.email,
    required this.districtName,
    required this.father,
    required this.mother,
    required this.gender,
    required this.spouse,
    required this.premanentAddress,
    required this.presentAddress,
    required this.packageId,
    required this.packageStartDate,
    required this.packageEndDate,
    required this.kyc_status,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accNo: json["acc_no"],
    mobileNo: json["mobile_no"],
    balance: json["balance"]?.toDouble(),
    stockBalance: json["stock_balance"],
    dealerId: json["dealer_id"],
    customerName: json["customer_name"] ?? "No Data",
    outletName: json["outlet_name"] ?? "No Data",
    outletAddress: json["outlet_address"] ?? "No Data",
    personalMobile: json["personal_mobile"] ?? "No Data",
    email: json["email"],
    districtName: json["district_name"],
    father: json["father"],
    acc_no: json["acc_no"],
    mother: json["mother"],
    gender: json["gender"],
    spouse: json["spouse"],
    premanentAddress: json["premanent_address"] ?? "No Data",
    presentAddress: json["present_address"] ?? "No Data",
    kyc_status: json["kyc_status"],
    packageId: json["package_id"],
    packageStartDate:json["package_start_date"] == null ? DateTime.now(): DateTime.parse(json["package_start_date"]),
    packageEndDate: json["package_end_date"] ?? DateTime.now().toString(),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "acc_no": accNo,
    "mobile_no": mobileNo,
    "balance": balance,
    "stock_balance": stockBalance,
    "dealer_id": dealerId,
    "customer_name": customerName,
    "outlet_name": outletName,
    "outlet_address": outletAddress,
    "personal_mobile": personalMobile,
    "email": email,
    "district_name": districtName,
    "father": father,
    "mother": mother,
    "gender": gender,
    "acc_no": acc_no,
    "kyc_status": kyc_status,
    "spouse": spouse,
    "premanent_address": premanentAddress,
    "present_address": presentAddress,
    "package_id": packageId,
    "package_start_date": "${packageStartDate.year.toString().padLeft(4, '0')}-${packageStartDate.month.toString().padLeft(2, '0')}-${packageStartDate.day.toString().padLeft(2, '0')}",
    "package_end_date": packageEndDate,
    "image": image,
  };
}
