import 'package:clann/theme.dart';
import 'package:flutter/material.dart';
import 'account_settings_screen.dart';
import 'app_language_screen.dart';
import 'dialect_settings_screen.dart';
import 'display_mode_screen.dart';
import 'suggest_improvement_screen.dart';
import 'report_problem_screen.dart';
import 'terms_of_service_screen.dart';
import 'privacy_policy_screen.dart';
import 'cookies_policy_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 44,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "General",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SettingsTile(
                label: "Account",
                onTap: () => _open(context, const AccountSettingsScreen()),
              ),
              SettingsTile(
                label: "App Language",
                onTap: () => _open(context, const AppLanguageScreen()),
              ),
              SettingsTile(
                label: "Dialect",
                onTap: () => _open(context, const DialectSettingsScreen()),
              ),
              SettingsTile(
                label: "Display Mode",
                onTap: () => _open(context, const DisplayModeScreen()),
              ),
              SettingsTile(
                label: "Invite Friends",
                onTap: () => _comingSoon(context),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Help",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SettingsTile(
                label: "Suggest An Improvement",
                onTap: () => _open(context, const SuggestImprovementScreen()),
              ),
              SettingsTile(
                label: "Report A Problem",
                onTap: () => _open(context, const ReportProblemScreen()),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Legal",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SettingsTile(
                label: "Terms Of Service",
                onTap: () => _open(context, const TermsOfServiceScreen()),
              ),
              SettingsTile(
                label: "Privacy",
                onTap: () => _open(context, const PrivacyPolicyScreen()),
              ),
              SettingsTile(
                label: "Cookies",
                onTap: () => _open(context, const CookiesPolicyScreen()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Version",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: AppColors.grey400,
                      ),
                    ),
                    Text(
                      "1.0.0.0",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: AppColors.grey400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 76),
          Column(
            children: [
              SettingsTile(label: "Log Out", onTap: () => _comingSoon(context)),
              SettingsTile(
                label: "Delete Account",
                isImportant: true,
                onTap: () => _comingSoon(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _open(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
}

void _comingSoon(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      const SnackBar(
        content: Text('Function coming soon'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
}

class SettingsTile extends StatelessWidget {
  final String label;
  final bool isImportant;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.label,
    this.isImportant = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = isImportant
        ? Text(
            label,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w300,
              color: AppColors.error,
            ),
          )
        : Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w300),
          );

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: AppColors.grey300),
          ),
        ),
        child: textWidget,
      ),
    );
  }
}
