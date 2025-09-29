import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          SizedBox(height: 150),
          Column(
            spacing: 8,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/img/avatar_temp.jpg'),
              ),
              Text(
                "Ian Dooley",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.location_on), Text("Dublin")],
              ),
            ],
          ),
          SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [Text("XP"), Text("652")]),
                VerticalDivider(color: Colors.grey, thickness: 1),
                Column(children: [Text("Avchievements"), Text("12")]),
                VerticalDivider(color: Colors.grey, thickness: 1),
                Column(children: [Text("Member Since"), Text("Sept 2025")]),
              ],
            ),
          ),
          SizedBox(height: 40),
          Container(
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
                        Text(
                          "M",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Icon(Icons.close),
                      ],
                    ),
                    Column(
                      spacing: 8,
                      children: [
                        Text(
                          "T",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Icon(Icons.close),
                      ],
                    ),
                    Column(
                      spacing: 8,
                      children: [
                        Text(
                          "W",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Icon(Icons.close),
                      ],
                    ),
                    Column(
                      spacing: 8,
                      children: [
                        Text(
                          "T",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Icon(Icons.close),
                      ],
                    ),
                    Column(
                      spacing: 8,
                      children: [
                        Text(
                          "F",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Icon(Icons.close),
                      ],
                    ),
                    Column(
                      spacing: 8,
                      children: [
                        Text(
                          "S",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Icon(Icons.close),
                      ],
                    ),
                    Column(
                      spacing: 8,
                      children: [
                        Text(
                          "S",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Icon(Icons.close),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
