import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:clann/src/shared/long_tile.dart';
import 'package:clann/src/shared/small_tile.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    Text('Hi, Jonathan!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, fontFamily: 'Inter', color: AppColors.primary)),
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
                        Text("Grammar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                        Text("See All", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: SmallTile(title: "Verbs"),
                        ),
                        const SizedBox(width: 12),
                        SmallTile(title: "Nouns"),
                        const SizedBox(width: 12),
                        SmallTile(title: "Adjectives"),
                        const SizedBox(width: 12),
                        SmallTile(title: "Adverbs"),
                        const SizedBox(width: 12),
                        SmallTile(title: "Pronouns"),
                        const SizedBox(width: 12),
                        SmallTile(title: "Prepositions"),
                      ],
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
                        Text("Vocabulary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                        Text("See All", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: SmallTile(title: "Weather"),
                        ),
                        const SizedBox(width: 12),
                        SmallTile(title: "Food"),
                        const SizedBox(width: 12),
                        SmallTile(title: "Travel"),
                        const SizedBox(width: 12),
                        SmallTile(title: "Sports"),
                        const SizedBox(width: 12),
                        SmallTile(title: "Music"),
                        const SizedBox(width: 12),
                        SmallTile(title: "Art"),
                      ],
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
                        Text("Bundles", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                        Text("See All", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
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