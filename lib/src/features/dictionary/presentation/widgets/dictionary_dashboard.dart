import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class DictionaryDashboard extends StatelessWidget {
  const DictionaryDashboard({
    super.key,
    this.title = 'Dictionary',
    this.middle,
    required this.searchBar,
  });

  final String title;
  final Widget? middle;
  final Widget searchBar;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.displayMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 14),
          if (middle != null) middle!,
          if (middle != null) const SizedBox(height: 14),
          searchBar,
        ],
      ),
    );
  }
}
