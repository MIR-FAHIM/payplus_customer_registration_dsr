// To parse this JSON data, do
//
//     final appSettingController = appSettingControllerFromJson(jsonString);

import 'dart:convert';

List<AppSettingControllerModel> appSettingControllerFromJson(String str) => List<AppSettingControllerModel>.from(json.decode(str).map((x) => AppSettingControllerModel.fromJson(x)));

String appSettingControllerToJson(List<AppSettingControllerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppSettingControllerModel {
  int? id;
  String? name;
  String? agentAppValue;
  DateTime? createdAt;
  String? merchantAppValue;

  AppSettingControllerModel({
     this.id,
     this.name,
     this.agentAppValue,
     this.createdAt,
     this.merchantAppValue,
  });

  factory AppSettingControllerModel.fromJson(Map<String, dynamic> json) => AppSettingControllerModel(
    id: json["id"],
    name: json["name"],
    agentAppValue: json["agent_app_value"],
    createdAt: DateTime.parse(json["created_at"]),
    merchantAppValue: json["merchant_app_value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "agent_app_value": agentAppValue,
    "created_at": createdAt,
    "merchant_app_value": merchantAppValue,
  };
}
