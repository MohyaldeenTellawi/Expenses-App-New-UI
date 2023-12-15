import 'package:expenses_app/core/utils/constant.dart';
import 'package:expenses_app/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../model/expenses_model.dart';
import '../widgets/add_new_item.dart';
import '../widgets/cahrt/chart.dart';
import '../widgets/expenses_item.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  List<ExpensesModel> expensesList = [];

  void _addExpenses(ExpensesModel expenses) {
    setState(() {
      expensesList.add(expenses);
    });
  }

  void _removeExpense(ExpensesModel expenses) {
    setState(() {
      expensesList.remove(expenses);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(() {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0)
          ),
            isScrollControlled: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            useSafeArea: true,
            context: context,
            builder: (context) {
              return AddNewItem(
                onAddExpense: _addExpenses,
              );
            });
      }),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .3, 
          child: Chart(expenses: expensesList)),
          expensesList.isEmpty
              ? Expanded(
                  child: Image.asset(
                    noExpense,
                    width: MediaQuery.of(context).size.width * .6, 
                    height: MediaQuery.of(context).size.height * .6, 
                  ),
                )
              : Expanded(
                  child: AspectRatio(
                    aspectRatio: 4 / 1.5,
                    child: ListView.builder(
                      padding:  EdgeInsetsDirectional.only(top:  MediaQuery.of(context).size.height * .001),
                      itemCount: expensesList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            onUpdate: (details) {},
                            onDismissed: (direction) {
                              _removeExpense(expensesList[index]);
                            },
                            key: ValueKey(expensesList[index]),
                            child: ExpensesItem(expenses: expensesList[index]));
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  AppBar homeAppBar(void Function() onPressed) {
    return AppBar(
      title: Text(
        'My Expenses',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25,
            color: myColorScheme.onPrimary),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: MediaQuery.of(context).size.width * .05),
          style: ButtonStyle(
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              iconSize: const MaterialStatePropertyAll(30),
              foregroundColor:
                  MaterialStatePropertyAll(myColorScheme.onPrimary)),
          onPressed: onPressed,
          icon: const Icon(FontAwesomeIcons.plus),
        )
      ],
    );
  }
}
