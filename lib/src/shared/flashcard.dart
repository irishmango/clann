import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class Flashcard extends StatelessWidget {
  const Flashcard({super.key, required this.flashcard});

  final String flashcard;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      height: 220,
      decoration: ShapeDecoration(
        color: AppColors.peach,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),

      child: Column(
        spacing: 42,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.volume_up, size: 32),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border, size: 32),
              ),
            ],
          ),
          Center(
            child: Text(
              flashcard,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
