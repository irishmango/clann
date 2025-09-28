import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Learn Screen',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ); 
  }
}