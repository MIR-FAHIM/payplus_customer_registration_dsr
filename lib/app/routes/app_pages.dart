import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/Page/termandcondition.dart';
import 'package:latest_payplus_agent/app/modules/Auth/checkPhoneNumber/views/check_phone_number_view.dart';
import 'package:latest_payplus_agent/app/modules/Auth/register_by_password/add_password.dart';
import 'package:latest_payplus_agent/app/modules/Auth/register_by_password/nid_info_reg.dart';
import 'package:latest_payplus_agent/app/modules/Auth/register_by_password/nid_upload_reg.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/views/new_regiater_page.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/views/new_register/name_field.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/views/new_register/password_field.dart';
import 'package:latest_payplus_agent/app/modules/Sales/Buy/add_new_product.dart';

import 'package:latest_payplus_agent/app/modules/Sales/expense/add_new_expense.dart';

import 'package:latest_payplus_agent/app/modules/account_statement/views/statement_details.dart';
import 'package:latest_payplus_agent/app/modules/account_statement/views/statement_view1.dart';
import 'package:latest_payplus_agent/app/modules/add_balance/views/collection_details.dart';
import 'package:latest_payplus_agent/app/modules/add_balance/views/mfs_list_view.dart';
import 'package:latest_payplus_agent/app/modules/add_balance/views/rtn_bank_list.dart';
import 'package:latest_payplus_agent/app/modules/add_balance/views/scan_card.dart';
import 'package:latest_payplus_agent/app/modules/add_balance/views/success_page_add_balance.dart';
import 'package:latest_payplus_agent/app/modules/add_balance/widgets/visa_master_list.dart';
import 'package:latest_payplus_agent/app/modules/bank_information/views/change_bank_info.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/akash/akash_form.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/akash/akash_view.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/electricity/Nesco/nesco_form.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/electricity/Nesco/nesco_postpaid_view.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/electricity/bpdb/bpdb_prepaid_bill_view.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/electricity/bpdb/bpdb_prepaid_form_view.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/electricity/reb/reb_post_bill_view.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/electricity/reb/reb_post_form.dart';
import 'package:latest_payplus_agent/app/modules/bill_payment/views/failed_page.dart';
import 'package:latest_payplus_agent/app/modules/collectorApp/view/home_page_c.dart';
import 'package:latest_payplus_agent/app/modules/daily_report/views/report_analytic.dart';
import 'package:latest_payplus_agent/app/modules/demo/task_dashboard.dart';
import 'package:latest_payplus_agent/app/modules/donation/home/binding/donation_home_binding.dart';
import 'package:latest_payplus_agent/app/modules/donation/home/view/donation_home.dart';
import 'package:latest_payplus_agent/app/modules/eTicket/bus_ticket/bindings/bus_ticket_binding.dart';
import 'package:latest_payplus_agent/app/modules/eTicket/bus_ticket/views/bus_report_view.dart';
import 'package:latest_payplus_agent/app/modules/eTicket/bus_ticket/views/bus_ticket_view.dart';

import 'package:latest_payplus_agent/app/modules/home/views/profile/profile_view.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/views/cash_in_out_view_tab.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/views/failed_page.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/views/m_banking_pin_view.dart';
import 'package:latest_payplus_agent/app/modules/mobile_banking/views/succes_page.dart';
import 'package:latest_payplus_agent/app/modules/notifications/notification_view_details.dart';
import 'package:latest_payplus_agent/app/modules/offer/views/add_payer.dart';
import 'package:latest_payplus_agent/app/modules/offer/views/payer_view.dart';
import 'package:latest_payplus_agent/app/modules/offer/views/user_type.dart';
import 'package:latest_payplus_agent/app/modules/package/view/pay_now_option.dart';
import 'package:latest_payplus_agent/app/modules/package/view/mfs_list_for_package.dart';
//import 'package:latest_payplus_agent/app/modules/recharge/views/muti_recharge_success_view.dart';
import 'package:latest_payplus_agent/app/modules/recharge/views/robi_offer_success.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/robiAirtelOfferList.dart';
import 'package:latest_payplus_agent/app/modules/recharge/widgets/text_field_pin_code_dialog.dart';
import 'package:latest_payplus_agent/app/modules/Sales/sms/bindings/sms_bindings.dart';
import 'package:latest_payplus_agent/app/modules/Sales/sms/view/sms_view.dart';
import 'package:latest_payplus_agent/app/modules/withdraw/views/change_account_view.dart';
import '../Page/Transaction_successful.dart';
import '../Page/fast_sale_view.dart';
import '../Page/sale_payment_system.dart';
import '../modules/Auth/change_password/bindings/change_password_binding.dart';
import '../modules/Auth/change_password/views/change_password_view.dart';
import '../modules/Auth/checkPhoneNumber/bindings/check_phone_number_binding.dart';
import '../modules/Auth/login/bindings/login_binding.dart';
import '../modules/Auth/login/views/login_view.dart';
import '../modules/Auth/phoneVerificationWtihOTP/bindings/phone_verification_wtih_o_t_p_binding.dart';
import '../modules/Auth/phoneVerificationWtihOTP/views/phone_verification_wtih_o_t_p_view.dart';
import '../modules/Auth/signup/bindings/signup_binding.dart';
import '../modules/Auth/signup/views/new_register/address_field.dart';
import '../modules/Auth/signup/views/new_register/nid_input_field.dart';
import '../modules/Auth/signup/views/new_register/nid_verification.dart';
import '../modules/Auth/signup/views/signup_view.dart';
import '../modules/Auth/signup/views/start_after_registration.dart';

import '../modules/Sales/Due/due_dashboard.dart';
import '../modules/Sales/bindings/sales_binding.dart';
import '../modules/Sales/views/sales_view.dart';
import '../modules/Signup_webview/bindings/signup_webview_binding.dart';
import '../modules/Signup_webview/views/signup_webview_view.dart';
import '../modules/account_setting/bindings/account_setting_binding.dart';
import '../modules/account_setting/views/account_setting_view.dart';
import '../modules/account_setting/views/deactivate_account_pin.dart';
import '../modules/account_setting/views/deactivate_account_view.dart';
import '../modules/account_statement/bindings/statement_binding.dart';
import '../modules/account_statement/views/statement_view.dart';
import '../modules/add_balance/bindings/add_balance_binding.dart';
import '../modules/add_balance/views/add_balance_dashboard_view.dart';
import '../modules/add_balance/views/add_balance_form_view.dart';
import '../modules/add_balance/views/confirm_bank_payment.dart';

import '../modules/bank_information/bindings/bank_information_binding.dart';
import '../modules/bank_information/views/bank_information_view.dart';
import '../modules/bank_information/views/mobile_bank_info.dart';
import '../modules/bill_details/bindings/bill_details_binding.dart';
import '../modules/bill_details/views/bill_details_view.dart';
import '../modules/bill_payment/bindings/bill_payment_binding.dart';
import '../modules/bill_payment/views/Water/dhaka_wasa_form_view.dart';
import '../modules/bill_payment/views/akash/binding/akash_payment_binding.dart';
import '../modules/bill_payment/views/bill_payment_view.dart';
import '../modules/bill_payment/views/biller_list.dart';
import '../modules/bill_payment/views/biller_list_gas.dart';
import '../modules/bill_payment/views/biller_list_water.dart';
import '../modules/bill_payment/views/electricity/WestZone_Postpaid/westzone_postpaid_bill_view.dart';
import '../modules/bill_payment/views/electricity/WestZone_Postpaid/westzone_postpaid_form_view.dart';
import '../modules/bill_payment/views/electricity/desco-prepaid/desco_prepaid_bill_view.dart';
import '../modules/bill_payment/views/electricity/desco_postpaid_bill_view.dart';
import '../modules/bill_payment/views/electricity/desco_postpaid_form_view.dart';
import '../modules/bill_payment/views/electricity/desco-prepaid/desco_prepaid_form_view.dart';
import '../modules/bill_payment/views/electricity/dpdc_postpaid_bill_view.dart';
import '../modules/bill_payment/views/electricity/dpdc_postpaid_form_view.dart';
import '../modules/billpay_report/bindings/billpay_report_binding.dart';
import '../modules/billpay_report/views/billpay_report_view.dart';

import '../modules/current_due/bindings/current_due_binding.dart';
import '../modules/current_due/views/current_due_view.dart';

import '../modules/daily_report/bindings/daily_report_binding.dart';
import '../modules/daily_report/views/daily_report_view.dart';
import '../modules/Sales/due_report/bindings/due_report_binding.dart';
import '../modules/Sales/due_report/views/due_report_view.dart';
import '../modules/eTicket/bindings/e_ticket_binding.dart';
import '../modules/eTicket/views/e_ticket_view.dart';

import '../modules/Sales/expenses_details_by_head/bindings/expenses_details_by_head_binding.dart';
import '../modules/Sales/expenses_details_by_head/views/expenses_details_by_head_view.dart';

import '../modules/Sales/fast_sales_details/bindings/fast_sales_details_binding.dart';
import '../modules/Sales/fast_sales_details/views/fast_sales_details_view.dart';
import '../modules/forgetPassWtihOTP/bindings/forget_pass_o_t_p_binding.dart';
import '../modules/forgetPassWtihOTP/views/forget_pass_wtih_o_t_p_view.dart';
import '../modules/forget_password_new/bindings/forget_password_binding.dart';
import '../modules/forget_password_new/views/forget_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hotline/bindings/hotline_binding.dart';
import '../modules/hotline/views/hotline_view.dart';
import '../modules/inbox/bindings/inbox_binding.dart';
import '../modules/inbox/views/inbox_view.dart';
import '../modules/mobile_Bank_cashin/bindings/mobile_bank_cashin_binding.dart';
import '../modules/mobile_Bank_cashin/views/mobile_bank_cashin_view.dart';
import '../modules/mobile_Bank_cashout/bindings/mobile_bank_cashout_binding.dart';
import '../modules/mobile_Bank_cashout/views/mobile_bank_cashout_view.dart';
import '../modules/mobile_Bank_transaction_history/bindings/mobile_bank_transaction_history_binding.dart';
import '../modules/mobile_Bank_transaction_history/views/mobile_bank_transaction_history_view.dart';
import '../modules/mobile_banking/bindings/mobile_banking_binding.dart';
import '../modules/mobile_banking/views/conatact_and_amount.dart';
import '../modules/mobile_banking/views/mobile_banking_view.dart';
import '../modules/notifications/notifications_view.dart';
import '../modules/offer/bindings/offer_binding.dart';
import '../modules/offer/views/offer_view.dart';
import '../modules/package/binding/package_binding.dart';
import '../modules/package/view/package_list_screen.dart';
import '../modules/payment_collection/bindings/payment_collection_binding.dart';
import '../modules/payment_collection/views/link_share_view.dart';
import '../modules/payment_collection/views/make_bill_for_payment.dart';
import '../modules/payment_collection/views/payment_collection_bank_selection_view.dart';
import '../modules/payment_collection/views/payment_collection_view.dart';

import '../modules/recharge/bindings/recharge_binding.dart';
import '../modules/recharge/views/pin_code_view.dart';
import '../modules/recharge/views/recharge_pin_from_notification.dart';
import '../modules/recharge/views/recharge_success.dart';
import '../modules/recharge/views/recharge_view.dart';
import '../modules/recharge_report/bindings/recharge_report_binding.dart';
import '../modules/recharge_report/views/recharge_report_view.dart';
import '../modules/recharge_report_number_check/bindings/number_check_binding.dart';
import '../modules/recharge_report_number_check/views/number_check_view.dart';
import '../modules/registration_payment/bindings/registration_payment_binding.dart';
import '../modules/registration_payment/views/registration_payment_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/Sales/sale_now/bindings/sale_now_binding.dart';
import '../modules/Sales/sale_now/views/sale_now_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/shop_info/bindings/shop_info_binding.dart';
import '../modules/shop_info/views/shop_info_view.dart';
import '../modules/signup_service_fee/bindings/signup_service_fee_binding.dart';
import '../modules/signup_service_fee/views/signup_service_fee_view.dart';
import '../modules/signup_service_fee_confirm/bindings/signup_service_fee_confirm_binding.dart';
import '../modules/signup_service_fee_confirm/views/signup_service_fee_confirm_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/transaction_charge/bindings/transaction_charge_binding.dart';
import '../modules/transaction_charge/views/transaction_charge_view.dart';
import '../modules/transaction_history/bindings/transaction_history_binding.dart';
import '../modules/transaction_history/views/transaction_history_view.dart';

import '../modules/webview/bindings/webview_binding.dart';
import '../modules/webview/views/webview_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';
import '../modules/withdraw/bindings/withdraw_binding.dart';
import '../modules/withdraw/views/bank_view.dart';
import '../modules/withdraw/views/mobile_bank_view.dart';
import '../modules/withdraw/views/successful_view.dart';
import '../modules/withdraw/views/withdraw_amount.dart';
import '../modules/withdraw/views/withdraw_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;
  // static const INITIAL = Routes.Test;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.COLLECTORHOMEPAGE,
      page: () => CollectorHomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILEVIEW,
      page: () => ProfileView(),
      binding: HomeBinding(),
    ),

    // GetPage(
    //   name: _Paths.BUS_TICKET,
    //   page: () => BusTicketView(),
    //   binding: BusTicketBinding(),
    // ),

    GetPage(
      name: _Paths.BUSREPORT,
      page: () => BusReportReportView(),
      binding: BusTicketBinding(),
    ),

    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: _Paths.DONATIONHOMEPAGE,
      page: () => DonationHomeView(),
      binding: DonationHomeBinding(),
    ),

    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.NEWNIDINPUT,
      page: () => NewNIDInputWidget(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.NEWNID,
      page: () => NewNidVerification(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.NEWSIGNUP,
      page: () => NewSignUpNameFieldView(),
      binding: SignupBinding(),
    ),
    //BuyNowPackageView
    GetPage(
      name: _Paths.BUYNOWPACKAGE,
      page: () => BuyNowPackageView(),
      binding: PackageBinding(),
    ),
    GetPage(
      name: _Paths.PACKAGELIST,
      page: () => PackageListForBuyView(),
      binding: PackageBinding(),
    ),
    GetPage(
      name: _Paths.MFSLIST,
      page: () => MFSListView(),
      binding: AddBalanceBinding(),
    ),

    GetPage(
      name: _Paths.SCANCARD,
      page: () => ScanCardView(),
      binding: AddBalanceBinding(),
    ),
    GetPage(
      name: _Paths.VISAMASLIST,
      page: () => VisaMasterListView(),
      binding: AddBalanceBinding(),
    ),
    GetPage(
      name: _Paths.PACKAGELIST,
      page: () => NewSignUpAddressFieldView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.NEWSIGNUPPASS,
      page: () => NewSignUpPassFieldView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.START_AFTER_REGISTRATION,
      page: () => StartAfterRegistrationComplete(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.Registration_Payment_View,
      page: () => RegistrationPaymentView(),
      binding: RegistrationPaymentBinding(),
    ),
    GetPage(
      name: _Paths.ROOT,
      page: () => RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    // GetPage(
    //   name: _Paths.termandCOndition,
    //   page: () => TermAndCOndition(),
    //   binding: SplashscreenBinding(),
    // ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGE,
      page: () => RechargeView(),
      binding: RechargeBinding(),
    ),
    GetPage(
      name: _Paths.REPORTANALITYC,
      page: () => DailyReportAnalyticView(),
      binding: DailyReportBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGEPIN,
      page: () => RechargePINView(),
      binding: RechargeBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGEPINNOTIFICATION,
      page: () => RechargePINViewFromNotification(),
      binding: RechargeBinding(),
    ),
    GetPage(
      name: _Paths.NOTIDETAILS,
      page: () => NotificationDetailsWidget(),
      binding: InboxBinding(),
    ),

    GetPage(
      name: _Paths.RECHARGEPINROBI,
      page: () => RechargePINViewRobiAirtel(),
      binding: RechargeBinding(),
    ),
    GetPage(
      name: _Paths.CASHINOUT,
      page: () => MobileBankingCashINOutTabView(),
      binding: MobileBankingBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGESUCCESS,
      page: () => RechargeSuccessView(),
      binding: RechargeBinding(),
    ),

    // GetPage(
    //   name: _Paths.MULTIRECHARGESUCCESS,
    //   page: () => MultiRechargeSuccessView(),
    //   binding: RechargeBinding(),
    // ),
    GetPage(
      name: _Paths.MBANKINGPIN,
      page: () => MBankingPinView(),
      binding: MobileBankingBinding(),
    ),
    GetPage(
      name: _Paths.MBANKINGNUMAMOUNT,
      page: () => MBankingNumAmount(),
      binding: MobileBankingBinding(),
    ),
    GetPage(
      name: _Paths.ROBIRECHARGESUCCESS,
      page: () => RobiRechargeSuccessView(),
      binding: RechargeBinding(),
    ),
    GetPage(
      name: _Paths.COLLECTION,
      page: () => CollectionDetailsList(),
      binding: AddBalanceBinding(),
    ),
    GetPage(
      name: _Paths.ADDBALANCESUCCESS,
      page: () => AddBalanceSuccessView(),
      binding: AddBalanceBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_COLLECTION,
      page: () => PaymentCollectionView(),
      binding: PaymentCollectionBinding(),
    ),
    GetPage(
      name: _Paths.MAKE_BILL_FOR_PAYMENT_COLLECTION,
      page: () => MakeBillPaymentCollectionView(),
      binding: PaymentCollectionBinding(),
    ),
    GetPage(
      name: _Paths.LINK_SHARE_FOR_PAYMENT_COLLECTION,
      page: () => ShareLinkPaymentCollectionView(),
      binding: PaymentCollectionBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_COLLECTION_BANK_SELECT,
      page: () => PaymentCollectionBankSelectionView(),
      binding: PaymentCollectionBinding(),
    ),
    GetPage(
      name: _Paths.Transaction_Successful,
      page: () => TransactionSuccessful(),
      binding: BillPaymentBinding(),
    ),

    GetPage(
      name: _Paths.ROBIAIRTELOFFER,
      page: () => RobiAirtelPackageWidget(),
      binding: RechargeBinding(),
    ),

    GetPage(
      name: _Paths.Add_New_Product,
      page: () => AddNewProduct(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.Add_New_Expense,
      page: () => AddNewExpense(),
      binding: SignupBinding(),
    ),
    // Westzone bill
    // bill start
    GetPage(
      name: _Paths.BILL_PAYMENT,
      page: () => BillPaymentView(),
      binding: BillPaymentBinding(),
    ),

    GetPage(
      name: _Paths.Biller_List_View,
      page: () => BillerList(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.DESCOPREPAIDDETAILS,
      page: () => DescoPrepaidBillView(),
      binding: BillPaymentBinding(),
    ),

    GetPage(
      name: _Paths.BPDBBILLVIEW,
      page: () => BPDBPrepaidBillView(),
      binding: BillPaymentBinding(),
    ),

    GetPage(
      name: _Paths.BPDBFORMVIEW,
      page: () => BPDBPrepaidFormView(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.Water_Biller_List_View,
      page: () => WaterBillerList(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.Gas_Biller_List_View,
      page: () => GasBillerList(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.Desco_Postpaid_Billview,
      page: () => DescoPostpaidBillView(),
      binding: BillPaymentBinding(),
    ),

    GetPage(
      name: _Paths.Desco_Postpaid_List_View,
      page: () => DescoPostpaidFormView(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.DPDC_Postpaid_From_View,
      page: () => DPDCPostpaidFormView(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.Desco_Prepaid_From_View,
      page: () => DescoPrepaidFormView(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.Nesco_Bill_View,
      page: () => NescoPostpaidBillView(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.nesco_From_View,
      page: () => NescoPostpaidFormView(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.akash_From_View,
      page: () => AkashFormView(),
      binding: AkashBillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.Akash_Bill_View,
      page: () => AkashBillView(),
      binding: AkashBillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.DPDC_Postpaid_Billview,
      page: () => DPDCPostpaidBillView(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.Westzone_Postpaid_From_View,
      page: () => WestZonePostpaidFormView(),
      binding: BillPaymentBinding(),
    ),

    GetPage(
      name: _Paths.Westzone_Postpaid_Bill_View,
      page: () => WestZonePostpaidBillView(),
      binding: BillPaymentBinding(),
    ),
    //REB bill
    GetPage(
      name: _Paths.Reb_Postpaid_Form_View,
      page: () => RebPostpaidFormView(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.ERRORBILL,
      page: () => ErrorViewBill(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.BILLPAY_REPORT,
      page: () => const BillpayReportView(),
      binding: BillpayReportBinding(),
    ),
    GetPage(
      name: _Paths.BILL_DETAILS,
      page: () => const BillDetailsView(),
      binding: BillDetailsBinding(),
    ),
    GetPage(
      name: _Paths.Reb_Postpaid_Bill_View,
      page: () => RebPostpaidBillView(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.Dhaka_Wasa_From_View,
      page: () => DhakaWasaFormView(),
      binding: BillPaymentBinding(),
    ),

    // bill end

    GetPage(
      name: _Paths.MBANKINGFAIL,
      page: () => MBankingFailedView(),
      binding: MobileBankingBinding(),
    ),
    GetPage(
      name: _Paths.SALES,
      page: () => SalesView(),
      binding: SalesBinding(),
    ),
    GetPage(
      name: _Paths.BANK_INFORMATION,
      page: () => BankInformationView(),
      binding: BankInformationBinding(),
    ),
    GetPage(
      name: _Paths.MOBILE_BANK_INFORMATION,
      page: () => MobileBankingInfo(),
      binding: BankInformationBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW,
      page: () => WithdrawView(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: _Paths.BANK_FOR_WITHDRAW,
      page: () => BankView(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: _Paths.MOBILE_BANK_FOR_WITHDRAW,
      page: () => MobileBankView(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_AMOUNT,
      page: () => WithdrawAmount(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_SUCCESS,
      page: () => WithdrawSuccessView(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: _Paths.INBOX,
      page: () => InboxView(),
      binding: InboxBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_HISTORY,
      page: () => InboxView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.DEACTIVATE_ACCCOUNT,
      page: () => DeActivateAccountView(),
      binding: AccountSettingBinding(),
    ),
    GetPage(
      name: _Paths.DEACTIVATE_ACCCOUNT_PIN,
      page: () => DeActivateAccountPinCode(),
      binding: AccountSettingBinding(),
    ),
    GetPage(
      name: _Paths.CHANGEACCOUNT,
      page: () => ChangeAccountView(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_BANK_INFORMATION,
      page: () => ChangeBankInformationView(),
      binding: BankInformationBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_PHONE_NUMBER,
      page: () => CheckPhoneNumberView(),
      binding: CheckPhoneNumberBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PASS_REG,
      page: () => AddPasswordReg(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.NID_INFO_REG,
      page: () => NIDInputWidgetReg(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.NID_IMAGE_UPLOAD_REG,
      page: () => NidVerificationWidgetReg(),
      binding: SignupBinding(),
    ),

    GetPage(
      name: _Paths.PHONE_VERIFICATION_WTIH_O_T_P,
      page: () => PhoneVerificationWtihOTPView(),
      binding: PhoneVerificationWtihOTPBinding(),
    ),
    GetPage(
      name: _Paths.Forget_pass_otp,
      page: () => ForgetPassWtihOTPView(),
      binding: ForgetPassWtihOTPBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.Forget_password,
      page: () => ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.HOTLINE,
      page: () => HotlineView(),
      binding: HotlineBinding(),
    ),

    GetPage(
      name: _Paths.RECHARGE_REPORT,
      page: () => RechargeReportView(),
      binding: RechargeReportBinding(),
    ),
    GetPage(
      name: _Paths.NUMBER_CHECK,
      page: () => NumberCheckView(),
      binding: NumberCheckBinding(),
    ),
    GetPage(
      name: _Paths.E_TICKET,
      page: () => ETicketView(),
      binding: ETicketBinding(),
    ),
    GetPage(
      name: _Paths.MFS_PACKAGE,
      page: () => MFSListViewPackage(),
      binding: AddBalanceBinding(),
    ),
 GetPage(
      name: _Paths.RTN_BANK_LIST,
      page: () => RtnBankListView(),
      binding: AddBalanceBinding(),
    ),

    GetPage(
      name: _Paths.STATEMENTDETAILS,
      page: () => StatementWidgetDetails(),
      binding: StatementBinding(),
    ),

    GetPage(
      name: _Paths.TRANSACTION_HISTORY,
      page: () => TransactionHistoryView(),
      binding: TransactionHistoryBinding(),
    ),
    GetPage(
      name: _Paths.WEBVIEW,
      page: () => WebviewView(),
      binding: WebviewBinding(),
    ),
    // GetPage(
    //   name: _Paths.SIGNUP_WEBVIEW,
    //   page: () => SignupWebviewView(),
    //   binding: SignupWebviewBinding(),
    // ),
    GetPage(
      name: _Paths.ACCOUNT_SETTING,
      page: () => AccountSettingView(),
      binding: AccountSettingBinding(),
    ),
    //daily report
    GetPage(
      name: _Paths.DAILY_REPORT,
      page: () => DailyReportView(),
      binding: DailyReportBinding(),
    ),
    GetPage(
      name: _Paths.TASKD,
      page: () => TaskDashboard(),
      binding: DailyReportBinding(),
    ),
    GetPage(
      name: _Paths.FAST_SALE,
      page: () => FastSaleViewScreen(),
      binding: DailyReportBinding(),
    ),
    GetPage(
      name: _Paths.SALE_PAYMENT_SYSTEM,
      page: () => SalePaymentSystem(),
      binding: DailyReportBinding(),
    ),
    GetPage(
      name: _Paths.Due_DashBoard,
      page: () => DueDashBoard(),
      binding: DailyReportBinding(),
    ),
    GetPage(
      name: _Paths.Notification_View,
      page: () => NotificationsView(),
      binding: DailyReportBinding(),
    ),
    GetPage(
      name: _Paths.Add_Balance_Dashboard_View,
      page: () => AddBalanceDashBoardView(),
      binding: AddBalanceBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_BANK_PAY,
      page: () => ConfirmBankPayView(),
      binding: AddBalanceBinding(),
    ),
    GetPage(
      name: _Paths.Add_Balance_Form_View,
      page: () => AddBalanceFormView(),
      binding: AddBalanceBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNTSTATEMENT,
      page: () => AccountStatementView(),
      binding: StatementBinding(),
    ),

    GetPage(
      name: _Paths.SHOP_INFO,
      page: () => const ShopInfoView(),
      binding: ShopInfoBinding(),
    ),

    GetPage(
      name: _Paths.CURRENT_DUE,
      page: () => const CurrentDueView(),
      binding: CurrentDueBinding(),
    ),

    GetPage(
      name: _Paths.SIGNUP_SERVICE_FEE,
      page: () => const SignupServiceFeeView(),
      binding: SignupServiceFeeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_SERVICE_FEE_CONFIRM,
      page: () => const SignupServiceFeeConfirmView(),
      binding: SignupServiceFeeConfirmBinding(),
    ),

    GetPage(
      name: _Paths.OFFER,
      page: () => const OfferView(),
      binding: OfferBinding(),
    ),
    GetPage(
      name: _Paths.ADDPAYER,
      page: () => const AddPayer(),
      binding: OfferBinding(),
    ),
    GetPage(
      name: _Paths.PAYERVIEW,
      page: () => const PayerView(),
      binding: OfferBinding(),
    ),
    GetPage(
      name: _Paths.USERTYPE,
      page: () => const UserType(),
      binding: OfferBinding(),
    ),

    GetPage(
      name: _Paths.TRANSACTION_CHARGE,
      page: () => TransactionChargeView(),
      binding: TransactionChargeBinding(),
    ),
    GetPage(
      name: _Paths.MOBILE_BANKING,
      page: () => const MobileBankingView(),
      binding: MobileBankingBinding(),
    ),

    GetPage(
      name: _Paths.MOBILE_BANK_CASHIN,
      page: () => const MobileBankCashinView(),
      binding: MobileBankCashinBinding(),
    ),
    GetPage(
      name: _Paths.MBANKINGSUCCESS,
      page: () => MBankingSuccessView(),
      binding: MobileBankingBinding(),
    ),
    GetPage(
      name: _Paths.MOBILE_BANK_CASHOUT,
      page: () => const MobileBankCashoutView(),
      binding: MobileBankCashoutBinding(),
    ),
    GetPage(
      name: _Paths.MOBILE_BANK_TRANSACTION_HISTORY,
      page: () => const MobileBankTransactionHistoryView(),
      binding: MobileBankTransactionHistoryBinding(),
    ),

//

  ];
}
