import 'package:clann/src/features/bundles/presentation/screens/bundle_screen.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class BundleCoverScreen extends StatelessWidget {
  const BundleCoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Image.asset(
                'assets/img/gaeilge_101.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 26.0,
              vertical: 160.0,
            ),
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Céad Míle Fáilte",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  "Gaeilge 101",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 80,
            left: 18,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              iconSize: 32,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BundleScreen()),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
