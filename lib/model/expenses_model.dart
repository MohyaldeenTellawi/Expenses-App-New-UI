import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final dataTime = DateFormat.yMd();

enum Category { food, travel, work, clothes }

enum Currency { $, tl, eur, sp }

Map categoryIcons = {
  Category.food: FontAwesomeIcons.burger,
  Category.travel: FontAwesomeIcons.plane,
  Category.work: FontAwesomeIcons.briefcase,
  Category.clothes: FontAwesomeIcons.shirt,
};

Map currencyIcons = {
  Currency.$: FontAwesomeIcons.dollarSign,
  Currency.tl: FontAwesomeIcons.turkishLiraSign,
  Currency.eur: FontAwesomeIcons.euroSign,
  Currency.sp: FontAwesomeIcons.s,
};

class ExpensesModel {
  final String id;
  final String title;
  final String shopName;
  final double amount;
  final DateTime date;
  final Category category;
  final Currency currency;

  String get formattedDate {
    return dataTime.format(date);
  }

  ExpensesModel({
    required this.title,
    required this.shopName,
    required this.amount,
    required this.category,
    required this.currency,
    required this.date,
  }) : id = uuid.v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'shopName': shopName,
      'amount': amount,
      'date': formattedDate,
      'category': category,
      'currency': currency,
    };
  }

  factory ExpensesModel.fromJson(Map<String, dynamic> json) {
    return ExpensesModel(
      title: json['title'],
      shopName: json['shopName'],
      amount: json['amount'],
      date: DateFormat('yyyy-MM-dd').parse(json['date']),
      category: jsonDecode(json['category']),
      currency: jsonDecode(json['currency']),
    );
  }
}

class ExpensesBucknet {
  final Category category;
  final List<ExpensesModel> expenses;

  ExpensesBucknet.forCategory(
      {required this.category, required List<ExpensesModel> allExpenses})
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
