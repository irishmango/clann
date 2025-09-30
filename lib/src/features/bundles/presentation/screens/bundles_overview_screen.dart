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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 80.0,
                left: 18.0,
                right: 18.0,
                bottom: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bundles",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 18),
                  CustomSearchBar(hintText: "Search in Irish or English"),
                  const SizedBox(height: 36),
                  SizedBox(
                    height: 800,
                    child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: bundlesList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
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
                              bundlesList[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
