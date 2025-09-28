import 'package:flutter/material.dart';

class GrammarOverviewScreen extends StatelessWidget {
  const GrammarOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          'Profile Screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
    );;
  }
}