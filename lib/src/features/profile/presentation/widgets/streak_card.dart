import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

/// A card that displays the user's 7-day activity streak.
///
/// Provide [streakDays] as a list of 7 booleans representing whether
/// a lesson/quiz was completed on each of the last 7 days *ending today*.
/// Index 6 (last) is today, index 0 is 6 days ago.
/// (You can adapt this mapping if you prefer Monday-first ordering.)
///
/// The widget will show a fire emoji (🔥) where the user kept the streak,
/// otherwise a subtle placeholder (a faded dot). Today's day can be
/// visually emphasized.
class StreakCard extends StatelessWidget {
  const StreakCard({
    super.key,
    required this.streakDays,
    this.showCount = true,
    this.highlightToday = true,
  }) : assert(streakDays.length == 7, 'streakDays must have length 7');

  /// List of 7 booleans: last 7 days ending today.
  final List<bool> streakDays;

  /// Whether to display a current streak count in the header.
  final bool showCount;

  /// Whether to highlight today's cell with a border/accent.
  final bool highlightToday;

  // Day abbreviations Monday -> Sunday for readability.
  static const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  int get _currentStreakCount {
    // Count contiguous true values from the end (today backwards)
    int count = 0;
    for (int i = streakDays.length - 1; i >= 0; i--) {
      if (streakDays[i]) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.peach,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Streak', style: theme.textTheme.titleLarge),
              if (showCount)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(30),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_currentStreakCount} day${_currentStreakCount == 1 ? '' : 's'}',
                    style: theme.textTheme.labelLarge,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final completed = streakDays[i];
              // Map index to display order: we keep chronological left->right ending today.
              final label = _dayLabels[i];
              final isToday = i == 6; // last index is today
              return _DayCell(
                label: label,
                completed: completed,
                highlight: highlightToday && isToday,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.label,
    required this.completed,
    required this.highlight,
  });

  final String label;
  final bool completed;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withAlpha(140),
            border: highlight
                ? Border.all(color: Colors.black, width: 2)
                : Border.all(color: Colors.black.withAlpha(64), width: 1),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),

        SizedBox(
          height: 24,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: completed
                ? const Text(
                    '🔥',
                    key: ValueKey('fire'),
                    style: TextStyle(fontSize: 20),
                  )
                : Center(
                    key: const ValueKey('placeholder'),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(64),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
