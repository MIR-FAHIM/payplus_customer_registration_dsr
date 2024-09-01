//155 api

class ApiClient {
  String api_token = '';
  
  static const String changeNotificationStatus =
      '${baseUrl}api/appapi/myNotifications/changeStatus';
  static const String deleteBankInfo = '${baseUrl}api/appapi/delete-bank-information';

  static const String baseUrl = 'https://shl.com.bd/';
  //static const String newBaseUrl = 'https://new.shl.com.bd/';
  static const String busStationList =
      "${baseUrl}api/appapi/ticketing/bus/all/station-list";
  static const String coachList =
      "${baseUrl}api/appapi/ticketing/bus/all/coach-list";
  static const String seatStatus =
      "${baseUrl}api/appapi/ticketing/bus/all/seat-status";
  static const String confirmSeatBook =
      "${baseUrl}api/appapi/ticketing/bus/all/confirm-ticket-pay";
  static const String seatBook =
      "${baseUrl}api/appapi/ticketing/bus/all/book-ticket";
  static const String coachDetailsSeatLayout =
      "${baseUrl}api/appapi/ticketing/bus/all/coach-details";
  static const String login = '${baseUrl}api/ApiLogin';

  static const String loginWithImei = '${baseUrl}api/appapi/login';
  static const String appInfo =
      'https://shl.com.bd/api/appapi/appUpdateCheck/agent/';
  // static const String registration =
  //     '${baseUrl}api/appapi/retailer-registration-new';

  static const String registration = '${baseUrl}api/appapi/agent-registration';
  static const String agentRegistrationReg = '${baseUrl}api/appapi/agent-registration-reg';
  //https://shl.com.bd/api/appapi/agent/v2/submitkyc'
  static const String newNIDVerify = '${baseUrl}api/appapi/agent/v2/submitkyc';

  static const String newRegitration =
      'https://shl.com.bd/api/appapi/agent/v2/registration';
  static const String numberDuplicacyCheck =
      '${baseUrl}api/appapi/numberDuplicacyCheck';


  static const String otpSend = '${baseUrl}api/appapi/sendOTP';
  static const String updateBankInfo = '${baseUrl}api/appapi/update-bank-information';

  static const String verifyOTP = '${baseUrl}api/appapi/OTPVerify';

  static const String verifyOTPwithNID =
      '${baseUrl}api/appapi/check-otp-nid-dob';

  static const String advertisementBanner =
      '${baseUrl}api/appapi/advertise-images';

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

  // static const String nidVerification =
  //     'https://api.porichoybd.com/api/Kyc/test-nid-person-values';

  // static const String nidVerification =
  // 'https://api.porichoybd.com/api/Kyc/test-nid-person-values';

  static const String balanceCheck =
      '${baseUrl}api/appapi/balanceCheckByAccNoOrPhoneForDsr';
  static const String recharge = '${baseUrl}api/appapi/recharge';
  static const String hotline = '${baseUrl}api/appapi/hotline-information';
  static const String packages = '${baseUrl}api/appapi/offer-list-post';
  static const String rechargeReport = '${baseUrl}api/appapi/reschargeHistory';
  static const String cashbackOffer = '${baseUrl}api/appapi/cashback-offer';
  static const String robiairtelOffer =
      '${baseUrl}api/appapi/getRechargeOffer';
  static const String getProfileInfo = '${baseUrl}api/appapi/getProfileInfo';
  static const String getPermissionData =
      '${baseUrl}api/appapi/checkDisabledService';
  static const String amountOffer = '${baseUrl}api/appapi/offer-list-all/';
  static const String pinChange = '${baseUrl}api/appapi/pin-change';
  static const String duplicateNIDCheck =
      '${baseUrl}api/appapi/check-duplicate-nid';
  static const String checkPayment =
      '${baseUrl}api/appapi/online-registration-information';
//https://shl.com.bd/api/appapi/online-registration-information'
  static const String forgetPassword = '${baseUrl}api/appapi/save-new-password';

  static const String commisionCheck = '${baseUrl}api/appapi/commission-check';
  static const String rechargeRobiAirtel =
      '${baseUrl}api/appapi/offer-recharge/recahrge';

  static const String deviceToken = '${baseUrl}api/appapi/registerFcmToken/';

  static const String notifications = '${baseUrl}api/appapi/myNotifications';
  static const String allnotifications =
      '${baseUrl}api/appapi/get-all-notification';

  static const String account_statement =
      '${baseUrl}api/appapi/agent-transaction-report';
  static const String account_statement_summery =
      '${baseUrl}api/appapi/agent-transaction-summary';
  static const String transactionType =
      '${baseUrl}api/appapi/transaction-type-list';

  static const String transactionReport =
      '${baseUrl}api/appapi/transaction-report';

  static const String paymentCollectionHistory =
      '${baseUrl}api/appapi/payment-collection-history';

  static const String dashboardData =
      '${baseUrl}api/appapi/dashboard-information';

  static const String bankList = '${baseUrl}api/appapi/bank-list/';

  static const String bankInfoSave =
      '${baseUrl}api/appapi/save-bank-information';

  static const String getBankInformation =
      '${baseUrl}api/appapi/get-bank-information';

  static const String withdrawMoneyApi =
      '${baseUrl}api/appapi/withdraw-request';

  static const String paymentCollectionUrl =
      '${baseUrl}api/appapi/payment-collection';

  static const String regPaymentUrl =
      '${baseUrl}api/appapi/online-registration-fee-collection';
  //add balance
  static const String mfsPaymentType =
      '${baseUrl}api/appapi/payment-method-list';
  static const String cashInGateWay =
      '${baseUrl}api/appapi/mbanking/cashin-gateway-list';
  static const String mfsPaymentOPTION =
      '${baseUrl}api/appapi/payment-collection/payment-option';
  static const String transactionVerifyPaymentMethod =
      '${baseUrl}api/appapi/payment-method-list';
  static const String balanceAddpaymentURL =
      '${baseUrl}api/appapi/payment-collection';
  static const String paymentProceedWithRequest =
      '${baseUrl}api/appapi/payment-collection/proceed-with-request';
  static const String collectionDetailsUrl =
      '${baseUrl}api/appapi/payment-collection/collection-details';
  static const String getAddBalanceHistory =
      '${baseUrl}api/appapi/add-balance-history';
  static const String bankConfirmPay =
      '${baseUrl}api/appapi/payment-collection/confirm-payment';

  static const String divisionUrl = '${baseUrl}api/appapi/divisions';

  static const String districtUrl = '${baseUrl}api/appapi/districts';

  static const String thanaUrl = '${baseUrl}api/appapi/upazilas';

  static const String unionUrl = '${baseUrl}api/appapi/unions';

  static const String saveInfo =
      '${baseUrl}api/appapi/save-account-information';

  static const String deactivateAccount = '${baseUrl}api/appapi/delete-account';

  static const String accountInfo = '${baseUrl}api/appapi/account-information';

  static const String dailyReportold = '${baseUrl}api/appapi/daily-report';

  static const String dailyReport =
      '${baseUrl}api/appapi/accountStatementRetailer';

  static const String favouriteBiller =
      '${baseUrl}api/appapi/get-favourite-biller';

  static const String getBusReportPur =
      '${baseUrl}api/appapi/bus-ticket-history';

  static const String deleteFavouriteBiller =
      '${baseUrl}api/appapi/remove-favourite-biller';

  static const String serviceFee =
      '${baseUrl}api/appapi/preview/service-fee-types';

  static const String customerlist =
      '${baseUrl}api/appapi/getData/bs_customer/1/0';
  static const String vendorlist = '${baseUrl}api/appapi/getData/bs_vendor';

  static const String addCustomer =
      '${baseUrl}public/api/appapi/addEditCustomer';

  static const String addVendor = '${baseUrl}public/api/appapi/addEditVendor';

  static const String productList = '${baseUrl}public/api/appapi/itemList';
  // package https://shl.com.bd/api/appapi/agent/v2/packages
  static const String packageList = '${baseUrl}api/appapi/agent/v2/packages';
  static const String currentPackage =
      '${baseUrl}api/appapi/agent/v2/packages/mypackage';
  static const String getPopUpImageNotification =
      '${baseUrl}api/appapi/notification/getInAppNotif/';
  static const String buyPackage =
      '${baseUrl}api/appapi/agent/v2/package/purchase';

  static const String categories =
      '${baseUrl}public/api/appapi/getData/bs_cat/1/0';
  static const String addProduct = '${baseUrl}public/api/appapi/addEditItem';

  static const String subCategories = '${baseUrl}public/api/appapi/subCats/';

  static const String getDonationProjectList = 'http://10.0.2.2:8000/api/getDonationProject';
  static const String shopinfo = '${baseUrl}public/api/appapi/shopInfo';
  static const String updateshopinfo =
      '${baseUrl}public/api/appapi/addEditShop/';

  static const String division = '${baseUrl}public/api/appapi/divisions';

  static const String district = '${baseUrl}public/api/appapi/districts';

  static const String upazila = '${baseUrl}public/api/appapi/upazilas';

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

  static const String transactionVerify =
      '${baseUrl}api/appapi/transactionVeifyByTrxId';

  static const String billHistory =
      '${baseUrl}api/appapi/billpay/bill-payment-history';

  static const String billDetails =
      '${baseUrl}api/appapi/billpay/bill-payment-receipt';

  static const String getCardCharge =
      '${baseUrl}api/appapi/queryForCharge/';

  static const String cashin = '${baseUrl}api/appapi/mbanking/cashin';
  static const String checkRocketTransaction = 'https://new.shl.com.bd/api/appapi/rocketcashinout/checkStatus';
  static const String cashinRocket = 'https://new.shl.com.bd/api/appapi/mbanking/cashin';
  static const String getCommision = '${baseUrl}api/appapi/mbanking/commission-preview';
  static const String cashInTest = '${baseUrl}/api/appapi/mbanking/cashin';

  static const String cashout = '${baseUrl}api/appapi/mbanking/cashout';
  static const String cashoutRocket = 'https://new.shl.com.bd/api/appapi/mbanking/cashout';
  static const String moneyTransfer =
      '${baseUrl}api/appapi/mbanking/money-transfer';
  static const String mobilebankHistory =
      '${baseUrl}api/appapi/mbanking/transaction-history';
}
