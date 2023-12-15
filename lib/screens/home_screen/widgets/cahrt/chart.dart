import 'package:expenses_app/main.dart';
import 'package:expenses_app/model/expenses_model.dart';
import 'package:expenses_app/screens/home_screen/widgets/cahrt/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<ExpensesModel> expenses;

  List<ExpensesBucknet> get buckets {
    return [
      ExpensesBucknet.forCategory(
          category: Category.food, allExpenses: expenses),
      ExpensesBucknet.forCategory(
          category: Category.clothes, allExpenses: expenses),
      ExpensesBucknet.forCategory(
          category: Category.travel, allExpenses: expenses),
      ExpensesBucknet.forCategory(
          category: Category.work, allExpenses: expenses),
    ];
  }

  double get maxTotalExpens {
    double maxTotalExpens = 0;
    for (var element in buckets) {
      if (element.totalExpenses > maxTotalExpens) {
        maxTotalExpens = element.totalExpenses;
      }
    }
    return maxTotalExpens;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin:  EdgeInsetsDirectional.symmetric(
            horizontal: MediaQuery.of(context).size.width * .025,
            vertical: MediaQuery.of(context).size.height * .02,
          ),
          padding:  EdgeInsetsDirectional.symmetric(vertical: MediaQuery.of(context).size.width * .05, 
          horizontal: MediaQuery.of(context).size.height * .015),
          width: double.infinity,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              myColorScheme.primaryContainer.withOpacity(0.3),
              myColorScheme.primaryContainer.withOpacity(0.6),
              myColorScheme.primaryContainer.withOpacity(0.8),
              myColorScheme.primary
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            borderRadius: BorderRadius.circular(10),
            color: myColorScheme.onPrimary,
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final element in buckets)
                      ChartBar(
                        fill: element.totalExpenses == 0
                            ? 0
                            : element.totalExpenses / maxTotalExpens,
                      ),
                  ],
                ),
              ),
               SizedBox(height: MediaQuery.of(context).size.height * .01),
              Row(
                children: buckets
                    .map((e) => Expanded(
                            child: Padding(
                          padding:  EdgeInsetsDirectional.symmetric(horizontal:  MediaQuery.of(context).size.width * .025,),
                          child: Icon(
                            categoryIcons[e.category],
                            color: e.totalExpenses == 0
                                ? myColorScheme.onPrimary.withOpacity(0.3)
                                : myColorScheme.onPrimaryContainer,
                          ),
                        )))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
