import 'package:get/get.dart';
import 'package:intl/intl.dart';
//import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:latest_payplus_agent/app/models/account_statement_model.dart';
import 'package:latest_payplus_agent/app/models/account_statement_summery_model.dart';
import 'package:latest_payplus_agent/app/models/notification_model.dart';
import 'package:latest_payplus_agent/app/models/transaction_report_model.dart';
import 'package:latest_payplus_agent/app/models/transaction_type_model.dart';
import 'package:latest_payplus_agent/app/modules/account_statement/widgets/statement_summery_widget.dart';
import 'package:latest_payplus_agent/app/modules/account_statement/widgets/statement_widget.dart';
import 'package:latest_payplus_agent/app/modules/account_statement/widgets/transactions_widget.dart';
import 'package:latest_payplus_agent/app/repositories/notification_repository.dart';

class AccountStatementController extends GetxController {
  //TODO: Implement InboxController

  final selectedIndex = 0.obs;
  final notifications = NotificationModel().obs;

  final accountStatement = AccountStatementModel().obs;

  final accountStatementSummery = AccountStatemenSummerytModel().obs;

  final notificationLoaded = false.obs;

  final accountStatementLoaded = false.obs;

  final transactionType = <TransactionTypeModel>[].obs;
  final statementSummaryList = <StatementData>[].obs;
  final statementList = <DataStatement>[].obs;
  final transactionLoaded = false.obs;

  final transactionReport = <TransactionReportModel>{}.obs;
  final transactionReportLoaded = false.obs;

  final selectedType = 0.obs;

  final dateSelect = ''.obs;

  // DateTime? selectedDate;
  var initialDate = DateTime.now().obs;
  var selectedDate = DateTime.now().obs;

  final pages = [StatementWidget(), StatementSummeryWidget(),].obs;
  @override
  Future<void> onInit() async {
    await getAccountStatement();
    await getAccountStatementSummery();
    selectedDate.value = initialDate.value;
    // await getTransactionReport();
    super.onInit();
  }

  var myFormat = DateFormat('yyyy-MM');

  selectMonth(context) {
    // showMonthPicker(
    //   context: context,
    //   firstDate: DateTime(DateTime.now().year - 1, 5),
    //   lastDate: DateTime(DateTime.now().year + 1, 9),
    //   initialDate: selectedDate.value,
    //   // locale: Locale("en"),
    // ).then((date) {
    //   if (date != null) {
    //     selectedDate.value = date;
    //     String monthName = "${myFormat.format(selectedDate.value)}";
    //
    //     getAccountStatementSummeryWithMonthFilter(monthName);
    //   }
    // });
  }

  // getNotifications() async {
  //   notificationLoaded.value = false;
  //   NotificationRepository().getNotifications().then((resp) {
  //     if (resp.result == 'success') {
  //       notifications.value = resp;
  //     }
  //     notificationLoaded.value = true;
  //   });
  // }

  getAccountStatement() async {
    accountStatementLoaded.value = false;
    NotificationRepository().getAccountStatement().then((resp) {
      if (resp.result == 'success') {
        print("my account statement is ${resp.result!.length.toString()}");
        accountStatement.value = resp;
        statementList.value = resp.data!;
      }
      accountStatementLoaded.value = true;
    });
  }

  getAccountStatementSummery() async {
    String monthInitial = "${myFormat.format(initialDate.value)}";

    print('initial month : $monthInitial');
    notificationLoaded.value = false;
    NotificationRepository()
        .getAccountStatementSummery(monthInitial)
        .then((resp) {
      if (resp.result == 'success') {
        accountStatementSummery.value = resp;
        statementSummaryList.value =resp.data!;
      }
      notificationLoaded.value = true;
    });
  }

  getAccountStatementSummeryWithMonthFilter(String month) async {
    print(month);

    notificationLoaded.value = false;
    NotificationRepository()
        .getAccountStatementSummeryWithMonth(month)
        .then((resp) {
      if (resp.result == 'success') {
        accountStatementSummery.value = resp;
      }
      notificationLoaded.value = true;
    });
  }

  // getTransactionTypes() async {
  //   transactionLoaded.value = false;
  //   NotificationRepository().gettransactionType().then((resp) {
  //     transactionType.value = resp;
  //     transactionLoaded.value = true;
  //   });
  // }

  // getTransactionReport(
  //     {String type = '0', String from = '0', String to = '0'}) async {
  //   transactionReportLoaded.value = false;
  //   NotificationRepository()
  //       .gettransactionReport(type: type, from: from, to: to)
  //       .then((resp) {
  //     transactionReport.value = resp;
  //     print('tesssssssssssss : $resp');
  //     transactionReportLoaded.value = true;
  //   });
  // }
}
