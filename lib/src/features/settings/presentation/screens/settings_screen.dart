import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

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
              SettingsTile(label: "Account"),
              SettingsTile(label: "App Language"),
              SettingsTile(label: "Dialect"),
              SettingsTile(label: "Display Mode"),
              SettingsTile(label: "Invite Friends"),
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
              SettingsTile(label: "Suggest An Improvement"),
              SettingsTile(label: "Report A Problem"),
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
              SettingsTile(label: "Terms Of Service"),
              SettingsTile(label: "Privacy"),
              SettingsTile(label: "Cookies"),
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
              SettingsTile(label: "Log Out"),
              SettingsTile(label: "Delete Account", isImportant: true),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String label;
  final bool isImportant;

  const SettingsTile({
    super.key,
    required this.label,
    this.isImportant = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: AppColors.grey300)),
      ),
      child: isImportant
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
            ),
    );
  }
}
