import 'package:flutter/material.dart';

class ResultsButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const ResultsButton({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 100,
        constraints: const BoxConstraints(minWidth: 120),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
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
        child: Text(label, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
