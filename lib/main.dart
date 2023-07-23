import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:todo/shared/cubit/bloc_observer.dart';
import 'screens/first__page.dart';
import 'screens/old_home.dart';

void main() {
  runApp(const MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}
