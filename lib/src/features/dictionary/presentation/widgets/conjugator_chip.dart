import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class ConjugatorChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const ConjugatorChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withValues(alpha: 0.12) : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.black,
            width: selected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: selected ? FontWeight.w600 : FontWeight.w300,
                fontSize: 14,
                color: selected ? AppColors.primary : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
