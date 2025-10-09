import 'package:clann/src/shared/svg_icon.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

/// Dashboard header card used on Home screen
/// Shows: avatar + greeting, XP progress, and a "Continue" tile.
class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    this.name = 'Ian',
    this.avatarAsset = 'assets/img/avatar_temp.jpg',
    this.level = 4,
    this.xp = 264,
    this.xpProgress = 0.45,
    this.continueSubtitle = 'Lesson: Word Order in Irish',
    this.continueProgress = 0.7,
  });

  final String name;
  final String avatarAsset;
  final int level;
  final int xp;
  // 0..1 progress to next level
  final double xpProgress;
  final String continueSubtitle;
  final double continueProgress;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 70, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Larger avatar on the left
              CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage(avatarAsset),
              ),
              const SizedBox(width: 12),
              // Right side: Column with greeting, then row with Level + XP
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey, $name!',
                      style: textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Level badge (4 over Level)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryLight,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/streak_fire_active.png",
                                width: 36,
                                height: 36,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '4', // TODO: Add streak dynamically
                                style: textTheme.labelLarge?.copyWith(
                                  color: AppColors.navy.withValues(alpha: 0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // XP progress takes remaining space
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: xpProgress.clamp(0, 1),
                                  minHeight: 10,
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.4,
                                  ),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        AppColors.secondary,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$xp XP',
                                style: textTheme.labelLarge?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Continue card inside the green container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.secondary, width: 2),
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Continue:",
                        style: textTheme.labelLarge?.copyWith(
                          color: AppColors.grey600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        continueSubtitle,
                        style: textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: continueProgress.clamp(0, 1),
                        backgroundColor: AppColors.grey200,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.secondary,
                        ),
                        strokeWidth: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
