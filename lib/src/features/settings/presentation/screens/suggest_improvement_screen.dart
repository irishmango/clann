import 'package:flutter/material.dart';

class SuggestImprovementScreen extends StatefulWidget {
  const SuggestImprovementScreen({super.key});

  @override
  State<SuggestImprovementScreen> createState() =>
      _SuggestImprovementScreenState();
}

class _SuggestImprovementScreenState extends State<SuggestImprovementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _suggestionController = TextEditingController();
  final _contactController = TextEditingController();
  static const int _maxChars = 800;

  @override
  void dispose() {
    _suggestionController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // Placeholder submit logic; integrate with backend or email later.
    final suggestion = _suggestionController.text.trim();
    final contact = _contactController.text.trim();
    debugPrint(
      'Suggestion submitted: suggestion="$suggestion" contact=$contact',
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Thank you for your feedback!'),
          duration: Duration(seconds: 2),
        ),
      );
    setState(() {
      _suggestionController.clear();
      _contactController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key: _formKey,
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
                  'Suggest An Improvement',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _suggestionController,
                  maxLines: 8,
                  maxLength: _maxChars,
                  decoration: const InputDecoration(
                    labelText: 'Your suggestion',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    hintText:
                        'Describe the improvement you would like to see...',
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty)
                      return 'Enter a suggestion';
                    if (v.trim().length < 10)
                      return 'Please provide a bit more detail';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _contactController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Contact (optional)',
                    hintText: 'Email if you want a follow-up',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    if (!emailRegex.hasMatch(v.trim())) return 'Invalid email';
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _submit,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Submissions are not yet sent anywhere (demo only).',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
