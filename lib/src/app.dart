import 'package:clann/src/features/root_screen/presentation/screens/root_screen.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clann',
      theme: buildAppTheme(),
      home: RootScreen(),
    );
  }
}