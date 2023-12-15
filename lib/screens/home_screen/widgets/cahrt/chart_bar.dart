import 'package:expenses_app/main.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill});

  final double fill;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding:  EdgeInsetsDirectional.symmetric(horizontal: MediaQuery.of(context).size.width * .03),
            child: FractionallySizedBox(
              heightFactor: fill,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      myColorScheme.onPrimaryContainer.withOpacity(0.3),
                      myColorScheme.onPrimaryContainer.withOpacity(0.6),
                      myColorScheme.onPrimaryContainer.withOpacity(0.9),
                      myColorScheme.onPrimaryContainer,
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    color: myColorScheme.onPrimaryContainer),
              ),
            )));
  }
}
