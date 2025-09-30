import 'package:clann/src/features/quiz/presentation/widgets/quiz_check_button.dart';
import 'package:flutter/material.dart';
import 'package:clann/theme.dart';
import 'package:clann/src/features/quiz/presentation/screens/results_screen.dart';

/// Drag & drop quiz screen for sentence construction.
/// Usage:
/// Navigator.push(context, MaterialPageRoute(
///   builder: (_) => DragAndDropQuizScreen(
///     prompt: 'Construct this sentence',
///     words: const ['mé','an','Chonaic','car'],
///     correctOrder: const ['Chonaic','mé','an','car'],
///     isLastQuestion: false,
///   ),
/// ));
class DragAndDropQuizScreen extends StatefulWidget {
  const DragAndDropQuizScreen({
    super.key,
    required this.prompt,
    required this.words,
    required this.correctOrder,
    this.isLastQuestion = false,
  });

  final String prompt;
  final List<String> words; // word bank (shuffled)
  final List<String> correctOrder; // expected order
  final bool isLastQuestion;

  @override
  State<DragAndDropQuizScreen> createState() => _DragAndDropQuizScreenState();
}

class _DragAndDropQuizScreenState extends State<DragAndDropQuizScreen> {
  late List<String> _chosen; // words dropped in the answer area (ordered)
  bool _isChecked = false;

  List<String> get _bank =>
      widget.words.where((w) => !_chosen.contains(w)).toList(growable: false);

  @override
  void initState() {
    super.initState();
    _chosen = <String>[];
  }

  void _resetForNext() {
    setState(() {
      _chosen.clear();
      _isChecked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 6),
          borderRadius: BorderRadius.circular(55),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 64,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.close, size: 32),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      widget.prompt,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Divider(color: Colors.black.withOpacity(0.25)),
                    const SizedBox(height: 12),

                    // Answer area (DragTarget)
                    _AnswerArea(
                      chosen: _chosen,
                      correctOrder: widget.correctOrder,
                      isChecked: _isChecked,
                      onRemove: (i) {
                        if (_isChecked) return; // lock after check
                        setState(() => _chosen.removeAt(i));
                      },
                      onAcceptWord: (word) {
                        if (_isChecked) return;
                        if (_chosen.length < widget.correctOrder.length) {
                          setState(() => _chosen.add(word));
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    // Word bank (Draggables)
                    _WordBank(words: _bank, disabled: _isChecked),

                    const SizedBox(height: 32),

                    // Check / Next / Finish
                    QuizCheckButton(
                      enabled: _chosen.isNotEmpty,
                      isChecked: _isChecked,
                      showFinish: _isChecked && widget.isLastQuestion,
                      onTap: () {
                        if (_chosen.isEmpty) return; // disabled state guard
                        if (_isChecked) {
                          if (widget.isLastQuestion) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ResultsScreen(),
                              ),
                            );
                          } else {
                            _resetForNext();
                          }
                        } else {
                          setState(() => _isChecked = true);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
        for (final word in words)
          Draggable<String>(
            data: word,
            feedback: _Chip(word: word),
            childWhenDragging: Opacity(opacity: 0.3, child: _Chip(word: word)),
            maxSimultaneousDrags: disabled ? 0 : 1,
            child: _Chip(word: word),
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
    required this.onAcceptWord,
  });

  final List<String> chosen;
  final List<String> correctOrder;
  final bool isChecked;
  final void Function(int index) onRemove;
  final void Function(String word) onAcceptWord;

  @override
  Widget build(BuildContext context) {
    final bool isComplete = chosen.length == correctOrder.length;

    return DragTarget<String>(
      onWillAccept: (_) => !isChecked && !isComplete,
      onAccept: onAcceptWord,
      builder: (context, candidate, rejects) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black26),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              if (chosen.isEmpty)
                Text(
                  'Drag words here',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              else
                for (int i = 0; i < chosen.length; i++)
                  _AnswerChip(
                    text: chosen[i],
                    borderColor: isChecked
                        ? (chosen[i] == correctOrder[i]
                              ? AppColors.primary
                              : AppColors.error)
                        : Colors.black,
                    onRemove: () => onRemove(i),
                    enabled: !isChecked,
                  ),
            ],
          ),
        );
      },
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
      onTap: enabled ? onRemove : null, // remove before checking
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
