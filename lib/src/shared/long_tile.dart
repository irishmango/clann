import 'package:flutter/material.dart';

class LongTile extends StatelessWidget {
  const LongTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
