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

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  Achievement? _selectedAchievement;
  late final AnimationController _overlayController;

  @override
  void initState() {
    super.initState();
    _overlayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
      reverseDuration: const Duration(milliseconds: 160),
    );
  }

  @override
  void dispose() {
    _overlayController.dispose();
    super.dispose();
  }

  // Default to Profile Screen
  void _onProfileSectionTapped(int index) {
    if (index == _selectedIndex) return;
    // Handle navigation logic here
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openAchievement(Achievement a) {
    setState(() => _selectedAchievement = a);
    _overlayController.forward(from: 0);
  }

  Future<void> _closeAchievement() async {
    await _overlayController.reverse();
    if (mounted) setState(() => _selectedAchievement = null);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
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
                                VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
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
                                VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
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
                      1 => AchievementGrid(onAchievementTap: _openAchievement),
                      2 => SettingsScreen(),
                      _ => StreakCard(),
                    },
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_selectedAchievement != null) ...[
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeAchievement,
              child: AnimatedBuilder(
                animation: _overlayController,
                builder: (context, _) => Container(
                  color: Colors.black.withOpacity(
                    0.25 * _overlayController.value,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _overlayController,
              builder: (context, _) {
                final scale = Curves.easeOutBack.transform(
                  _overlayController.value.clamp(0, 1),
                );
                final opacity = _overlayController.value;
                return Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: _AchievementOverlayCard(
                      achievement: _selectedAchievement!,
                      onClose: _closeAchievement,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

class _AchievementOverlayCard extends StatelessWidget {
  final Achievement achievement;
  final VoidCallback onClose;
  const _AchievementOverlayCard({
    required this.achievement,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 300,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1.2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: onClose,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.2),
                    color: AppColors.grey100,
                  ),
                  child: const Icon(Icons.close, size: 16, color: Colors.black),
                ),
              ),
            ),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
                color: AppColors.primaryLight,
              ),
              alignment: Alignment.center,
              child: Text(
                achievement.emoji,
                style: const TextStyle(fontSize: 54),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              achievement.title,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${achievement.xp} XP',
              style: textTheme.labelLarge?.copyWith(letterSpacing: 0.5),
            ),
            const SizedBox(height: 18),
            Text(
              achievement.description,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
