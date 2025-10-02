import 'package:clann/src/features/quiz/domain/quiz_question.dart';
import 'package:clann/src/features/quiz/presentation/screens/results_screen.dart';
import 'package:clann/src/features/quiz/presentation/widgets/multiple_choice_question_widget.dart';
import 'package:clann/src/features/quiz/presentation/widgets/drag_and_drop_question_widget.dart';
import 'package:clann/src/features/quiz/presentation/widgets/pair_match_question_widget.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<QuizQuestion> _questions = [
    const MultipleChoiceQuestion(
      prompt: 'What does "Dia dhuit" mean?',
      answers: ['Hello', 'Goodbye', 'Please', 'Thank you'],
      correctIndex: 0,
    ),
    PairMatchQuestion(
      prompt: 'Match the Irish words to their English meanings',
      ga: ['madra', 'cat', 'uisce', 'arán', 'bainne'],
      en: ['dog', 'cat', 'water', 'bread', 'milk'],
    ),
    const DragAndDropQuestion(
      prompt: 'Construct: "Chonaic mé an car"',
      words: ['mé', 'an', 'Chonaic', 'car'],
      correctOrder: ['Chonaic', 'mé', 'an', 'car'],
    ),
    const MultipleChoiceQuestion(
      prompt: 'What is the Irish word for "Goodbye"?',
      answers: ['Slán', 'Le do thoil', 'Go raibh maith agat', 'Fáilte'],
      correctIndex: 0,
    ),
    const MultipleChoiceQuestion(
      prompt: 'How do you say "Please" in Irish?',
      answers: ['Le do thoil', 'Fáilte', 'Slán', 'Dia dhuit'],
      correctIndex: 0,
    ),
  ];

  int _currentIndex = 0;
  bool get _isLast => _currentIndex == _questions.length - 1;

  void _goNext() {
    if (_isLast) return;
    setState(() => _currentIndex++);
  }

  void _finishQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ResultsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 6),
          borderRadius: BorderRadius.circular(55),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 64,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.close, size: 32),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    switch (question.type) {
                      QuizQuestionType.multipleChoice =>
                        MultipleChoiceQuestionWidget(
                          key: ValueKey('mc_$_currentIndex'),
                          question: question as MultipleChoiceQuestion,
                          isLast: _isLast,
                          onNext: _goNext,
                          onFinish: _finishQuiz,
                        ),
                      QuizQuestionType.dragAndDrop => DragAndDropQuestionWidget(
                        key: ValueKey('dd_$_currentIndex'),
                        question: question as DragAndDropQuestion,
                        isLast: _isLast,
                        onNext: _goNext,
                        onFinish: _finishQuiz,
                      ),
                      QuizQuestionType.pairMatch => PairMatchQuestionWidget(
                        key: ValueKey('pm_$_currentIndex'),
                        question: question as PairMatchQuestion,
                        isLast: _isLast,
                        onNext: _goNext,
                        onFinish: _finishQuiz,
                      ),
                    },
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
