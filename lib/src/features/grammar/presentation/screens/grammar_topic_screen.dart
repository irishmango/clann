import 'package:flutter/material.dart';
import 'package:clann/theme.dart';
import 'package:clann/src/shared/mode_switch.dart';

class GrammarTopicScreen extends StatefulWidget {
  const GrammarTopicScreen({super.key});

  @override
  State<GrammarTopicScreen> createState() => _GrammarTopicScreenState();
}

class _GrammarTopicScreenState extends State<GrammarTopicScreen> {
  bool _isPractice = false; // false = Reading Material, true = Practice

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _HeaderBanner(),
            const SizedBox(height: 12),
            // Centered ModeSwitch row
            ModeSwitch(
              selectedIndex: _isPractice ? 1 : 0,
              onChanged: (i) => setState(() => _isPractice = i == 1),
              leftLabel: 'Reading Material',
              rightLabel: 'Practice',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: _isPractice
                    ? const _PracticeView()
                    : const _ReadingView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 60,
            left: 8,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 22,
              ),
              tooltip: 'Back',
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          const Positioned(
            left: 24,
            bottom: 36,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Grammar',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.0,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tenses',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadingView extends StatelessWidget {
  const _ReadingView();

  @override
  Widget build(BuildContext context) {
    // Placeholder reading material blocks
    final items = List.generate(5, (i) => 'Reading Section ${i + 1}');
    return ListView.builder(
      key: const ValueKey('reading'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      itemCount: items.length,
      itemBuilder: (context, index) => Container(
        height: 90,
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomLeft,
        child: Text(
          items[index],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _PracticeView extends StatelessWidget {
  const _PracticeView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      key: const ValueKey('practice'),
      padding: const EdgeInsets.symmetric(vertical: 4),
      children: const [
        _PracticeSection(
          title: 'Flashcards',
          itemLabels: ['Basics', 'Examples', 'Drill'],
          icon: Icons.style,
        ),
        SizedBox(height: 28),
        _PracticeSection(
          title: 'Quizzes',
          itemLabels: ['Quick Quiz', 'Challenge', 'Mastery'],
          icon: Icons.quiz,
        ),
      ],
    );
  }
}

class _PracticeSection extends StatelessWidget {
  const _PracticeSection({
    required this.title,
    required this.itemLabels,
    required this.icon,
  });

  final String title;
  final List<String> itemLabels;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.black87),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 16),
              for (final label in itemLabels) ...[
                _PracticeCard(label: label),
                const SizedBox(width: 14),
              ],
              const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class _PracticeCard extends StatelessWidget {
  const _PracticeCard({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 140,
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFFFFE8C8),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        alignment: Alignment.bottomLeft,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    );
  }
}
