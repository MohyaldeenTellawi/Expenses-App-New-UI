import 'package:expenses_app/core/utils/styles.dart';

import 'package:expenses_app/main.dart';
import 'package:expenses_app/model/expenses_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expenses});

  final ExpensesModel expenses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsetsDirectional.symmetric(horizontal: MediaQuery.of(context).size.width * .01, 
      vertical: MediaQuery.of(context).size.height * .001),
      child: Card(
        child: ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .15,
                child: Text(
                  expenses.title,
                  style: style18.copyWith(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
               SizedBox(width: MediaQuery.of(context).size.width * .05),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .22,
                  child: Text(
                    expenses.shopName,
                    style: TextStyle(
                        fontSize: 15,
                        color: expenses.shopName == 'Empty!'
                            ? Colors.grey
                            : myColorScheme.onPrimaryContainer),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )),
            ],
          ),
          subtitle: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              currencyIcons[expenses.currency],
              color: myColorScheme.onPrimaryContainer,
              size: 13,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * .01),
            Text(
              '${expenses.amount}',
              style:
                  style18.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
            )
          ]),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.calendar,
                    color: myColorScheme.onPrimaryContainer,
                  ),
                    SizedBox(width: MediaQuery.of(context).size.width * .01),
                  Text(
                    expenses.formattedDate,
                    style: TextStyle(color: myColorScheme.onPrimaryContainer),
                  ),
                ],
              ),
            ],
          ),
          leading: Icon(
            categoryIcons[expenses.category],
            color: myColorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
