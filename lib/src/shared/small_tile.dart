import 'package:flutter/material.dart';

class SmallTile extends StatelessWidget {
  final String title;

  const SmallTile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: null,
        ),
        Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
      ],
    );
  }
}
