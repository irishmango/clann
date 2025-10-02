import 'dart:math';
import 'package:flutter/material.dart';
import 'package:clann/src/features/quiz/domain/quiz_question.dart';
import 'package:clann/src/features/quiz/presentation/widgets/quiz_check_button.dart';
import 'package:clann/theme.dart';

class PairMatchQuestionWidget extends StatefulWidget {
  final PairMatchQuestion question;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onFinish;
  const PairMatchQuestionWidget({
    super.key,
    required this.question,
    required this.isLast,
    required this.onNext,
    required this.onFinish,
  });

  @override
  State<PairMatchQuestionWidget> createState() =>
      _PairMatchQuestionWidgetState();
}

class _PairMatchQuestionWidgetState extends State<PairMatchQuestionWidget>
    with SingleTickerProviderStateMixin {
  late List<_PairItem> _items; // mixed ga/en
  int? _firstIndex; // index of first selection
  bool _locked =
      false; // when all matched, lock & show check button as finish/next
  // Track transient wrong flashes
  Set<int> _wrongFlash = {};

  @override
  void initState() {
    super.initState();
    _initItems();
  }

  void _initItems() {
    final q = widget.question;
    final rand = Random();
    final gaItems = [
      for (int i = 0; i < q.length; i++)
        _PairItem(text: q.ga[i], pairIndex: i, isGa: true),
    ];
    final enItems = [
      for (int i = 0; i < q.length; i++)
        _PairItem(text: q.en[i], pairIndex: i, isGa: false),
    ];
    final combined = [...gaItems, ...enItems];
    combined.shuffle(rand);
    _items = combined;
  }

  void _handleTap(int i) {
    if (_locked) return;
    final item = _items[i];
    if (item.matched) return;
    if (_firstIndex == null) {
      setState(() => _firstIndex = i);
      return;
    }
    if (_firstIndex == i) {
      // deselect
      setState(() => _firstIndex = null);
      return;
    }
    final first = _items[_firstIndex!];
    // Must be different language and pairIndex same
    if (first.pairIndex == item.pairIndex && first.isGa != item.isGa) {
      setState(() {
        _items[_firstIndex!] = first.copyWith(matched: true);
        _items[i] = item.copyWith(matched: true);
        _firstIndex = null;
        if (_items.every((e) => e.matched)) {
          _locked = true;
        }
      });
    } else {
      // wrong attempt -> flash red for both then reset selection
      final wrongA = _firstIndex!;
      final wrongB = i;
      setState(() {
        _wrongFlash.addAll([wrongA, wrongB]);
        _firstIndex = null;
      });
      Future.delayed(const Duration(milliseconds: 450), () {
        if (!mounted) return;
        setState(() {
          _wrongFlash.remove(wrongA);
          _wrongFlash.remove(wrongB);
        });
      });
    }
  }

  void _onCheck() {
    if (!_items.every((e) => e.matched)) return; // safety
    if (widget.isLast) {
      widget.onFinish();
    } else {
      widget.onNext();
    }
  }

  Color _colorFor(int index) {
    final item = _items[index];
    if (item.matched) return AppColors.primary; // green
    if (_wrongFlash.contains(index)) return AppColors.error; // red flash
    if (_firstIndex == index) return AppColors.info; // selected state highlight
    return Colors.grey.shade300; // default
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
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final double spacing = 12;
            final double maxWidth = constraints.maxWidth;
            final double tileWidth = (maxWidth - spacing) / 2; // 2 columns
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (int i = 0; i < _items.length; i++)
                  SizedBox(
                    width: tileWidth,
                    child: _PairTile(
                      item: _items[i],
                      color: _colorFor(i),
                      onTap: () => _handleTap(i),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 28),
        QuizCheckButton(
          enabled: _items.every((e) => e.matched),
          isChecked: _locked,
          showFinish: _locked && widget.isLast,
          onTap: _onCheck,
        ),
      ],
    );
  }
}

class _PairItem {
  final String text;
  final int pairIndex; // link between ga/en
  final bool isGa; // whether this is an Irish word
  final bool matched;
  const _PairItem({
    required this.text,
    required this.pairIndex,
    required this.isGa,
    this.matched = false,
  });
  _PairItem copyWith({bool? matched}) => _PairItem(
    text: text,
    pairIndex: pairIndex,
    isGa: isGa,
    matched: matched ?? this.matched,
  );
}

class _PairTile extends StatelessWidget {
  final _PairItem item;
  final Color color;
  final VoidCallback onTap;
  const _PairTile({
    required this.item,
    required this.color,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Center(
          child: Text(
            item.text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
