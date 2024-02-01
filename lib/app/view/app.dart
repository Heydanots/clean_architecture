import 'package:clean_architecture/core/style/colors.dart';
import 'package:clean_architecture/features/news/data/repositories/news_repo_impl.dart';
import 'package:clean_architecture/features/news/presentation/bloc/news_bloc.dart';
import 'package:clean_architecture/features/news/presentation/pages/home_page.dart';
import 'package:clean_architecture/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({required this.impl, super.key});

  final NewsRepositoryImpl impl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(newsRepositoryImpl: impl),
      child: MaterialApp(
        theme: buildThemeData(context),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(),
      ),
    );
  }

  ThemeData buildThemeData(BuildContext context) => ThemeData(
        useMaterial3: false,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: .2,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(blue),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            // padding: MaterialStatePropertyAll(EdgeInsets.all(18)),
            minimumSize: MaterialStatePropertyAll(Size.fromHeight(45)),
          ),
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.blue,
            onPrimary: Colors.blue,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.white,
          selectedColor: blue,
          surfaceTintColor: blue,
          showCheckmark: false,
          labelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        sliderTheme: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
          thumbColor: blue,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          fillColor: Colors.grey.shade200,
        ),
      );
}
