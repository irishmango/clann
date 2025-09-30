import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(36),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.peach,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Streak", style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                spacing: 8,
                children: [
                  Text("M", style: Theme.of(context).textTheme.titleLarge),
                  Icon(Icons.close),
                ],
              ),
              Column(
                spacing: 8,
                children: [
                  Text("T", style: Theme.of(context).textTheme.titleLarge),
                  Icon(Icons.close),
                ],
              ),
              Column(
                spacing: 8,
                children: [
                  Text("W", style: Theme.of(context).textTheme.titleLarge),
                  Icon(Icons.close),
                ],
              ),
              Column(
                spacing: 8,
                children: [
                  Text("T", style: Theme.of(context).textTheme.titleLarge),
                  Icon(Icons.close),
                ],
              ),
              Column(
                spacing: 8,
                children: [
                  Text("F", style: Theme.of(context).textTheme.titleLarge),
                  Icon(Icons.close),
                ],
              ),
              Column(
                spacing: 8,
                children: [
                  Text("S", style: Theme.of(context).textTheme.titleLarge),
                  Icon(Icons.close),
                ],
              ),
              Column(
                spacing: 8,
                children: [
                  Text("S", style: Theme.of(context).textTheme.titleLarge),
                  Icon(Icons.close),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
