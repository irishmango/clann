import 'package:clann/src/features/bundles/presentation/screens/bundles_overview_screen.dart';
import 'package:clann/src/features/grammar/presentation/screens/grammar_overview_screen.dart';
import 'package:clann/src/features/vocab/presentation/screens/vocab_overview_screen.dart';
import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:clann/src/shared/long_tile.dart';
import 'package:clann/src/shared/small_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final grammarList = [
    "Verbs",
    "Nouns",
    "Adjectives",
    "Adverbs",
    "Pronouns",
    "Prepositions",
  ];

  final vocabList = ["Weather", "Food", "Travel", "Sports", "Music", "Art"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/img/avatar_temp.jpg'),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hi, Ian!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomSearchBar(),
            ),
            SizedBox(height: 16),
            Column(
              spacing: 12,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Grammar",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GrammarOverviewScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16),
                    itemCount: grammarList.length,
                    itemBuilder: (context, index) {
                      return SmallTile(title: grammarList[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              spacing: 12,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vocabulary",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VocabOverviewScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16),
                    itemCount: vocabList.length,
                    itemBuilder: (context, index) {
                      return SmallTile(title: vocabList[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: 12,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bundles",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BundlesOverviewScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 450,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        LongTile(),
                        const SizedBox(height: 12),
                        LongTile(),
                        const SizedBox(height: 12),
                        LongTile(),
                        const SizedBox(height: 12),
                        LongTile(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 26),
          ],
        ),
      ),
    );
  }
}
