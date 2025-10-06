import 'package:flutter/material.dart';

class DialectSettingsScreen extends StatelessWidget {
  const DialectSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 80,
            left: 18,
            right: 18,
            bottom: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.arrow_back, size: 24),
              ),
              const SizedBox(height: 20),
              Text('Dialect', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 24),
              Text(
                'Select preferred dialect (e.g. Connacht, Munster, Ulster).\n\nPlaceholder for toggle / radio list.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
