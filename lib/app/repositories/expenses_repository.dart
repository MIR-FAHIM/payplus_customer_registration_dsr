import 'dart:convert';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/api_providers/api_manager.dart';
import 'package:latest_payplus_agent/app/api_providers/api_url.dart';
import 'package:latest_payplus_agent/app/models/buysell/expense_head_data.dart';
import 'package:latest_payplus_agent/app/models/buysell/expenses_details_by_head_model.dart';
import 'package:latest_payplus_agent/app/models/buysell/expenses_history_model.dart';
import 'package:latest_payplus_agent/app/services/auth_service.dart';



class ExpensesRepo {
  Future<ExpensesHistoryModel> getExpensesHistory(
      String type, String startDate, String endDate) async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(ApiClient.expensesHistory,
        jsonEncode({"type": type, "start_date": startDate, "end_date": endDate}), {
      'token': Get.find<AuthService>().currentUser.value.token!,
      'Content-Type': 'application/json'
    });

    print('Expenses History: ${response}');

    return ExpensesHistoryModel.fromJson(response);
  }

  Future<ExpensesDetailsByHeadModel> getExpensesDetailsByHead(
      String id, String type, String startDate, String endDate) async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.expensesDetailsByHead,
        jsonEncode({
          "id_expense_head": id,
          "start_date": startDate,
          "end_date": endDate,
          "type": type
        }),
        {
          'token': Get.find<AuthService>().currentUser.value.token!,
          'Content-Type': 'application/json'
        });

    print('Expenses details: ${response}');

    return ExpensesDetailsByHeadModel.fromJson(response);
  }

  Future deleteExpensesItemByHead(String id) async {
    APIManager _manager = APIManager();
    final response = await _manager
        .postAPICallWithHeader(ApiClient.expensesDelete, jsonEncode({"id": id}), {
      'token': Get.find<AuthService>().currentUser.value.token!,
      'Content-Type': 'application/json'
    });

    print('Expenses delete: ${response}');

    return response;
  }

  Future addExpenseHead(String title) async {
    APIManager _manager = APIManager();
    final response = await _manager.postAPICallWithHeader(
        ApiClient.addExpenseHead, jsonEncode({"expense_head": title}), {
      'token': Get.find<AuthService>().currentUser.value.token!,
      'Content-Type': 'application/json'
    });

    print('Expenses delete: ${response}');

    return response;
  }

  Future<ExpenseHeadModel> getExpenseHead() async {
    APIManager _manager = APIManager();
    final response = await _manager.getWithHeader(ApiClient.expenseHeadList, {
      'token': Get.find<AuthService>().currentUser.value.token!,
      'Content-Type': 'application/json'
    });

    print('Expenses delete: ${response}');

    return ExpenseHeadModel.fromJson(response);
  }

  Future addNewExpense(String headId, String expenseDate, String remark, String amunt,
      String type, var image) async {
    APIManager _manager = APIManager();
    final response = await _manager.multipartPostAPI(
        ApiClient.addNewExpenses,
        {
          'id_expense_head': headId,
          'expense_date': expenseDate,
          'remark': 'Agent',
          'amount': amunt,
          'type': type
        },
        image,
        'image',
        {
          'token': Get.find<AuthService>().currentUser.value.token!,
          'Content-Type': 'application/json'
        });

    print('Expenses add: ${response}');

    return response;
  }
}
