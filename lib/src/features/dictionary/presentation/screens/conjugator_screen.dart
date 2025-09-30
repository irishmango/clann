import 'package:clann/src/features/dictionary/presentation/widgets/conjugator.dart';
import 'package:clann/src/features/dictionary/presentation/widgets/conjugator_chip.dart';
import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:flutter/material.dart';

class ConjugatorScreen extends StatelessWidget {
  const ConjugatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ConjugatorChip(label: "Present Tense (An Aimsir Láithreach)"),
              const SizedBox(width: 8),
              ConjugatorChip(label: "Past Tense (An Aimsir Chaite)"),
              const SizedBox(width: 8),
              ConjugatorChip(label: "Future Tense (An Aimsir Fháistinach)"),
              const SizedBox(width: 8),
              ConjugatorChip(label: "Conditional (An Modh Coinníollach)"),
              const SizedBox(width: 8),
              ConjugatorChip(label: "Imperative (An Modh Ordaitheach)"),
              const SizedBox(width: 8),
              ConjugatorChip(label: "Verbal Noun / Adjective"),
              SizedBox(width: 18),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Conjugator(),
      ],
    );
  }
}
