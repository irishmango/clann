import 'package:clann/src/features/quiz/domain/quiz_question.dart';
import 'package:clann/src/features/quiz/presentation/widgets/quiz_check_button.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

// Internal drag payload allowing differentiation between new word and reorder.
class _DragPayload {
  final String word;
  final int? fromIndex; // null when coming from bank
  const _DragPayload(this.word, this.fromIndex);
}

class DragAndDropQuestionWidget extends StatefulWidget {
  final DragAndDropQuestion question;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onFinish;
  const DragAndDropQuestionWidget({
    super.key,
    required this.question,
    required this.isLast,
    required this.onNext,
    required this.onFinish,
  });

  @override
  State<DragAndDropQuestionWidget> createState() =>
      _DragAndDropQuestionWidgetState();
}

class _DragAndDropQuestionWidgetState extends State<DragAndDropQuestionWidget> {
  late List<String> _chosen;
  bool _checked = false;

  List<String> get _bank => widget.question.words
      .where((w) => !_chosen.contains(w))
      .toList(growable: false);

  @override
  void initState() {
    super.initState();
    _chosen = [];
  }

  void _resetLocal() {
    setState(() {
      _chosen.clear();
      _checked = false;
    });
  }

  void _onCheck() {
    if (_chosen.isEmpty) return;
    if (_checked) {
      if (widget.isLast) {
        widget.onFinish();
      } else {
        _resetLocal();
        widget.onNext();
      }
    } else {
      setState(() => _checked = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.question;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          q.prompt,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        _AnswerArea(
          chosen: _chosen,
          correctOrder: q.correctOrder,
          isChecked: _checked,
          onRemove: (i) {
            if (_checked) return;
            setState(() => _chosen.removeAt(i));
          },
          onInsertAt: (index, word) {
            if (_checked) return;
            setState(() => _chosen.insert(index, word));
          },
          onReorder: (from, to) {
            if (_checked) return;
            if (from == to || from < 0 || from >= _chosen.length) return;
            setState(() {
              final w = _chosen.removeAt(from);
              var insertIndex = to;
              if (from < to) insertIndex -= 1;
              if (insertIndex < 0) insertIndex = 0;
              if (insertIndex > _chosen.length) insertIndex = _chosen.length;
              _chosen.insert(insertIndex, w);
            });
          },
        ),
        const SizedBox(height: 20),
        _WordBank(words: _bank, disabled: _checked),
        const SizedBox(height: 32),
        QuizCheckButton(
          enabled: _chosen.isNotEmpty,
          isChecked: _checked,
          showFinish: _checked && widget.isLast,
          onTap: _onCheck,
        ),
      ],
    );
  }
}

class _WordBank extends StatelessWidget {
  const _WordBank({required this.words, required this.disabled});
  final List<String> words;
  final bool disabled;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        for (final w in words)
          Draggable<_DragPayload>(
            data: _DragPayload(w, null),
            feedback: _Chip(word: w),
            childWhenDragging: Opacity(opacity: 0.3, child: _Chip(word: w)),
            maxSimultaneousDrags: disabled ? 0 : 1,
            child: _Chip(word: w),
          ),
      ],
    );
  }
}

class _AnswerArea extends StatelessWidget {
  const _AnswerArea({
    required this.chosen,
    required this.correctOrder,
    required this.isChecked,
    required this.onRemove,
    required this.onInsertAt,
    required this.onReorder,
  });
  final List<String> chosen;
  final List<String> correctOrder;
  final bool isChecked;
  final void Function(int) onRemove;
  final void Function(int index, String word) onInsertAt;
  final void Function(int from, int to) onReorder;

  @override
  Widget build(BuildContext context) {
    final maxLen = correctOrder.length;
    final canAddMore = chosen.length < maxLen;

    List<Widget> children = [];

    Widget buildInsertionTarget(int insertIndex) {
      return DragTarget<_DragPayload>(
        onWillAcceptWithDetails: (details) {
          final data = details.data;
          if (isChecked) return false;
          if (data == null) return false;
          if (data.fromIndex == null) {
            return canAddMore; // new word from bank
          }
          return true; // always allow reorder
        },
        onAcceptWithDetails: (details) {
          final data = details.data;
          if (data.fromIndex == null) {
            if (chosen.contains(data.word)) return; // safety
            if (chosen.length >= maxLen) return;
            onInsertAt(insertIndex, data.word);
          } else {
            onReorder(data.fromIndex!, insertIndex);
          }
        },
        builder: (context, cand, rej) {
          final active = cand.isNotEmpty;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: 10,
            height: 32,
            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            decoration: BoxDecoration(
              color: active
                  ? AppColors.primary.withOpacity(0.5)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        },
      );
    }

    if (chosen.isEmpty) {
      children.add(buildInsertionTarget(0));
      children.add(
        Text('Drag words here', style: Theme.of(context).textTheme.bodyMedium),
      );
    } else {
      for (int i = 0; i < chosen.length; i++) {
        children.add(buildInsertionTarget(i));
        final word = chosen[i];
        children.add(
          Draggable<_DragPayload>(
            data: _DragPayload(word, i),
            feedback: _Chip(word: word),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: _AnswerChip(
                text: word,
                borderColor: isChecked
                    ? (word == correctOrder[i]
                          ? AppColors.primary
                          : AppColors.error)
                    : Colors.black,
                onRemove: () => onRemove(i),
                enabled: !isChecked,
              ),
            ),
            child: _AnswerChip(
              text: word,
              borderColor: isChecked
                  ? (word == correctOrder[i]
                        ? AppColors.primary
                        : AppColors.error)
                  : Colors.black,
              onRemove: () => onRemove(i),
              enabled: !isChecked,
            ),
          ),
        );
      }
      children.add(buildInsertionTarget(chosen.length));
    }

    return Container(
      padding: const EdgeInsets.all(0),
      child: DragTarget<_DragPayload>(
        onWillAcceptWithDetails: (details) {
          final data = details.data;
          return !isChecked && data != null;
        },
        onAcceptWithDetails: (details) {
          final data = details.data;
          if (isChecked) return;
          final endIndex = chosen.length;
          if (data.fromIndex == null) {
            if (chosen.length >= maxLen) return;
            onInsertAt(endIndex, data.word);
          } else {
            onReorder(data.fromIndex!, endIndex);
          }
        },
        builder: (context, cand, rej) => Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(153),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black26),
          ),
          child: Wrap(
            spacing: 6,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }
}

class _AnswerChip extends StatelessWidget {
  const _AnswerChip({
    required this.text,
    required this.borderColor,
    required this.onRemove,
    required this.enabled,
  });
  final String text;
  final Color borderColor;
  final VoidCallback onRemove;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onRemove : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(
            top: BorderSide(color: borderColor),
            left: BorderSide(color: borderColor),
            right: BorderSide(color: borderColor),
            bottom: BorderSide(color: borderColor, width: 2),
          ),
        ),
        child: Text(text, style: Theme.of(context).textTheme.titleSmall),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.word});
  final String word;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: const Border(
            top: BorderSide(color: Colors.black),
            left: BorderSide(color: Colors.black),
            right: BorderSide(color: Colors.black),
            bottom: BorderSide(color: Colors.black, width: 2),
          ),
        ),
        child: Text(word, style: Theme.of(context).textTheme.titleSmall),
      ),
    );
  }
}
