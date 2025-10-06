import 'package:clann/src/features/lessons/presentation/widgets/lesson_flashcards_widget.dart';
import 'package:clann/src/features/lessons/presentation/widgets/pop_quiz_widget.dart';
import 'package:clann/src/shared/finish_button.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class LessonScreen extends StatelessWidget {
  LessonScreen({super.key});

  final flashcardList = [
    "Irish Sentence Structure",
    "She drinks milk",
    "I saw the car",
    "They will be happy",
  ];

  final answersOne = [
    "Sí ólann bainne",
    "Chonaic mé an carr",
    "Sásta beidh siad",
  ];

  final answersTwo = [
    "An buachaill an madra chonaic",
    "Chonaic an buachaill an madra",
    "An buachaill chonaic an madra",
    "Chonaic an madra an buachaill",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.primary,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 80, 16, 32),
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Céad Míle Fáilte",
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium!.copyWith(color: Colors.white),
                    ),
                    Text(
                      "Gaeilge 101",
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "How does Irish work?".toUpperCase(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Column(
                spacing: 12,
                children: [
                  Text(
                    "Unlike English, which has a Subject-Verb-Object (SVO) structure,",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Irish is a Verb-Subject-Object (VSO) structure language.",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "That means:",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    "In English, we say:",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "The boy read the book",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "In Irish, we say:",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Léigh an buachaill an leabhar",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    "(Literally: Read the boy a book)",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FORMULA:",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    "Verb + Subject + Object",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 9),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                alignment: Alignment.topLeft,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Examples:",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    // example 1
                    Text(
                      "Ólann sí bainne",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "(Drinks she milk)",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      "She drinks milk",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 12),
                    // example 2
                    Text(
                      "Chonaic mé an carr",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "(Saw I the car)",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      "I saw the car",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 12),
                    // example 3
                    Text(
                      "Beidh siad sásta",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "(Will be they happy)",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      "They will be happy",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            LessonFlashcardsWidget(flashcardList: flashcardList),
            // Correct answers: first list index 0 (Ólann sí bainne), second list index 1 (Chonaic an buachaill an madra)
            PopQuizWidget(
              answersOne: answersOne,
              answersTwo: answersTwo,
              correctIndexOne: 1,
              correctIndexTwo: 1,
            ),
            SizedBox(height: 42),
            Center(child: FinishButton()),
            SizedBox(height: 42),
          ],
        ),
      ),
    );
  }
}
