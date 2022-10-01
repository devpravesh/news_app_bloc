import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app_bloc/bloc/covid_bloc.dart';
import 'package:news_app_bloc/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CovidBloc(),
      child: GetMaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.white10),
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
