import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _schoolController = TextEditingController();
  final List<String> _levels = const [
    'Primary School',
    'Secondary School',
    'Third Level',
    'Hobbyist',
    'Gaeilgeoir',
  ];
  String? _selectedLevel;
  bool _obscurePassword = true;

  // Dummy account data (placeholder until real persistence layer is added)
  static const _dummyAccount = {
    'name': 'Aoife Ní Mháirtín',
    'email': 'aoife@example.com',
    'school': 'Coláiste na Tríonóide',
    'level': 'Third Level',
    // Intentionally no stored password; users usually re-enter when changing.
  };

  @override
  void initState() {
    super.initState();
    // Prefill controllers with dummy data.
    _nameController.text = _dummyAccount['name']!;
    _emailController.text = _dummyAccount['email']!;
    _schoolController.text = _dummyAccount['school']!;
    _selectedLevel = _dummyAccount['level'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      // In a future iteration, persist these values to backend / local store.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Account details saved'),
            duration: Duration(seconds: 2),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600);
    return Scaffold(
      body: SafeArea(
        top:
            false, // ensure total visual offset is exactly the 80px we add below
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
                  'Account',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 32),
                Text('Profile', style: titleStyle),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Enter your name'
                      : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty)
                      return 'Enter your email';
                    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    if (!emailRegex.hasMatch(v.trim())) return 'Invalid email';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter a password';
                    if (v.length < 6) return 'Min 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 6),
                Text(
                  'Password not pre-filled for security. Enter a new one to change.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 32),
                Text('Education', style: titleStyle),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _schoolController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'School / Institution',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Enter your school / institution'
                      : null,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedLevel,
                  decoration: const InputDecoration(
                    labelText: 'Level',
                    border: OutlineInputBorder(),
                  ),
                  items: _levels
                      .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedLevel = v),
                  validator: (v) => v == null ? 'Select a level' : null,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _save,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
