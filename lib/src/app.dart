import 'package:clann/src/features/startup/presentation/screens/startup_screen.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clann',
      theme: buildAppTheme(),
      home: const StartupScreen(),
    );
  }
}
