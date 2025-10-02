import 'package:clann/src/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

// A more engaging Learn screen with a grid of lesson/module cards and animated transitions.

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  Route _fadeThroughRoute(Widget page) => PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lessons = <_LessonMeta>[
      _LessonMeta(
        title: 'Practice Quiz',
        subtitle: 'Test yourself',
        icon: Icons.checklist_outlined,
        progress: 0.0,
        isQuiz: true,
      ),
    ];

    return Stack(
      children: [
        Container(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Learn', style: theme.textTheme.displayMedium),
                const SizedBox(height: 6),
                Text(
                  'Build up your Irish step by step',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final twoColumn = width > 520; // adapt columns
                      final crossAxisCount = twoColumn ? 2 : 1;
                      return GridView.builder(
                        itemCount: lessons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          // Slightly smaller aspect ratio => taller cards to avoid overflow
                          childAspectRatio: twoColumn ? 1.6 : 2.1,
                        ),
                        itemBuilder: (context, index) {
                          final m = lessons[index];
                          return _LessonCard(
                            meta: m,
                            onTap: () {
                              if (m.isQuiz) {
                                Navigator.of(
                                  context,
                                ).push(_fadeThroughRoute(const QuizScreen()));
                              } else {
                                // Placeholder for lesson route
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Open lesson: ${m.title}'),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LessonMeta {
  final String title;
  final String subtitle;
  final IconData icon;
  final double progress; // 0..1
  final bool isQuiz;
  const _LessonMeta({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.progress,
    this.isQuiz = false,
  });
}

class _LessonCard extends StatelessWidget {
  final _LessonMeta meta;
  final VoidCallback onTap;
  const _LessonCard({required this.meta, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = AppColors.primary;
    return OpenContainer(
      closedElevation: 0,
      openElevation: 0,
      transitionDuration: const Duration(milliseconds: 450),
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      openShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      closedColor: Colors.white,
      openColor: Colors.white,
      tappable: false,
      openBuilder: (context, _) {
        // For quiz card open actual quiz; for lessons show placeholder page
        if (meta.isQuiz) {
          return const QuizScreen();
        }
        return _LessonPlaceholderScreen(meta: meta);
      },
      closedBuilder: (context, open) {
        return InkWell(
          onTap: () => meta.isQuiz ? open() : onTap(),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: accent.withAlpha(25),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(meta.icon, color: accent, size: 30),
                    ),
                    const Spacer(),
                    _ProgressBadge(
                      progress: meta.progress,
                      isQuiz: meta.isQuiz,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  meta.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  meta.subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                if (!meta.isQuiz)
                  LinearProgressIndicator(
                    value: meta.progress,
                    minHeight: 6,
                    backgroundColor: Colors.black12,
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(6),
                  )
                else
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Start →',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: accent,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProgressBadge extends StatelessWidget {
  final double progress;
  final bool isQuiz;
  const _ProgressBadge({required this.progress, required this.isQuiz});
  @override
  Widget build(BuildContext context) {
    if (isQuiz) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withAlpha(40),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.black, width: 1.2),
        ),
        child: const Text(
          'Quiz',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }
    final pct = (progress * 100).round();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(25),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.black, width: 1.2),
      ),
      child: Text('$pct%', style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _LessonPlaceholderScreen extends StatelessWidget {
  final _LessonMeta meta;
  const _LessonPlaceholderScreen({required this.meta});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meta.title)),
      body: Center(
        child: Text(
          'Lesson "${meta.title}" content coming soon',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
