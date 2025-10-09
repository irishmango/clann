import 'package:clann/theme.dart';
import 'package:flutter/material.dart';
import 'package:clann/src/features/notes/presentation/widgets/notes_dashboard.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});

  final flashcards = [
    {"title": "Irregular Verbs", "color": AppColors.secondary},
    {"title": "Personal Pronouns", "color": AppColors.primary},
    {"title": "Prepositions", "color": Colors.blue},
    {"title": "Adjectives", "color": AppColors.lavender},
  ];
  final phraseBooks = ["Gaeltacht", "Family & Friends"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NotesDashboard(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  spacing: 12,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Flash Cards",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    GridView.count(
                      padding: EdgeInsets.all(0),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      children: flashcards.map((card) {
                        return Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: card["color"] as Color,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              card["title"]! as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  spacing: 12,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Phrasebook",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 250,
                      child: ListView.separated(
                        padding: EdgeInsets.all(0),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: phraseBooks.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.peach,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                phraseBooks[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
