import 'package:flutter/material.dart';

class AppLanguageScreen extends StatefulWidget {
  const AppLanguageScreen({super.key});

  @override
  State<AppLanguageScreen> createState() => _AppLanguageScreenState();
}

class _AppLanguageScreenState extends State<AppLanguageScreen> {
  bool _isIrish = false; // false = English, true = Gaeilge

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false, // ensure consistent 80px custom padding
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
                'App Language',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 32),
              _LanguageSwitch(
                isIrish: _isIrish,
                onChanged: (v) => setState(() => _isIrish = v),
              ),
              const SizedBox(height: 12),
              Text(
                'Current: ' +
                    (_isIrish ? 'Gaeilge' : 'English') +
                    ' (no functionality yet)',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageSwitch extends StatelessWidget {
  final bool isIrish;
  final ValueChanged<bool> onChanged;
  const _LanguageSwitch({required this.isIrish, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1.2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'English',
              style: TextStyle(
                fontWeight: isIrish ? FontWeight.w400 : FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Switch(value: isIrish, onChanged: onChanged),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Gaeilge',
                style: TextStyle(
                  fontWeight: isIrish ? FontWeight.w600 : FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
