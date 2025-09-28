import 'package:clann/src/features/dictionary/presentation/screens/dictionary_screen.dart';
import 'package:clann/src/features/home/presentation/screens/home_screen.dart';
import 'package:clann/src/features/learn/presentation/screens/learn_screen.dart';
import 'package:clann/src/features/notes/presentation/screens/notes_screen.dart';
import 'package:clann/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:clann/src/features/home/presentation/widgets/nav_bar.dart';
import 'package:clann/src/shared/LongTile.dart';
import 'package:clann/src/shared/small_tile.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 2; 
 // Default to Home Screen
  void _onRouteTapped(int index) {
    if (index == _selectedIndex) return;
    // Handle navigation logic here
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      switch (_selectedIndex) {
        0 => LearnScreen(),
        1 => DictionaryScreen(),
        2 => HomeScreen(),
        3 => NotesScreen(),
        4 => ProfileScreen(),
        _ => HomeScreen(),
      },
      bottomNavigationBar: NavBar(onRouteTapped: _onRouteTapped, selectedIndex: _selectedIndex),
    );
  }
}
