import 'package:flutter/material.dart';
import 'package:clann/theme.dart';

class PopQuizAnswerButton extends StatelessWidget {
  final String answer;
  final VoidCallback? onTap;
  final bool reveal; // whether result should be shown
  final bool isCorrect;
  final bool isUserWrongPick; // true only for the user's incorrect choice

  const PopQuizAnswerButton({
    super.key,
    required this.answer,
    required this.onTap,
    required this.reveal,
    required this.isCorrect,
    required this.isUserWrongPick,
  });

  @override
  Widget build(BuildContext context) {
    Color border = Colors.black;
    Color fill = Colors.white;
    FontWeight weight = FontWeight.w400;
    if (reveal) {
      if (isCorrect) {
        border = AppColors.primary;
        fill = AppColors.primary.withAlpha(153);
        weight = FontWeight.w600;
      } else if (isUserWrongPick) {
        border = AppColors.error;
        fill = AppColors.error.withAlpha(90);
        weight = FontWeight.w600;
      }
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(6),
          border: Border(
            top: BorderSide(color: border),
            left: BorderSide(color: border),
            right: BorderSide(color: border),
            bottom: BorderSide(color: border, width: 2),
          ),
        ),
        child: Text(
          answer,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: weight),
        ),
      ),
    );
  }
}
