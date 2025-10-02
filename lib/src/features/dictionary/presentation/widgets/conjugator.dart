import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class ConjugationData {
  final String title;
  final List<String> ga;
  final List<String> en;

  const ConjugationData({
    required this.title,
    required this.ga,
    required this.en,
  }) : assert(ga.length == en.length, 'Irish and English lists must match');
}

class Conjugator extends StatelessWidget {
  final ConjugationData data;

  const Conjugator({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 260),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                data.title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < data.ga.length; i++) ...[
                        Text(data.ga[i]),
                        if (i != data.ga.length - 1) const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < data.en.length; i++) ...[
                        Text(data.en[i]),
                        if (i != data.en.length - 1) const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
