import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';
import 'grammar_topic_screen.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back, size: 24),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  "Grammar",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: CustomSearchBar(hintText: "Search in Irish or English"),
              ),
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final section in grammarList) ...[
                      Text(
                        section.keys.first,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (final topic in section.values.first) ...[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => GrammarTopicScreen(),
                              ),
                            );
                          },
                          child: Container(
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
                        ),
                      ],
                      const SizedBox(height: 24),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
