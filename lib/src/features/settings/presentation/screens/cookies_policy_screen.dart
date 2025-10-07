import 'package:flutter/material.dart';

class CookiesPolicyScreen extends StatelessWidget {
  const CookiesPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyStyle = Theme.of(context).textTheme.bodyMedium;
    final headingStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600);
    return Scaffold(
      body: SafeArea(
        top: false,
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
              Text('Cookies', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 8),
              Text(
                'Last updated: October 7, 2025',
                style: bodyStyle?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 28),
              _CookiesSection(
                title: '1. What Are Cookies?',
                text:
                    'Cookies are small text files stored on your device that help applications remember preferences and understand usage patterns. This screen explains the limited cookie / local storage practices of the app.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _CookiesSection(
                title: '2. Current App State',
                text:
                    'The current (demo) version of the app does not set third‑party advertising cookies. Only minimal local storage may be used for non‑personal preferences (e.g., theme mode) in future updates.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _CookiesSection(
                title: '3. Types of Storage We May Use',
                text:
                    'Essential: Required for core functionality like authentication session tokens.\nPreferences: Remember UI settings (e.g., display mode, language).\nAnalytics: Aggregate usage to improve features.\nNo Marketing or tracking cookies are presently used.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _CookiesSection(
                title: '4. Third‑Party Services',
                text:
                    'If analytics (e.g., Firebase Analytics) is enabled later, it may set its own identifiers. Such use will follow the Privacy Policy and be disclosed here with opt‑out guidance.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _CookiesSection(
                title: '5. Managing Cookies & Local Storage',
                text:
                    'You can clear app storage through your device settings. If a web version is introduced, you will be able to manage consent via a banner or settings panel. Blocking essential storage may degrade functionality.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _CookiesSection(
                title: '6. Do Not Track',
                text:
                    'The app currently does not respond to Do Not Track (DNT) signals because it does not perform cross‑site tracking. Any future web version changes will be reflected here.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _CookiesSection(
                title: '7. Changes to This Policy',
                text:
                    'We may update this Cookies Policy. Material changes will be communicated in‑app. Continued use after changes indicates acceptance.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _CookiesSection(
                title: '8. Contact',
                text:
                    'Questions can be directed to privacy@example.com (placeholder). Include context about your request.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  border: Border.all(color: Colors.teal.shade100),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Sample Cookies Policy for demonstration only. Replace with vetted legal text before production release.',
                  style: bodyStyle?.copyWith(
                    fontSize: 12,
                    color: Colors.teal.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CookiesSection extends StatelessWidget {
  final String title;
  final String text;
  final TextStyle? headingStyle;
  final TextStyle? bodyStyle;
  const _CookiesSection({
    required this.title,
    required this.text,
    required this.headingStyle,
    required this.bodyStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: headingStyle),
          const SizedBox(height: 6),
          Text(text, style: bodyStyle, textAlign: TextAlign.start),
        ],
      ),
    );
  }
}
