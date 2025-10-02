import 'package:clann/src/features/quiz/presentation/screens/drag_and_drop.dart';
import 'package:clann/src/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  Route _fadeThroughRoute(Widget page) => PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(context).push(_fadeThroughRoute(const QuizScreen()));
        },
        child: Text('Quiz'),
      ),
    );
  }
}
