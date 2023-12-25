import 'package:expenses_app/screens/home_screen/manager/localization_bloc.dart';
import 'package:expenses_app/screens/home_screen/manager/localization_state.dart';
import 'package:expenses_app/screens/home_screen/view/home_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(const MyApp()));
}

var myColorScheme = ColorScheme.fromSeed(seedColor: Colors.blueGrey);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalizationBloc(),
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state.newLocal,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Expenses App',
            theme: ThemeData().copyWith(
                colorScheme: myColorScheme,
                appBarTheme: const AppBarTheme().copyWith(
                    backgroundColor: myColorScheme.onPrimaryContainer,
                    foregroundColor: myColorScheme.onPrimary),
                scaffoldBackgroundColor: myColorScheme.onPrimaryContainer,
                cardTheme:
                    const CardTheme().copyWith(color: myColorScheme.onPrimary)),
            home: const HomeScreenView(),
          );
        },
      ),
    );
  }
}
