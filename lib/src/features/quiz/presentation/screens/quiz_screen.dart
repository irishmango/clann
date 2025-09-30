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

  void _nextQuestion() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % questionsAndAnswers.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final qa = questionsAndAnswers[_currentIndex];
    final question = qa['question'] as String;
    final answers = (qa['answers'] as List).cast<String>();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 6),
          borderRadius: BorderRadius.circular(55),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 12),
                ...answers.map(
                  (a) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Center(child: MultipleChoiceButton(answerText: a)),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: _nextQuestion,
                      child: const Text('Next'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MultipleChoiceButton extends StatelessWidget {
  final String answerText;

  const MultipleChoiceButton({super.key, required this.answerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 42, vertical: 6),
      constraints: BoxConstraints.tightFor(width: 250),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: const Border(
          top: BorderSide(color: Colors.black),
          left: BorderSide(color: Colors.black),
          right: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      alignment: Alignment.center,
      child: Text(answerText, style: Theme.of(context).textTheme.headlineSmall),
    );
  }
}
