import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class GrammarOverviewScreen extends StatelessWidget {
  GrammarOverviewScreen({super.key});

  final grammarList = [
    {
      "Gaeilge 101": [
        "Word Order",
        "The Copula (is) vs. tá",
        "Yes/No Questions",
      ],
    },
    {
      "Verbs": ["Regular Verbs", "Irregular Verbs"],
    },
    {
      "Constructions": ["Verbal Noun / Progressive", "Imperatives"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(
          top: 80.0,
          left: 18.0,
          right: 18.0,
          bottom: 32.0,
        ),
        children: [
          Text("Grammar", style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 18),
          CustomSearchBar(hintText: "Search in Irish or English"),
          const SizedBox(height: 36),

          // build sections dynamically
          for (final section in grammarList) ...[
            Text(
              section.keys.first,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 12),
            for (final topic in section.values.first) ...[
              Container(
                height: 80,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(12),
                child: Text(
                  topic,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}
