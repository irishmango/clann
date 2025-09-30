import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class BundleScreen extends StatelessWidget {
  BundleScreen({super.key});

  final bundleList = [
    {
      "Grammar Review": ["Irregular Verbs", "Word Order"],
    },
    {
      "Vocab Booster": ["Hobbies", "Social Media"],
    },
    {
      "Comprension Practice": ["Reading", "Listening"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(
          top: 80.0,
          left: 18.0,
          right: 18.0,
          bottom: 32.0,
        ),
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back, size: 32),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Text(
                    "Gaeilge 101",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 18),

          // build sections dynamically
          for (final section in bundleList) ...[
            Text(
              section.keys.first,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: section.values.first.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final topic = section.values.first[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LessonScreen()),
                      );
                    },
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        topic,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}
