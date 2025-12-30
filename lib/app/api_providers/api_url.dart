//155 api

class ApiClient {
  static const String baseUrl = 'https://shl.com.bd/';
  static const String v3baseUrl = 'https://shl.com.bd/api/appapi/v3';
  static const String v3baseUrlNewServer = 'https://new.shl.com.bd/api/appapi/v3';
  String api_token = '';

  static const String deleteBankInfo =
      '${baseUrl}api/appapi/delete-bank-information';
  //static const String newBaseUrl = 'https://new.shl.com.bd/';
  static const String busStationList =
      "${baseUrl}api/appapi/ticketing/bus/all/station-list";
  static const String coachList =
      "${baseUrl}api/appapi/ticketing/bus/all/coach-list";
  static const String uploadNidImage = '${baseUrl}api/appapi/upload-nid-image';
  static const String createBanglaQR = '${baseUrl}api/appapi/mybanglaqr/';
  static const String updatePass = '${baseUrl}api/appapi/update-password';
  static const String updateUserAppVersion =
      '${baseUrl}api/appapi/updateAppVersion/';
  static const String seatStatus =
      "${baseUrl}api/appapi/ticketing/bus/all/seat-status";
  static const String confirmSeatBook =
      "${baseUrl}api/appapi/ticketing/bus/all/confirm-ticket-pay";
  static const String seatBook =
      "${baseUrl}api/appapi/ticketing/bus/all/book-ticket";
  static const String coachDetailsSeatLayout =
      "${baseUrl}api/appapi/ticketing/bus/all/coach-details";
  static const String login = '${baseUrl}api/ApiLogin';
  static const String v3login = '$v3baseUrl/login';
  static const String agentList = '$v3baseUrl/agent-list';
  static const String loginWithImei = '${baseUrl}api/appapi/login';
  static const String appInfo =
      'https://shl.com.bd/api/appapi/appUpdateCheck/agent/';
  // static const String registration =
  //     '${baseUrl}api/appapi/retailer-registration-new';
  static const String registration = '${baseUrl}api/appapi/agent-registration';
  static const String agentRegistrationReg =
      '$v3baseUrl/agent-registration-reg';
  //https://shl.com.bd/api/appapi/agent/v2/submitkyc'
  static const String newNIDVerify = '$v3baseUrl/agent/submitkyc';
  static const String newRegitration =
      'https://shl.com.bd/api/appapi/agent/v2/registration';
  static const String numberDuplicacyCheck =
      '${baseUrl}api/appapi/numberDuplicacyCheck';
  static const String otpSend = '${baseUrl}api/appapi/sendOTP';
  static const String updateBankInfo =
      '${baseUrl}api/appapi/update-bank-information';
  static const String verifyOTP = '${baseUrl}api/appapi/OTPVerify';
  static const String verifyOTPwithNID =
      '${baseUrl}api/appapi/check-otp-nid-dob';
  static const String advertisementBanner =
      '$v3baseUrl/advertise-images';
  static const String businessType = '${baseUrl}api/appapi/businessType';

  static const String districtType = '${baseUrl}api/appapi/districts2';
  static const String cityType = '${baseUrl}api/appapi/location/data/getCity';

  static const String areaType = '${baseUrl}api/appapi/location/data/getArea';

  static const String zoneType = '${baseUrl}api/appapi/location/data/getZone';

  static const String thanaUrlType = '${baseUrl}api/appapi/upazilas2';

  static const String unionUrlType = '${baseUrl}api/appapi/unions2';

  static const String operators = '${baseUrl}api/appapi/operator-list';

  static const String registartionPaymentinfo =
      '${baseUrl}api/appapi/online-registration-information';

  //static const String recharge = '${baseUrl}api/appapi/rechargetest';

  static const String hotline = '${baseUrl}api/appapi/hotline-information';
  static const String packages = '${baseUrl}api/appapi/offer-list-post';
  static const String rechargeReport = '$v3baseUrl/reschargeHistory';
  static const String cashbackOffer = '${baseUrl}api/appapi/cashback-offer';
  static const String robiairtelOffer = '${baseUrl}api/appapi/getRechargeOffer';
  static const String getProfileInfo = '$v3baseUrl/getProfileInfo';

  static const String amountOffer = '${baseUrl}api/appapi/offer-list-all/';

  static const String duplicateNIDCheck =
      '${baseUrl}api/appapi/check-duplicate-nid';
  static const String checkPayment =
      '${baseUrl}api/appapi/online-registration-information';
//https://shl.com.bd/api/appapi/online-registration-information'
  static const String forgetPassword = '${baseUrl}api/appapi/save-new-password';

  static const String commisionCheck = '$v3baseUrl/commission-check';
  static const String rechargeRobiAirtel =
      '${baseUrl}api/appapi/offer-recharge/recahrge';

  static const String deviceToken = '${baseUrl}api/appapi/registerFcmToken/';
  static const String sendCustomerCheck =
      '$v3baseUrl/update-customer-information';

  static const String notifications = '$v3baseUrl/myNotifications';
  static const String allnotifications =
      '${baseUrl}api/appapi/get-all-notification';
  static const String account_statement = '$v3baseUrl/agent-transaction-report';
  static const String account_statement_summery =
      '$v3baseUrl/agent-transaction-summary';
  static const String transactionType =
      '${baseUrl}api/appapi/transaction-type-list';

  static const String transactionReport =
      '$v3baseUrl/transaction-report';

  static const String paymentCollectionHistory =
      '${baseUrl}api/appapi/payment-collection-history';

  static const String dashboardData = '$v3baseUrl/dashboard-information';

  static const String bankList = '${baseUrl}api/appapi/bank-list/';

  static const String bankInfoSave =
      '${baseUrl}api/appapi/save-bank-information';

  static const String getBankInformation =
      '${baseUrl}api/appapi/get-bank-information';

  static const String withdrawMoneyApi = '$v3baseUrl/withdraw-request';

  static const String paymentCollectionUrl = '$v3baseUrl/payment-collection';

  static const String regPaymentUrl =
      '${baseUrl}api/appapi/online-registration-fee-collection';
  //add balance
  static const String mfsPaymentType = '$v3baseUrl/payment-method-list';
  static const String cashInGateWay = '$v3baseUrl/mbanking/cashin-gateway-list';
  static const String mfsPaymentOPTION =
      '${baseUrl}api/appapi/payment-collection/payment-option';

  static const String rtnBankList = '${baseUrl}api/appapi/bankListRTN';
  static const String transactionVerifyPaymentMethod =
      '${baseUrl}api/appapi/payment-method-list';

  static const String paymentProceedWithRequest =
      '${baseUrl}api/appapi/payment-collection/proceed-with-request';

  static const String divisionUrl = '${baseUrl}api/appapi/divisions';

  static const String districtUrl = '${baseUrl}api/appapi/districts';

  static const String thanaUrl = '${baseUrl}api/appapi/upazilas';

  static const String unionUrl = '${baseUrl}api/appapi/unions';
  static const String appSettingController =
      '${baseUrl}api/appapi/mobileAppSettings';
  static const String appFeaturePermissionOnCustomer =
      '$v3baseUrl/checkDisabledServiceCustomer';

  static const String saveInfo =
      '${baseUrl}api/appapi/save-account-information';

  static const String deactivateAccount = '${baseUrl}api/appapi/delete-account';



  static const String dailyReportold = '${baseUrl}api/appapi/daily-report';



  static const String favouriteBiller =
      '$v3baseUrl/get-favourite-biller';

  static const String getBusReportPur =
      '${baseUrl}api/appapi/bus-ticket-history';

  static const String deleteFavouriteBiller =
      '$v3baseUrl/remove-favourite-biller';

  static const String serviceFee =
      '${baseUrl}api/appapi/preview/service-fee-types';
  static const String categories =
      '${baseUrl}public/api/appapi/getData/bs_cat/1/0';
  static const String addProduct = '${baseUrl}public/api/appapi/addEditItem';

  static const String subCategories = '${baseUrl}public/api/appapi/subCats/';

  static const String getDonationProjectList =
      'http://10.0.2.2:8000/api/getDonationProject';
  static const String shopinfo = '${baseUrl}public/api/appapi/shopInfo';
  static const String updateshopinfo =
      '${baseUrl}public/api/appapi/addEditShop/';

  static const String division = '${baseUrl}public/api/appapi/divisions';

  static const String district = '${baseUrl}public/api/appapi/districts';

  static const String upazila = '${baseUrl}public/api/appapi/upazilas';

  static const String transactionVerify =
      '${baseUrl}api/appapi/transactionVeifyByTrxId';

  static const String getCardCharge = '${baseUrl}api/appapi/queryForCharge/';

  static const String cashin = '$v3baseUrl/mbanking/cashin';
  static const String checkRocketTransaction =
      '$v3baseUrlNewServer/rocketcashinout/checkStatus';
  static const String cashinRocket =
      '$v3baseUrlNewServer/mbanking/cashin';

  static const String cashoutRocket =
      '$v3baseUrlNewServer/mbanking/cashout';

  // Buy Sell
  static const String productByBarcode = '${baseUrl}public/api/appapi/itemList';

  static const String salePlaceOrder = '${baseUrl}public/api/appapi/sell';

  static const String buyPlaceOrder = '${baseUrl}public/api/appapi/buy';

  static const String expensesHistory =
      '${baseUrl}public/api/appapi/expenseGroupBy';

  static const String expensesDetailsByHead =
      '${baseUrl}public/api/appapi/expenseHistory';

  static const String expensesDelete =
      '${baseUrl}public/api/appapi/deleteExpense';

  static const String addNewExpenses = '${baseUrl}public/api/appapi/addExpense';

  static const String addExpenseHead =
      '${baseUrl}public/api/appapi/addExpenseHead';

  static const String expenseHeadList =
      '${baseUrl}public/api/appapi/getData/bs_expense_head';

  static const String buysellReport = '${baseUrl}public/api/appapi/todaysInfo';

  static const String customerlist =
      '${baseUrl}api/appapi/getData/bs_customer/1/0';
  static const String vendorlist = '${baseUrl}api/appapi/getData/bs_vendor';

  static const String addCustomer =
      '${baseUrl}public/api/appapi/addEditCustomer';

  static const String addVendor = '${baseUrl}public/api/appapi/addEditVendor';

  static const String productList = '${baseUrl}public/api/appapi/itemList';
  // package https://shl.com.bd/api/appapi/agent/v2/packages

  static const String getPopUpImageNotification =
      '${baseUrl}api/appapi/notification/getInAppNotif/';

  static const String specialOfferRecharge =
      '${baseUrl}api/appapi/getRechargeOfferTeleService?operator_id=1&number=01782084390';

  static const String rechargeToSpecialOffer =
      '${baseUrl}api/appapi/offer-recharge/recahrge/test';

  // all v3 api is here _______________________________ v3 __________
  static const String billPayCommon =
      '$v3baseUrl/billpay/pay/app-bill-payment-common';

  static const String buyPackage = '$v3baseUrl/agent/package/purchase';
  static const String packageList = '$v3baseUrl/agent/packages';
  static const String currentPackage = '$v3baseUrl/agent/packages/mypackage';
  static const String moneyTransfer = '$v3baseUrl/mbanking/money-transfer';
  static const String mobilebankHistory =
      '$v3baseUrl/mbanking/transaction-history';
  static const String getBillerType = '$v3baseUrl/billpay/bill-type';

  static const String getCommision = '$v3baseUrl/mbanking/commission-preview';
  static const String cashInTest = '$v3baseUrl/mbanking/cashin';

  static const String cashout = '$v3baseUrl/mbanking/cashout';
  static const String billHistory = '$v3baseUrl/billpay/bill-payment-history';

  static const String billDetails = '$v3baseUrl/billpay/bill-payment-receipt';
  static const String collectionDetailsUrl =
      '$v3baseUrl/payment-collection/collection-details';
  static const String getAddBalanceHistory = '$v3baseUrl/add-balance-history';
  static const String bankConfirmPay =
      '${baseUrl}api/appapi/payment-collection/confirm-payment';

  static const String getPermissionData = '$v3baseUrl/checkDisabledService';

  static const String balanceCheck =
      '$v3baseUrl/balanceCheckByAccNoOrPhoneForDsr';
  static const String accountInfo = '$v3baseUrl/account-information';
  static const String refreshToken = '$v3baseUrl/refresh-token';
  static const String recharge = '$v3baseUrl/recharge';
  static const String dailyReport =
      '${baseUrl}api/appapi/accountStatementRetailer';
  static const String v3logOut = '$v3baseUrl/logout';
  static const String balanceAddpaymentURL = '$v3baseUrl/payment-collection';
  static const String pinChange = '$v3baseUrl/pin-change';
  static const String rechargeTest = '$v3baseUrl/rechargetest';

  static const String changeNotificationStatus =
      '$v3baseUrl/myNotifications/changeStatus';
}
