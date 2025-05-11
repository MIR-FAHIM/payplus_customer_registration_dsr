class CustomerModel {
  String? message;
  String? result;
  int? id;
  String? customerName;
  String? customerCode;
  String? customerStatus;
  String? outletName;
  String? mobileNumber;
  String? image;
  String? kyc_status;
  String? requestStatus;
  var loginCurrentBalance;
  int? customerTypeId;
  int? passChngFromAppAfterLogin;
  String? token;

  CustomerModel(
      {this.message,
      this.result,
      this.id,
        this.kyc_status,
      this.customerName,
      this.customerCode,
      this.customerStatus,
      this.outletName,
      this.mobileNumber,
      this.image,
      this.requestStatus,
      this.loginCurrentBalance,
      this.customerTypeId,
      this.passChngFromAppAfterLogin,
      this.token});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result = json['result'];
    id = json['id'];
    kyc_status =json['kyc_status'];
    customerName = json['Customer_Name'];
    customerCode = json['customer_code'];
    customerStatus = json['Customer_status'];
    outletName = json['outlet_name'];
    mobileNumber = json['mobile_number'];
    image = json['image'] ?? '';
    requestStatus = json['Request_Status'];
    loginCurrentBalance = json['login_current_balance'];
    customerTypeId = json['customer_type_id'];
    passChngFromAppAfterLogin = json['pass_chng_from_app_after_login'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['result'] = this.result;
    data['id'] = this.id;
    data['Customer_Name'] = this.customerName;
    data['kyc_status'] = this.kyc_status;
    data['customer_code'] = this.customerCode;
    data['Customer_status'] = this.customerStatus;
    data['outlet_name'] = this.outletName;
    data['mobile_number'] = this.mobileNumber;
    data['image'] = this.image;
    data['Request_Status'] = this.requestStatus;
    data['login_current_balance'] = this.loginCurrentBalance;
    data['customer_type_id'] = this.customerTypeId;
    data['pass_chng_from_app_after_login'] = this.passChngFromAppAfterLogin;
    data['Token'] = this.token;
    return data;
  }
}
