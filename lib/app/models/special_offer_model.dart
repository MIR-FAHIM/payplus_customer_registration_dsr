// To parse this JSON data, do
//
//     final specialOfferModel = specialOfferModelFromJson(jsonString);

import 'dart:convert';

SpecialOfferModel specialOfferModelFromJson(String str) => SpecialOfferModel.fromJson(json.decode(str));

String specialOfferModelToJson(SpecialOfferModel data) => json.encode(data.toJson());

class SpecialOfferModel {
  String? status;
  String? sessionContext;
  String? simNumber;
  Data? data;

  SpecialOfferModel({
     this.status,
     this.sessionContext,
     this.simNumber,
     this.data,
  });

  factory SpecialOfferModel.fromJson(Map<String, dynamic> json) => SpecialOfferModel(
    status: json["status"],
    sessionContext: json["sessionContext"],
    simNumber: json["sim_number"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "sessionContext": sessionContext,
    "sim_number": simNumber,
    "data": data!.toJson(),
  };
}

class Data {
  List<Combo>? dataOffer;
  List<Combo>? minute;
  List<Combo>? combo;

  Data({
     this.dataOffer,
     this.minute,
     this.combo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dataOffer: List<Combo>.from(json["DATA"].map((x) => Combo.fromJson(x))),
    minute: List<Combo>.from(json["MINUTE"].map((x) => Combo.fromJson(x))),
    combo: List<Combo>.from(json["COMBO"].map((x) => Combo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "DATA": List<dynamic>.from(dataOffer!.map((x) => x.toJson())),
    "MINUTE": List<dynamic>.from(minute!.map((x) => x.toJson())),
    "COMBO": List<dynamic>.from(combo!.map((x) => x.toJson())),
  };
}

class Combo {
  String campaignId;
  List<OfferCategory> offerCategory;
  String offerContentType;
  String offerDescription;
  String offerDescriptionBangla;
  String offerFlag;
  String offerId;
  String offerPrice;
  String offerPriority;
  String offerValidityHours;
  String optInKeyword;
  String retailerCommission;
  SubscriberRegion subscriberRegion;
  String totalCommission;

  Combo({
    required this.campaignId,
    required this.offerCategory,
    required this.offerContentType,
    required this.offerDescription,
    required this.offerDescriptionBangla,
    required this.offerFlag,
    required this.offerId,
    required this.offerPrice,
    required this.offerPriority,
    required this.offerValidityHours,
    required this.optInKeyword,
    required this.retailerCommission,
    required this.subscriberRegion,
    required this.totalCommission,
  });

  factory Combo.fromJson(Map<String, dynamic> json) => Combo(
    campaignId: json["campaignID"],
    offerCategory: List<OfferCategory>.from(json["offerCategory"].map((x) => offerCategoryValues.map[x]!)),
    offerContentType: json["offerContentType"],
    offerDescription: json["offerDescription"],
    offerDescriptionBangla: json["offerDescriptionBangla"],
    offerFlag: json["offerFlag"],
    offerId: json["offerId"],
    offerPrice: json["offerPrice"],
    offerPriority: json["offerPriority"],
    offerValidityHours: json["offerValidityHours"],
    optInKeyword: json["optInKeyword"],
    retailerCommission: json["retailerCommission"],
    subscriberRegion: subscriberRegionValues.map[json["subscriberRegion"]]!,
    totalCommission: json["totalCommission"],
  );

  Map<String, dynamic> toJson() => {
    "campaignID": campaignId,
    "offerCategory": List<dynamic>.from(offerCategory.map((x) => offerCategoryValues.reverse[x])),
    "offerContentType": offerContentType,
    "offerDescription": offerDescription,
    "offerDescriptionBangla": offerDescriptionBangla,
    "offerFlag": offerFlag,
    "offerId": offerId,
    "offerPrice": offerPrice,
    "offerPriority": offerPriority,
    "offerValidityHours": offerValidityHours,
    "optInKeyword": optInKeyword,
    "retailerCommission": retailerCommission,
    "subscriberRegion": subscriberRegionValues.reverse[subscriberRegion],
    "totalCommission": totalCommission,
  };
}

enum OfferCategory {
  AIPL_COCKPIT_RECO,
  BKASH_MY_OFFER,
  MY_OFFERS,
  POWER_LOAD,
  VOICE
}

final offerCategoryValues = EnumValues({
  "AIPLCockpitRECO": OfferCategory.AIPL_COCKPIT_RECO,
  "BkashMyOffer": OfferCategory.BKASH_MY_OFFER,
  "MyOffers": OfferCategory.MY_OFFERS,
  "PowerLoad": OfferCategory.POWER_LOAD,
  "Voice": OfferCategory.VOICE
});

enum SubscriberRegion {
  DHAKA_CENTRAL
}

final subscriberRegionValues = EnumValues({
  "DHAKA CENTRAL": SubscriberRegion.DHAKA_CENTRAL
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
