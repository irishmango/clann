import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class DisplayModeScreen extends StatefulWidget {
  const DisplayModeScreen({super.key});

  @override
  State<DisplayModeScreen> createState() => _DisplayModeScreenState();
}

enum _DisplayMode { light, dark, system }

class _DisplayModeScreenState extends State<DisplayModeScreen> {
  _DisplayMode _selected = _DisplayMode.system;

  String _labelFor(_DisplayMode m) {
    switch (m) {
      case _DisplayMode.light:
        return 'Light Mode';
      case _DisplayMode.dark:
        return 'Dark Mode';
      case _DisplayMode.system:
        return 'Use System Setting';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false, // custom 80px padding below
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
                'Display Mode',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 32),
              _ModeRadioTile(
                label: _labelFor(_DisplayMode.light),
                value: _DisplayMode.light,
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v!),
              ),
              _ModeRadioTile(
                label: _labelFor(_DisplayMode.dark),
                value: _DisplayMode.dark,
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v!),
              ),
              _ModeRadioTile(
                label: _labelFor(_DisplayMode.system),
                value: _DisplayMode.system,
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v!),
              ),
              const SizedBox(height: 20),
              Text(
                'Selected: ' + _labelFor(_selected) + ' (no functionality yet)',
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

class _ModeRadioTile extends StatelessWidget {
  final String label;
  final _DisplayMode value;
  final _DisplayMode groupValue;
  final ValueChanged<_DisplayMode?> onChanged;
  const _ModeRadioTile({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: selected ? AppColors.primary : Colors.grey.shade400,
            width: 1.4,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.primary : Colors.grey.shade600,
                  width: 2,
                ),
                color: selected ? AppColors.primary : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
