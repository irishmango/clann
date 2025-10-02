import 'package:clann/src/features/quiz/domain/quiz_question.dart';
import 'package:clann/src/features/quiz/presentation/widgets/multiple_choice_button.dart';
import 'package:clann/src/features/quiz/presentation/widgets/quiz_check_button.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class MultipleChoiceQuestionWidget extends StatefulWidget {
  final MultipleChoiceQuestion question;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onFinish;
  const MultipleChoiceQuestionWidget({
    super.key,
    required this.question,
    required this.isLast,
    required this.onNext,
    required this.onFinish,
  });

  @override
  State<MultipleChoiceQuestionWidget> createState() =>
      _MultipleChoiceQuestionWidgetState();
}

class _MultipleChoiceQuestionWidgetState
    extends State<MultipleChoiceQuestionWidget> {
  int? _selected;
  bool _checked = false;

  void _select(int i) {
    if (_checked) return;
    setState(() => _selected = i);
  }

  void _onTapCheck() {
    if (_selected == null) return;
    if (_checked) {
      if (widget.isLast) {
        widget.onFinish();
      } else {
        widget.onNext();
      }
    } else {
      setState(() => _checked = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.question;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          q.prompt,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 12),
        ...List.generate(q.answers.length, (i) {
          Color border = Colors.black;
          if (_checked && i == q.correctIndex) {
            border = AppColors.primary;
          } else if (_selected == i) {
            border = _checked ? AppColors.error : AppColors.info;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Center(
              child: MultipleChoiceButton(
                answerText: q.answers[i],
                borderColor: border,
                onTap: _checked ? null : () => _select(i),
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
        QuizCheckButton(
          enabled: _selected != null,
          isChecked: _checked,
          showFinish: _checked && widget.isLast,
          onTap: _onTapCheck,
        ),
      ],
    );
  }
}
