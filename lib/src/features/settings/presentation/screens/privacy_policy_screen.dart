import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
              Text('Privacy', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 8),
              Text(
                'Last updated: October 7, 2025',
                style: bodyStyle?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 28),
              _PrivacySection(
                title: '1. Overview',
                text:
                    'This Privacy Policy explains how we collect, use, disclose, and protect your information when you use the application ("Service"). By using the Service you consent to this Policy. If you do not agree, discontinue use.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '2. Information We Collect',
                text:
                    'Account Data: name, email, optional school and learning level. Usage Data: pages/screens viewed, feature interactions, session timestamps. Device Data: basic device type and OS version. Content Data: dictionary queries or feedback you voluntarily submit. No sensitive personal data is intentionally collected.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '3. How We Use Information',
                text:
                    'We use data to operate and improve the Service (performance, debugging), personalize learning experience, communicate important updates, and ensure security & abuse prevention. Aggregated analytics may be used for roadmap decisions.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '4. Legal Bases (EEA/UK Users)',
                text:
                    'Processing relies on: (a) Contract (providing core functionality); (b) Legitimate Interests (improving and securing the Service); (c) Consent (optional communications); (d) Legal Obligations (compliance and enforcement).',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '5. Sharing & Disclosure',
                text:
                    'We do not sell personal data. Limited sharing may occur with service providers (hosting, analytics), legal authorities if required, or during a merger/acquisition. Providers are bound by confidentiality and security obligations.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '6. Data Retention',
                text:
                    'We retain personal data only as long as needed for stated purposes or to comply with legal requirements. Usage logs may be aggregated and anonymized. You may request deletion (see Your Rights section).',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '7. Security',
                text:
                    'We implement technical and organizational safeguards (encryption in transit, least‑privilege access). No system is fully secure; promptly report any suspected vulnerabilities via the contact method below.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '8. Children\'s Privacy',
                text:
                    'The Service is not directed to children under 13 (or equivalent minimum age in your jurisdiction). If we learn we unintentionally collected data from a child without consent, we will delete it.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '9. International Transfers',
                text:
                    'Data may be processed in jurisdictions different from your own. Where required, we use appropriate safeguards (e.g., standard contractual clauses) to protect cross‑border transfers.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '10. Your Rights',
                text:
                    'Depending on your location you may have rights to access, correct, delete, port, restrict or object to processing, and withdraw consent. Submit requests via the contact details below. We may verify identity before action.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '11. Cookies & Tracking',
                text:
                    'The current version of the app uses minimal tracking. Future web or hybrid versions may introduce cookies or local storage for preferences or analytics; such use will be updated here.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '12. Changes to this Policy',
                text:
                    'We may update this Privacy Policy. Material changes will be communicated (e.g., in‑app notice). Continued use after changes indicates acceptance of the revised Policy.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _PrivacySection(
                title: '13. Contact',
                text:
                    'For privacy inquiries or rights requests contact: privacy@example.com (placeholder). Include sufficient detail for us to respond.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  border: Border.all(color: Colors.blueGrey.shade100),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Sample Privacy Policy for demonstration only. Replace with vetted legal text before production release.',
                  style: bodyStyle?.copyWith(
                    fontSize: 12,
                    color: Colors.blueGrey.shade800,
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

class _PrivacySection extends StatelessWidget {
  final String title;
  final String text;
  final TextStyle? headingStyle;
  final TextStyle? bodyStyle;
  const _PrivacySection({
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
