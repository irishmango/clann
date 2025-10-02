import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class Achievement {
  final String id;
  final String title;
  final String description;
  final int xp;
  final String emoji;
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.xp,
    required this.emoji,
  });
}

class AchievementGrid extends StatelessWidget {
  const AchievementGrid({super.key, this.onAchievementTap});

  final void Function(Achievement achievement)? onAchievementTap;

  List<Achievement> _buildAchievements() => List.generate(
    18,
    (i) => Achievement(
      id: 'achv_$i',
      title: i == 0 ? 'Mo chéad phost as Gaeilge!' : 'Achievement #${i + 1}',
      description:
          'Comhghairdeas! Tá tú ar do bhealach i dtreo do spriocanna. (Demo)',
      xp: 200 + (i * 10),
      emoji: '☘️',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final achievements = _buildAchievements();
    return SizedBox(
      height: 850,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          childAspectRatio: 1,
        ),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final a = achievements[index];
          return GestureDetector(
            onTap: () => onAchievementTap?.call(a),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.4),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(a.emoji, style: const TextStyle(fontSize: 28)),
            ),
          );
        },
      ),
    );
  }
}
