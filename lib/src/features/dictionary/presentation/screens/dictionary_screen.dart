import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:clann/src/shared/mode_switch.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';
import 'package:clann/src/features/dictionary/data/dummy_dictionary.dart';
import 'package:clann/src/features/dictionary/data/irregular_verb_database.dart';
import 'package:clann/src/features/dictionary/presentation/widgets/conjugator.dart';
import 'package:clann/src/features/dictionary/presentation/widgets/dictionary_dashboard.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  // Keep only search helper & irregular search logic here.
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: [
          DictionaryDashboard(
            title: _selectedIndex == 0 ? 'Dictionary' : 'Conjugator',
            middle: Align(
              alignment: Alignment.centerLeft,
              child: ModeSwitch(
                leftLabel: "Dictionary",
                rightLabel: "Conjugator",
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
            searchBar: CustomSearchBar(
              hintText: _selectedIndex == 0
                  ? 'Search in Irish or English'
                  : 'Search verbs',
              onChanged: _onSearchChanged,
              controller: _controller,
            ),
          ),
          // Dictionary content gets standard horizontal padding; conjugator mode manages its own layout.
          if (_selectedIndex == 0)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 12,
              ),
              child: DictionaryBody(
                query: _query,
                results: _filtered,
                selectedEntry: _selectedEntry,
                onSelectEntry: (e) {
                  setState(() {
                    _selectedEntry = e;
                    _query = '';
                    _controller.clear();
                  });
                  FocusScope.of(context).unfocus();
                },
                onCloseEntry: () => setState(() => _selectedEntry = null),
                onConjugate: (lemma) {
                  final irregular = findIrregularVerb(lemma);
                  if (irregular != null) {
                    setState(() {
                      _selectedIndex = 1;
                      _selectedVerb = irregular;
                      _selectedEntry = null;
                    });
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Conjugator support coming soon for regular verbs',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                  }
                },
              ),
            )
          else
            ConjugatorMode(
              selectedVerb: _selectedVerb,
              query: _query,
              onVerbSelected: (v) {
                setState(() {
                  _selectedVerb = v;
                  _query = '';
                  _controller.clear();
                });
                FocusScope.of(context).unfocus();
              },
              onClearVerb: () => setState(() => _selectedVerb = null),
              searchIrregular: _searchIrregularVerbs,
            ),
        ],
      ),
    );
  }
  // (Legacy private builder methods removed in refactor.)

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
class IrregularVerbConjugator extends StatefulWidget {
  final IrregularVerb verb;
  final VoidCallback onClear;
  const IrregularVerbConjugator({
    super.key,
    required this.verb,
    required this.onClear,
  });

  @override
  State<IrregularVerbConjugator> createState() =>
      _IrregularVerbConjugatorState();
}

class _IrregularVerbConjugatorState extends State<IrregularVerbConjugator> {
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
                // Combined styled verb heading: Irish - English (Expanded so close button stays flush right)
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        height: 1.1,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: widget.verb.lemma,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(
                          text: ' - ',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: widget.verb.english,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
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
                      color: Colors.white,
                      border: Border.all(
                        color: selected ? AppColors.primary : Colors.black,
                        width: 2,
                      ),
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

// ===================== Dictionary Body Widgets =====================

class DictionaryBody extends StatelessWidget {
  final String query;
  final List<DictionaryEntry> results;
  final DictionaryEntry? selectedEntry;
  final ValueChanged<DictionaryEntry> onSelectEntry;
  final VoidCallback onCloseEntry;
  final ValueChanged<String> onConjugate; // lemma

  const DictionaryBody({
    super.key,
    required this.query,
    required this.results,
    required this.selectedEntry,
    required this.onSelectEntry,
    required this.onCloseEntry,
    required this.onConjugate,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedEntry != null) {
      return DictionaryEntryDetail(
        entry: selectedEntry!,
        onClose: onCloseEntry,
        onConjugate: onConjugate,
      );
    }
    if (query.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 12.0),
        child: Text(
          'Make a search to get started!',
          style: TextStyle(fontSize: 16),
        ),
      );
    }
    if (results.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 12.0),
        child: Text(
          "No results found for '$query'",
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
      );
    }
    return SearchResults(results: results, onTap: onSelectEntry);
  }
}

class SearchResults extends StatelessWidget {
  final List<DictionaryEntry> results;
  final ValueChanged<DictionaryEntry> onTap;
  const SearchResults({super.key, required this.results, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 260),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: results.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final entry = results[index];
          return InkWell(
            onTap: () => onTap(entry),
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
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Text(
                        entry.partOfSpeech,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
}

class DictionaryEntryDetail extends StatelessWidget {
  final DictionaryEntry entry;
  final VoidCallback onClose;
  final ValueChanged<String> onConjugate; // lemma
  const DictionaryEntryDetail({
    super.key,
    required this.entry,
    required this.onClose,
    required this.onConjugate,
  });

  @override
  Widget build(BuildContext context) {
    final isVerb = entry.partOfSpeech.toLowerCase() == 'verb';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
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
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Text(
                    entry.partOfSpeech,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              const Spacer(),
              IconButton(
                tooltip: 'Close',
                onPressed: onClose,
                icon: const Icon(Icons.close_rounded, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(entry.english, style: const TextStyle(fontSize: 16)),
          if (isVerb) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: Colors.black, width: 1.2),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                onPressed: () => onConjugate(entry.irish),
                child: const Text('Conjugate'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ConjugatorMode extends StatelessWidget {
  final IrregularVerb? selectedVerb;
  final String query;
  final ValueChanged<IrregularVerb> onVerbSelected;
  final VoidCallback onClearVerb;
  final List<IrregularVerb> Function(String) searchIrregular;

  const ConjugatorMode({
    super.key,
    required this.selectedVerb,
    required this.query,
    required this.onVerbSelected,
    required this.onClearVerb,
    required this.searchIrregular,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedVerb != null) {
      return IrregularVerbConjugator(verb: selectedVerb!, onClear: onClearVerb);
    }
    if (query.isNotEmpty) {
      final results = searchIrregular(query);
      if (results.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Text(
            'No irregular verb found for that query',
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
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
            separatorBuilder: (_, __) => const Divider(height: 12),
            itemBuilder: (context, index) {
              final verb = results[index];
              return InkWell(
                onTap: () => onVerbSelected(verb),
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
      child: Text(
        'Type an irregular verb (e.g. bí, abair, feic, ith...)',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
