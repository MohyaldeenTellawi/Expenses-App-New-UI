import 'package:expenses_app/core/utils/constant.dart';
import 'package:expenses_app/core/utils/styles.dart';
import 'package:expenses_app/main.dart';
import 'package:expenses_app/screens/home_screen/manager/localization_bloc.dart';
import 'package:expenses_app/screens/home_screen/manager/localization_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../generated/l10n.dart';
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
          SizedBox(
              height: MediaQuery.of(context).size.height * .3,
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
                      padding: EdgeInsetsDirectional.only(
                          top: MediaQuery.of(context).size.height * .001),
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
          S.of(context).title,
          style: style25.copyWith(
              color: myColorScheme.onPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 10,
            shadowColor: myColorScheme.onPrimary,
            icon: const Icon(FontAwesomeIcons.ellipsisVertical),
            color: myColorScheme.onPrimaryContainer,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: TextButton.icon(
                    style: ButtonStyle(
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        foregroundColor:
                            MaterialStatePropertyAll(myColorScheme.onPrimary)),
                    onPressed: onPressed,
                    icon: const Icon(FontAwesomeIcons.plus),
                    label: Text(S.of(context).add),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    style: ButtonStyle(
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        foregroundColor:
                            MaterialStatePropertyAll(myColorScheme.onPrimary)),
                    onPressed: () {
                      if (isArabic()) {
                        context
                            .read<LocalizationBloc>()
                            .add(const ChaneLocalization(Locale('en')));
                      } else {
                        context
                            .read<LocalizationBloc>()
                            .add(const ChaneLocalization(Locale('ar')));
                      }
                      Navigator.pop(context);
                    },
                    icon: const Icon(FontAwesomeIcons.globe),
                    label: Text(S.of(context).lan),
                  ),
                )
              ];
            },
          ),
        ]);
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }
}
