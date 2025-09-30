import 'package:clann/src/features/dictionary/presentation/screens/conjugator_screen.dart';
import 'package:clann/src/features/dictionary/presentation/widgets/conjugator.dart';
import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  int _selectedIndex = 0;
  // Default to Main Screen
  void _onCardTapped(int index) {
    if (index == _selectedIndex) return;
    // Handle navigation logic here
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                _selectedIndex == 0 ? "Dictionary" : "Conjugator",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 18),
              CustomSearchBar(hintText: "Search in Irish or English"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: _selectedIndex == 0
              ? Text("Make a search to get started!")
              : ConjugatorScreen(),
        ),
        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            spacing: 12,
            children: [
              Row(
                children: [
                  Text(
                    "Quick Links",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Spacer(),
                ],
              ),
              Row(
                spacing: 12,
                children: [
                  Container(
                    width: 160,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.peach,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        "Irregular Verbs",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  _selectedIndex == 0
                      ? GestureDetector(
                          onTap: () {
                            _onCardTapped(1);
                          },
                          child: Container(
                            width: 160,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.peach,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                "Conjugator",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            _onCardTapped(0);
                          },
                          child: Container(
                            width: 160,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.peach,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                "Dictionary",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
