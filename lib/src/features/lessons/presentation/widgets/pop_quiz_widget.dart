import 'package:flutter/material.dart';
import 'package:clann/theme.dart';
import 'package:clann/src/features/lessons/presentation/widgets/pop_quiz_answer_button.dart';

class PopQuizWidget extends StatefulWidget {
  const PopQuizWidget({
    super.key,
    required this.answersOne,
    required this.answersTwo,
    this.correctIndexOne = 0,
    this.correctIndexTwo = 0,
  });

  final List<String> answersOne;
  final List<String> answersTwo;
  final int correctIndexOne;
  final int correctIndexTwo;

  @override
  State<PopQuizWidget> createState() => _PopQuizWidgetState();
}

class _PopQuizWidgetState extends State<PopQuizWidget> {
  int? _pickedOne;
  int? _pickedTwo;
  bool _lockedOne = false;
  bool _lockedTwo = false;

  void _pick(int group, int index) {
    setState(() {
      if (group == 1 && !_lockedOne) {
        _pickedOne = index;
        _lockedOne = true; // one chance
      } else if (group == 2 && !_lockedTwo) {
        _pickedTwo = index;
        _lockedTwo = true;
      }
    });
  }

  Widget _buildList({
    required List<String> answers,
    required int correctIdx,
    required int groupId,
    required int? picked,
    required bool locked,
  }) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 4),
      itemCount: answers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final areRevealed = locked; // reveal after a pick
        return PopQuizAnswerButton(
          answer: answers[index],
          onTap: locked ? null : () => _pick(groupId, index),
          reveal: areRevealed,
          isCorrect: index == correctIdx,
          isUserWrongPick:
              areRevealed && picked == index && index != correctIdx,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Pop Quiz!', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(child: Text('Which is correct?')),
              SizedBox(
                width: 210,
                child: _buildList(
                  answers: widget.answersOne,
                  correctIdx: widget.correctIndexOne,
                  groupId: 1,
                  picked: _pickedOne,
                  locked: _lockedOne,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Which Irish sentence correctly says “The boy saw the dog”?',
                ),
              ),
              SizedBox(
                width: 210,
                child: _buildList(
                  answers: widget.answersTwo,
                  correctIdx: widget.correctIndexTwo,
                  groupId: 2,
                  picked: _pickedTwo,
                  locked: _lockedTwo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
