import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _stepsController = TextEditingController();
  final _expectedController = TextEditingController();
  final _actualController = TextEditingController();
  final _contactController = TextEditingController();
  XFile? _screenshot;
  bool _submitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _stepsController.dispose();
    _expectedController.dispose();
    _actualController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _pickScreenshot() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(
      source: ImageSource.gallery,
    ); // Could add camera option later.
    if (img != null) {
      setState(() => _screenshot = img);
    }
  }

  void _removeScreenshot() {
    setState(() => _screenshot = null);
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _submitting = true);
    await Future.delayed(
      const Duration(milliseconds: 600),
    ); // Simulated network latency
    final title = _titleController.text.trim();
    final steps = _stepsController.text.trim();
    final expected = _expectedController.text.trim();
    final actual = _actualController.text.trim();
    final contact = _contactController.text.trim();
    debugPrint(
      'Bug Report Submitted: title="$title" steps="$steps" expected="$expected" actual="$actual" contact="$contact" screenshot=${_screenshot?.path}',
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Problem report submitted (demo only).'),
          duration: Duration(seconds: 2),
        ),
      );
    setState(() {
      _submitting = false;
      _titleController.clear();
      _stepsController.clear();
      _expectedController.clear();
      _actualController.clear();
      _contactController.clear();
      _screenshot = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                'Report A Problem',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Short title',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. Crash when opening dictionary',
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty)
                    return 'Provide a brief title';
                  if (v.trim().length < 4) return 'Too short';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _stepsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Steps to reproduce',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  hintText: '1. Open app\n2. Tap ...\n3. Observe crash',
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'List the steps' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _expectedController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Expected behavior',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Describe expected behavior'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _actualController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Actual behavior',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Describe actual behavior'
                    : null,
              ),
              const SizedBox(height: 28),
              Text(
                'Screenshot (optional)',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              if (_screenshot == null)
                OutlinedButton.icon(
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text('Add Screenshot'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                  ),
                  onPressed: _pickScreenshot,
                )
              else
                _ScreenshotPreview(
                  file: _screenshot!,
                  onRemove: _removeScreenshot,
                ),
              const SizedBox(height: 28),
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Contact (optional)',
                  hintText: 'Email if you want follow-up',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                  if (!emailRegex.hasMatch(v.trim())) return 'Invalid email';
                  return null;
                },
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submitting ? null : _submit,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: _submitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
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
                'Reports are not yet sent anywhere (demo only).',
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

class _ScreenshotPreview extends StatelessWidget {
  final XFile file;
  final VoidCallback onRemove;
  const _ScreenshotPreview({required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(file.path),
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Replace'),
              onPressed: onRemove, // Removing allows re-adding
            ),
            const SizedBox(width: 12),
            TextButton.icon(
              icon: const Icon(Icons.delete_outline),
              label: const Text('Remove'),
              onPressed: onRemove,
            ),
          ],
        ),
      ],
    );
  }
}
