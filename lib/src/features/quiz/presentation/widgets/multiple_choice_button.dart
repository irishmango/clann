import 'package:flutter/material.dart';

class MultipleChoiceButton extends StatelessWidget {
  final String answerText;
  final Color borderColor;
  final VoidCallback? onTap;

  const MultipleChoiceButton({
    super.key,
    required this.answerText,
    required this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 6),
        constraints: const BoxConstraints.tightFor(width: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(
            top: BorderSide(color: borderColor),
            left: BorderSide(color: borderColor),
            right: BorderSide(color: borderColor),
            bottom: BorderSide(color: borderColor, width: 2),
          ),
        ),
        alignment: Alignment.center,
        child: Text(answerText, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
