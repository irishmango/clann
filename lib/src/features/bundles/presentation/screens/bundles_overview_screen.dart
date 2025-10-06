import 'package:clann/src/features/bundles/presentation/screens/bundle_cover_screen.dart';
import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class BundlesOverviewScreen extends StatelessWidget {
  BundlesOverviewScreen({super.key});

  final bundlesList = [
    "Gaeilge 101",
    "Junior Cert Prep",
    "Leaving Cert Prep",
    "Gaeltacht Essentials",
    "Irregular Verbs",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.arrow_back, size: 24),
              ),
            ),
            const SizedBox(height: 12),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                "Bundles",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 12),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: CustomSearchBar(hintText: "Search in Irish or English"),
            ),
            const SizedBox(height: 36),
            // Bundles list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < bundlesList.length; i++) ...[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BundleCoverScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 80,
                        padding: const EdgeInsets.all(12),
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color: AppColors.peach,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Text(
                          bundlesList[i],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    if (i != bundlesList.length - 1) const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
