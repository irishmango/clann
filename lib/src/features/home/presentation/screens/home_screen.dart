import 'dart:math';
import 'package:clann/src/features/bundles/presentation/screens/bundles_overview_screen.dart';
import 'package:clann/src/features/grammar/presentation/screens/grammar_overview_screen.dart';
import 'package:clann/src/features/grammar/presentation/screens/grammar_topic_screen.dart';
import 'package:clann/src/features/vocab/presentation/screens/vocab_overview_screen.dart';
import 'package:clann/src/shared/long_tile.dart';
import 'package:clann/src/shared/small_tile.dart';
import 'package:flutter/material.dart';
import 'package:clann/src/features/home/presentation/widgets/dashboard_card.dart';

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

  // Pool of available images (ensure assets declared in pubspec.yaml)
  static const _imagePool = [
    'assets/img/bird_books.png',
    'assets/img/bread_drink.png',
    'assets/img/family_friends.png',
    'assets/img/greetings.png',
    'assets/img/numbers.png',
    'assets/img/owl_school.png',
    'assets/img/time_seasons.png',
  ];

  String _randomImg(Random r) => _imagePool[r.nextInt(_imagePool.length)];

  @override
  Widget build(BuildContext context) {
    final rand = Random();
    final grammarImages = [for (var _ in grammarList) _randomImg(rand)];
    final vocabImages = [for (var _ in vocabList) _randomImg(rand)];
    return SingleChildScrollView(
      child: Column(
        children: [
          DashboardCard(),
          const SizedBox(height: 24),
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GrammarTopicScreen(),
                          ),
                        );
                      },
                      child: SmallTile(
                        title: grammarList[index],
                        imgPath: grammarImages[index],
                      ),
                    );
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
                    return SmallTile(
                      title: vocabList[index],
                      imgPath: vocabImages[index],
                    );
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
                      LongTile(
                        imgPath: "assets/img/gaeilge_101.png",
                        title: "Gaeilge 101",
                        subtitle: "Start your Irish journey",
                      ),
                      const SizedBox(height: 12),
                      LongTile(
                        imgPath: "assets/img/owl_school.png",
                        title: "Junior Cert Prep",
                        subtitle: "Prep for 2026 exams",
                      ),
                      const SizedBox(height: 12),
                      LongTile(
                        imgPath: "assets/img/bird_books.png",
                        title: "Leaving Cert Prep",
                        subtitle: "Prep for 2026 exams",
                      ),
                      const SizedBox(height: 12),
                      LongTile(
                        imgPath: "assets/img/gaeltacht.png",
                        title: "Gaeltacht Prep",
                        subtitle: "Survival Guide",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 26),
        ],
      ),
    );
  }
}
