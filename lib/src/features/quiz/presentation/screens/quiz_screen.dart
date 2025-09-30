import 'package:clann/src/features/quiz/presentation/screens/results_screen.dart';
import 'package:clann/src/features/quiz/presentation/widgets/multiple_choice_button.dart';
import 'package:clann/src/features/quiz/presentation/widgets/quiz_check_button.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, Object>> questionsAndAnswers = const [
    {
      'question': 'What does "Dia dhuit" mean?',
      'answers': ['Hello', 'Goodbye', 'Please', 'Thank you'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'What is the Irish word for "Goodbye"?',
      'answers': ['Slán', 'Le do thoil', 'Go raibh maith agat', 'Fáilte'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'How do you say "Please" in Irish?',
      'answers': ['Le do thoil', 'Fáilte', 'Slán', 'Dia dhuit'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'What does "Go raibh maith agat" mean?',
      'answers': ['Thank you', 'Hello', 'Goodbye', 'Please'],
      'correctAnswerIndex': 0,
    },
  ];

  int _currentIndex = 0;
  int? _selectedAnswerIndex;
  bool _isChecked = false;

  void _nextQuestion() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % questionsAndAnswers.length;
      _selectedAnswerIndex = null;
      _isChecked = false;
    });
  }

  void _selectAnswer(int index) {
    setState(() {
      _selectedAnswerIndex = index;
      _isChecked = false;
    });
  }

  void _checkAnswer() {
    setState(() {
      _isChecked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final qa = questionsAndAnswers[_currentIndex];
    final question = qa['question'] as String;
    final answers = (qa['answers'] as List).cast<String>();
    final correctIndex = qa['correctAnswerIndex'] as int;
    final bool isLastQuestion = _currentIndex == questionsAndAnswers.length - 1;

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
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(answers.length, (index) {
                      // Determine border color based on state
                      Color borderColor = Colors.black;
                      if (_isChecked && index == correctIndex) {
                        borderColor =
                            AppColors.primary; // correct answer turns green
                      } else if (_selectedAnswerIndex == index) {
                        if (_isChecked) {
                          borderColor =
                              AppColors.error; // wrong selected answer
                        } else {
                          borderColor = AppColors.info; // selected pre-check
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Center(
                          child: MultipleChoiceButton(
                            answerText: answers[index],
                            borderColor: borderColor,
                            onTap: _isChecked
                                ? null
                                : () => _selectAnswer(index),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),

                    Center(
                      child: QuizCheckButton(
                        enabled: _selectedAnswerIndex != null,
                        isChecked: _isChecked,
                        showFinish: _isChecked && isLastQuestion,
                        onTap: () {
                          if (_selectedAnswerIndex == null) return;
                          if (_isChecked) {
                            if (isLastQuestion) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ResultsScreen(),
                                ),
                              );
                            } else {
                              _nextQuestion();
                            }
                          } else {
                            _checkAnswer();
                          }
                        },
                      ),
                    ),
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
