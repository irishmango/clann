import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

/// Reusable two-option segmented switch matching the Dictionary design.
class ModeSwitch extends StatelessWidget {
  final int selectedIndex; // 0 = left, 1 = right
  final ValueChanged<int> onChanged;
  final String leftLabel;
  final String rightLabel;
  final Color selectedColor;

  const ModeSwitch({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
    required this.leftLabel,
    required this.rightLabel,
    this.selectedColor = AppColors.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ModeSwitchButton(
              label: leftLabel,
              index: 0,
              selected: selectedIndex == 0,
              onTap: onChanged,
              selectedColor: selectedColor,
            ),
            _ModeSwitchButton(
              label: rightLabel,
              index: 1,
              selected: selectedIndex == 1,
              onTap: onChanged,
              selectedColor: selectedColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeSwitchButton extends StatelessWidget {
  final String label;
  final bool selected;
  final int index;
  final ValueChanged<int> onTap;
  final Color selectedColor;
  const _ModeSwitchButton({
    required this.label,
    required this.selected,
    required this.index,
    required this.onTap,
    this.selectedColor = AppColors.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: _radiusForIndex(index),
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: selected ? selectedColor : Colors.transparent,
          borderRadius: _radiusForIndex(index),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  BorderRadius _radiusForIndex(int i) {
    if (i == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      );
    }
    return const BorderRadius.only(
      topRight: Radius.circular(12),
      bottomRight: Radius.circular(12),
    );
  }
}
