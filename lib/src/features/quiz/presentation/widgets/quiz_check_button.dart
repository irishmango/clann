import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class QuizCheckButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool enabled;
  final bool isChecked;
  final bool showFinish;

  const QuizCheckButton({
    super.key,
    this.onTap,
    this.enabled = true,
    this.isChecked = false,
    this.showFinish = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = enabled && (onTap != null);
    final Widget content = isChecked
        ? (showFinish
              ? Text(
                  'Finish',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.white),
                )
              : const Icon(Icons.chevron_right, color: Colors.white))
        : Text(
            'Check',
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: Colors.white),
          );

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Container(
          height: 48,
          width: 100,
          constraints: const BoxConstraints(minWidth: 120),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isEnabled ? AppColors.info : AppColors.info.withAlpha(153),
            borderRadius: BorderRadius.circular(6),
            border: const Border(
              top: BorderSide(color: Colors.black),
              left: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
              bottom: BorderSide(color: Colors.black, width: 2),
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}
