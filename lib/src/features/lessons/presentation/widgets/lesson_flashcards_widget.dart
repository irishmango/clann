import 'package:clann/src/shared/flashcard.dart';
import 'package:flutter/material.dart';

class LessonFlashcardsWidget extends StatelessWidget {
  const LessonFlashcardsWidget({super.key, required this.flashcardList});

  final List<String> flashcardList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Text(
            "Flashcards",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(26, 12, 26, 32),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: flashcardList.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final flashcard = flashcardList[index];
              return Flashcard(flashcard: flashcard);
            },
          ),
        ),
      ],
    );
  }
}
