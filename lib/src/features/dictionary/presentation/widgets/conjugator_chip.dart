import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class ConjugatorChip extends StatefulWidget {
  final String label;

  const ConjugatorChip({
    super.key,
    required this.label,
  });

  @override
  State<ConjugatorChip> createState() => _ConjugatorChipState();
}

class _ConjugatorChipState extends State<ConjugatorChip> {

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: AppColors.primary, width: 2) : Border.all(color: Colors.black, width: 1)
        ),
        child: Center(
          child: Text(
            widget.label,
            style: isSelected ? TextStyle(fontWeight: FontWeight.w600, fontSize: 14) : TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
          ),
        ),
      ),
    );
  }
}