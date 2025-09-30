import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class AchievementGrid extends StatelessWidget {
  const AchievementGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 850,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          childAspectRatio: 1,
        ),
        itemCount: 18,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // TODO: Add Open card function
            },
            child: Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.grey300,
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }
}
