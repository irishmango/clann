import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';
import 'package:clann/src/features/dictionary/data/dummy_dictionary.dart';
import 'package:clann/src/features/dictionary/data/irregular_verb_database.dart';
import 'package:clann/src/features/dictionary/presentation/widgets/conjugator.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  int _selectedIndex = 0;
  String _query = '';
  final TextEditingController _controller = TextEditingController();
  DictionaryEntry? _selectedEntry;
  IrregularVerb? _selectedVerb; // For conjugator mode search selection

  // Computed filtered results based on current query.
  List<DictionaryEntry> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return dummyDictionary.where((e) {
      return e.irish.toLowerCase().contains(q) ||
          e.english.toLowerCase().contains(q);
    }).toList();
  }

  // Default to Main Screen
  // (Legacy navigation helper removed during refactor.)

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
      // Clear selection when typing new query
      _selectedEntry = null;
      if (_selectedIndex == 1) {
        _selectedVerb = null; // Clear verb selection in conjugator mode
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 80.0,
            left: 18.0,
            right: 18.0,
            bottom: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedIndex == 0 ? "Dictionary" : "Conjugator",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerLeft,
                child: _ModeSwitch(
                  selectedIndex: _selectedIndex,
                  onChanged: (i) {
                    if (i == _selectedIndex) return;
                    setState(() {
                      _selectedIndex = i;
                      _selectedEntry = null;
                      _query = '';
                      _controller.clear();
                    });
                  },
                ),
              ),
              const SizedBox(height: 14),
              CustomSearchBar(
                hintText: _selectedIndex == 0
                    ? "Search in Irish or English"
                    : "Search verbs",
                onChanged: _onSearchChanged,
                controller: _controller,
              ),
            ],
          ),
        ),
        // Dictionary content gets standard horizontal padding; conjugator mode manages its own layout.
        if (_selectedIndex == 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: _buildSearchResults(),
          )
        else
          _buildConjugatorMode(),
      ],
    );
  }

  Widget _buildSearchResults() {
    // If an entry is selected, show only its detail; hide the list.
    if (_selectedEntry != null) {
      return _buildEntryDetail(_selectedEntry!);
    }

    if (_query.isEmpty) {
      return const Text(
        "Make a search to get started!",
        style: TextStyle(fontSize: 16),
      );
    }
    final results = _filtered;
    if (results.isEmpty) {
      return Text(
        "No results found for '$_query'",
        style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      );
    }

    // Otherwise show the results list (limited height).
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 260),
      child: ListView.separated(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: results.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final entry = results[index];
          return InkWell(
            onTap: () {
              setState(() {
                _selectedEntry = entry;
                // Clear search bar & query after selection per requirement
                _query = '';
                _controller.clear();
              });
            },
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              title: Text(
                entry.irish,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(entry.english),
              trailing: entry.partOfSpeech.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.peach.withAlpha(153),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Text(
                        entry.partOfSpeech,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEntryDetail(DictionaryEntry entry) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.peach.withAlpha(153),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                entry.irish,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              if (entry.partOfSpeech.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(178),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Text(
                    entry.partOfSpeech,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const Spacer(),
              IconButton(
                tooltip: 'Close',
                onPressed: () => setState(() => _selectedEntry = null),
                icon: const Icon(Icons.close_rounded, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(entry.english, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // ================= Conjugator Mode (Irregular Verb Search) =================
  Widget _buildConjugatorMode() {
    // If a verb has been selected show its conjugations
    if (_selectedVerb != null) {
      return _IrregularVerbConjugator(
        verb: _selectedVerb!,
        onClear: () {
          setState(() {
            _selectedVerb = null;
          });
        },
      );
    }

    // Show search suggestions if user typing
    if (_query.isNotEmpty) {
      final results = _searchIrregularVerbs(_query);
      if (results.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            "No irregular verb found for '$_query'",
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 260),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: results.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final verb = results[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedVerb = verb;
                    _query = '';
                    _controller.clear();
                  });
                },
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    verb.lemma,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(verb.english),
                  trailing: verb.altLemmas.isNotEmpty
                      ? Text(
                          verb.altLemmas.join(', '),
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      );
    }

    // Default placeholder when nothing selected or typed
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: Text(
        'Type an irregular verb (e.g. bí, abair, feic, ith...)',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  List<IrregularVerb> _searchIrregularVerbs(String q) {
    final query = q.toLowerCase();
    return irregularVerbs.where((v) {
      if (v.lemma.toLowerCase().contains(query)) return true;
      for (final alt in v.altLemmas) {
        if (alt.toLowerCase().contains(query)) return true;
      }
      return false;
    }).toList();
  }
}

// ================= Irregular Verb Conjugator Widget =================
class _IrregularVerbConjugator extends StatefulWidget {
  final IrregularVerb verb;
  final VoidCallback onClear;
  const _IrregularVerbConjugator({required this.verb, required this.onClear});

  @override
  State<_IrregularVerbConjugator> createState() =>
      _IrregularVerbConjugatorState();
}

class _IrregularVerbConjugatorState extends State<_IrregularVerbConjugator> {
  int _selectedTenseIndex = 0;
  late final List<IrishTense> _tensesOrder = [
    IrishTense.present,
    IrishTense.past,
    IrishTense.future,
    IrishTense.conditional,
    IrishTense.imperative,
    IrishTense.verbalNoun,
    IrishTense.verbalAdjective,
  ].where((t) => widget.verb.forms.containsKey(t)).toList();

  @override
  Widget build(BuildContext context) {
    final tense = _tensesOrder[_selectedTenseIndex];
    final data = _buildConjugationData(widget.verb, tense);
    const horizontalPad = 18.0;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPad),
            child: Row(
              children: [
                Text(
                  widget.verb.lemma,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.peach.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Text(
                    widget.verb.english,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'Close',
                  onPressed: widget.onClear,
                  icon: const Icon(Icons.close_rounded, size: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Full-bleed tense chips (no horizontal padding)
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              // Left padding per requirement; right side still bleeds
              padding: const EdgeInsets.only(left: 18),
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: _tensesOrder.length,
              itemBuilder: (context, index) {
                final t = _tensesOrder[index];
                final label = _tenseTitle(t).split('(').first.trim();
                final selected = index == _selectedTenseIndex;
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => setState(() => _selectedTenseIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.peach : Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPad),
            child: Conjugator(data: data),
          ),
        ],
      ),
    );
  }

  ConjugationData _buildConjugationData(IrregularVerb v, IrishTense tense) {
    final irishForms = v.personForms(tense);
    // Provide simple English pronoun-based forms or single placeholders.
    List<String> englishForms;
    if (tense == IrishTense.verbalNoun) {
      englishForms = ['${v.english} (verbal noun)'];
    } else if (tense == IrishTense.verbalAdjective) {
      englishForms = ['${v.english} (verbal adj.)'];
    } else {
      const pronouns = ['I', 'you', 'he/she', 'we', 'you (pl)', 'they'];
      englishForms = [
        for (int i = 0; i < irishForms.length; i++)
          _englishTenseScaffold(pronouns[i], v.english, tense),
      ];
    }
    return ConjugationData(
      title: _tenseTitle(tense),
      ga: irishForms,
      en: englishForms,
    );
  }

  String _tenseTitle(IrishTense t) {
    switch (t) {
      case IrishTense.present:
        return 'Present Tense (An Aimsir Láithreach)';
      case IrishTense.past:
        return 'Past Tense (An Aimsir Chaite)';
      case IrishTense.future:
        return 'Future Tense (An Aimsir Fháistinach)';
      case IrishTense.conditional:
        return 'Conditional (An Modh Coinníollach)';
      case IrishTense.imperative:
        return 'Imperative (An Modh Ordaitheach)';
      case IrishTense.verbalNoun:
        return 'Verbal Noun';
      case IrishTense.verbalAdjective:
        return 'Verbal Adjective';
    }
  }

  String _englishTenseScaffold(String pronoun, String base, IrishTense tense) {
    switch (tense) {
      case IrishTense.present:
        return '$pronoun ${_basePresent(base)}';
      case IrishTense.past:
        return '$pronoun ${_basePast(base)}';
      case IrishTense.future:
        return '$pronoun will ${_bare(base)}';
      case IrishTense.conditional:
        return '$pronoun would ${_bare(base)}';
      case IrishTense.imperative:
        return pronoun == 'I' ? '-' : '($pronoun) ${_bare(base)}!';
      case IrishTense.verbalNoun:
        return _gerund(base);
      case IrishTense.verbalAdjective:
        return _pastParticiple(base);
    }
  }

  String _bare(String base) =>
      base.startsWith('to ') ? base.substring(3) : base;
  String _basePresent(String base) => _bare(base);
  String _basePast(String base) {
    final b = _bare(base);
    if (b.endsWith('e')) return '${b}d';
    return '${b}ed';
  }

  String _gerund(String base) {
    final b = _bare(base);
    if (b.endsWith('e')) return b.substring(0, b.length - 1) + 'ing';
    return b + 'ing';
  }

  String _pastParticiple(String base) => _basePast(base);
}

/// Mode switch widget for Dictionary / Conjugator.
class _ModeSwitch extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  const _ModeSwitch({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ModeSwitchButton(
              label: 'Dictionary',
              index: 0,
              selected: selectedIndex == 0,
              onTap: onChanged,
            ),
            _ModeSwitchButton(
              label: 'Conjugator',
              index: 1,
              selected: selectedIndex == 1,
              onTap: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeSwitchButton extends StatelessWidget {
  final String label;
  final bool selected;
  final int index;
  final ValueChanged<int> onTap;
  const _ModeSwitchButton({
    required this.label,
    required this.selected,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: _radiusForIndex(index),
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: selected ? AppColors.peach : Colors.transparent,
          borderRadius: _radiusForIndex(index),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  BorderRadius _radiusForIndex(int i) {
    if (i == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      );
    }
    return const BorderRadius.only(
      topRight: Radius.circular(12),
      bottomRight: Radius.circular(12),
    );
  }
}
