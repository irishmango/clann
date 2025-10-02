import 'package:clann/src/features/quiz/presentation/screens/drag_and_drop.dart';
import 'package:clann/src/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => QuizScreen()));
        },
        child: Text('Quiz'),
      ),
    );
  }
}
