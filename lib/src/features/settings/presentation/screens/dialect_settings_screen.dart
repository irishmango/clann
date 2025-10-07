import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class DialectSettingsScreen extends StatefulWidget {
  const DialectSettingsScreen({super.key});

  @override
  State<DialectSettingsScreen> createState() => _DialectSettingsScreenState();
}

class _DialectSettingsScreenState extends State<DialectSettingsScreen> {
  final List<String> _dialects = const [
    'Connacht',
    'Munster',
    'Ulster',
    'Leinster',
  ];
  String _selected = 'Connacht';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false, // we'll control the 80px ourselves
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
              const SizedBox(height: 32),
              ..._dialects.map(
                (d) => _DialectTile(
                  label: d,
                  selected: d == _selected,
                  onTap: () => setState(() => _selected = d),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Selected: $_selected (no functionality yet)',
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

class _DialectTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _DialectTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withAlpha(30) : Colors.white,
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
