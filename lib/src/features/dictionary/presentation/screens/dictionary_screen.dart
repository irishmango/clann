import 'package:flutter/material.dart';

class DictionaryScreen extends StatelessWidget {
  const DictionaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Dictionary Screen',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );

  }
}