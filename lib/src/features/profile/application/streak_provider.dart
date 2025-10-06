import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Represents a 7-day streak ending today (index 6 = today).
class StreakState {
  final List<bool> days; // length 7
  const StreakState(this.days)
    : assert(days.length == 7, 'Need exactly 7 days');

  int get currentStreak {
    int count = 0;
    for (int i = days.length - 1; i >= 0; i--) {
      if (days[i]) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  StreakState copyWith({List<bool>? days}) => StreakState(days ?? this.days);
}

class StreakNotifier extends Notifier<StreakState> {
  @override
  StreakState build() => StreakState(List<bool>.filled(7, false));

  void setDay(int index, bool value) {
    if (index < 0 || index >= 7) return;
    final newDays = List<bool>.from(state.days);
    newDays[index] = value;
    state = StreakState(newDays);
  }

  void markTodayComplete() => setDay(6, true);

  void reset() => state = StreakState(List<bool>.filled(7, false));
}

final streakProvider = NotifierProvider<StreakNotifier, StreakState>(
  StreakNotifier.new,
);
