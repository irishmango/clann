import 'package:flutter/material.dart';

class SmallTile extends StatelessWidget {
  final String title;
  final String? imgPath;

  const SmallTile({super.key, required this.title, this.imgPath});

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
            image: imgPath != null
                ? DecorationImage(
                    image: AssetImage(imgPath!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
