import 'package:clann/src/features/lessons/presentation/lesson_screen.dart';
import 'package:clann/src/features/lessons/presentation/widgets/pop_quiz_answer_button.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class PopQuizWidget extends StatelessWidget {
  const PopQuizWidget({
    super.key,
    required this.answersOne,
    required this.answersTwo,
  });

  final List<String> answersOne;
  final List<String> answersTwo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.secondary),
      child: Column(
        children: [
          Text("Pop Quiz!", style: Theme.of(context).textTheme.headlineMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Which is correct?")),
              SizedBox(
                width: 200,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 12),
                  itemCount: answersOne.length,
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final answer = answersOne[index];
                    return PopQuizAnswerButton(answer: answer);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Which Irish sentence correctly says “The boy saw the dog”?",
                ),
              ),
              SizedBox(
                width: 200,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 12),
                  itemCount: answersTwo.length,
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final answer = answersTwo[index];
                    return PopQuizAnswerButton(answer: answer);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
