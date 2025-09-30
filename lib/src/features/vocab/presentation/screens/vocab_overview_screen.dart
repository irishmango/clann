import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class VocabOverviewScreen extends StatelessWidget {
  VocabOverviewScreen({super.key});

  final vocabList = ["Weather", "Food", "Travel", "Sports", "Music", "Art"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 80.0,
              left: 18.0,
              right: 18.0,
              bottom: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vocabulary",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 18),
                CustomSearchBar(hintText: "Search in Irish or English"),
                const SizedBox(height: 36),
                Column(
                  children: [
                    GridView.count(
                      padding: EdgeInsets.all(0),
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                      physics: const NeverScrollableScrollPhysics(),
                      children: vocabList.map((word) {
                        return Column(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                color: AppColors.navy,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                            ),
                            Text(
                              word,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
