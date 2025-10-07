import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
              Text(
                'Terms Of Service',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Last updated: October 7, 2025',
                style: bodyStyle?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 28),
              _TosSection(
                title: '1. Introduction',
                text:
                    'These Terms of Service ("Terms") govern your access to and use of the application. By accessing or using the app you agree to be bound by these Terms. If you do not agree, you must discontinue use.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '2. Eligibility',
                text:
                    'You represent that you are at least the age of majority in your jurisdiction or have consent from a parent or guardian. You are responsible for ensuring use complies with local laws.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '3. Accounts',
                text:
                    'Certain features may require an account. You agree to provide accurate information and to keep your credentials secure. You are responsible for activities under your account.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '4. Acceptable Use',
                text:
                    'You agree not to (a) misuse, reverse engineer, overload, or disrupt the service; (b) upload malicious code; (c) infringe intellectual property; (d) harass or abuse others; or (e) attempt unauthorized access to data or systems.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '5. User Content',
                text:
                    'You retain rights to content you submit. By submitting, you grant a non‑exclusive, worldwide, royalty‑free license to store, display, and process that content solely to operate and improve the service. You affirm you have necessary rights.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '6. Intellectual Property',
                text:
                    'All trademarks, logos, and software are owned by us or our licensors. Except for the limited license to use the app, no rights are transferred to you.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '7. Third‑Party Services',
                text:
                    'The app may integrate third‑party APIs or content. Their terms and privacy policies govern your use of those components. We are not responsible for third‑party actions.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '8. Privacy',
                text:
                    'Your use is also governed by our Privacy Policy (available in the Legal section). Please review it to understand data collection and processing practices.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '9. Disclaimer of Warranties',
                text:
                    'The service is provided on an “AS IS” and “AS AVAILABLE” basis without warranties of any kind, express or implied. We do not guarantee uninterrupted, secure, or error‑free operation.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '10. Limitation of Liability',
                text:
                    'To the maximum extent permitted by law, we shall not be liable for indirect, incidental, special, consequential, or punitive damages, or any loss of data, profits, or goodwill.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '11. Indemnification',
                text:
                    'You agree to indemnify and hold harmless the company and its affiliates from claims arising out of your misuse of the service or violation of these Terms.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '12. Suspension & Termination',
                text:
                    'We may suspend or terminate access immediately for violations, security risks, or legal compliance. You may stop using the service at any time.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '13. Changes to Terms',
                text:
                    'We may modify these Terms. Material changes will be communicated (e.g., in‑app notice). Continued use after changes constitutes acceptance.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '14. Governing Law',
                text:
                    'These Terms are governed by the laws of your primary operating jurisdiction, excluding conflict of laws rules, unless a mandatory local law applies.',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              _TosSection(
                title: '15. Contact',
                text:
                    'Questions about these Terms can be directed to support@example.com (placeholder).',
                headingStyle: headingStyle,
                bodyStyle: bodyStyle,
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  border: Border.all(color: Colors.amber.shade200),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Sample Terms for demonstration only. Replace with vetted legal text before production release.',
                  style: bodyStyle?.copyWith(
                    fontSize: 12,
                    color: Colors.amber.shade900,
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

class _TosSection extends StatelessWidget {
  final String title;
  final String text;
  final TextStyle? headingStyle;
  final TextStyle? bodyStyle;
  const _TosSection({
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
