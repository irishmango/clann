import 'package:clann/src/features/profile/presentation/widgets/achievement_grid.dart';
import 'package:clann/src/features/profile/presentation/widgets/streak_card.dart';
import 'package:clann/src/features/settings/presentation/screens/settings_screen.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;
  // Default to Profile Screen
  void _onProfileSectionTapped(int index) {
    if (index == _selectedIndex) return;
    // Handle navigation logic here
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: -160,
            child: Container(
              width: 428,
              height: 428,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.black),
              ),
            ),
          ),
          _selectedIndex == 2
              ? Positioned(
                  top: 64,
                  left: 18,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _onProfileSectionTapped(0);
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          size: 44,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              : Positioned(
                  top: 64,
                  right: 18,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _onProfileSectionTapped(2);
                        },
                        icon: Icon(
                          Icons.settings,
                          size: 44,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                SizedBox(height: 150),
                Column(
                  spacing: 8,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(
                          'assets/img/avatar_temp.jpg',
                        ),
                      ),
                    ),
                    Text(
                      "Ian Dooley",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Row(
                      spacing: 4,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: AppColors.grey500),
                        Text(
                          "Dublin",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: AppColors.grey500),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _selectedIndex == 2
                    ? SizedBox.shrink()
                    : IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _onProfileSectionTapped(0);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "XP",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    "652",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(color: Colors.grey, thickness: 1),
                            GestureDetector(
                              onTap: () {
                                _onProfileSectionTapped(1);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Avchievements",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    "12",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(color: Colors.grey, thickness: 1),
                            Column(
                              children: [
                                Text(
                                  "Member Since",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "Sept 2025",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 40),
                switch (_selectedIndex) {
                  0 => StreakCard(),
                  1 => AchievementGrid(),
                  2 => SettingsScreen(),
                  _ => StreakCard(),
                },
              ],
            ),
          ),
        ],
      ),
    );
  }
}
