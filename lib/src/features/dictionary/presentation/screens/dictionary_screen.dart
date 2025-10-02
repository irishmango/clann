import 'package:clann/src/features/dictionary/presentation/screens/conjugator_screen.dart';
import 'package:clann/src/shared/custom_search_bar.dart';
import 'package:clann/theme.dart';
import 'package:flutter/material.dart';
import 'package:clann/src/features/dictionary/data/dummy_dictionary.dart';

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
  void _onCardTapped(int index) {
    if (index == _selectedIndex) return;
    // Handle navigation logic here
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex != 0) {
        // Clear search when switching away (optional UX decision)
        _query = '';
        _controller.clear();
      }
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
      // Clear selection when typing new query
      _selectedEntry = null;
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
            bottom: 32.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedIndex == 0 ? "Dictionary" : "Conjugator",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 18),
              if (_selectedIndex == 0)
                CustomSearchBar(
                  hintText: "Search in Irish or English",
                  onChanged: _onSearchChanged,
                  controller: _controller,
                ),
            ],
          ),
        ),
        // Dictionary keeps symmetric padding; Conjugator removes right padding so chips can bleed.
        Padding(
          padding: _selectedIndex == 0
              ? const EdgeInsets.symmetric(horizontal: 18.0)
              : const EdgeInsets.only(left: 18.0),
          child: _selectedIndex == 0
              ? _buildSearchResults()
              : const ConjugatorScreen(),
        ),

        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            spacing: 12,
            children: [
              Row(
                children: [
                  Text(
                    "Quick Links",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Spacer(),
                ],
              ),
              Row(
                spacing: 12,
                children: [
                  Container(
                    width: 160,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.peach,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        "Irregular Verbs",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  _selectedIndex == 0
                      ? GestureDetector(
                          onTap: () {
                            _onCardTapped(1);
                          },
                          child: Container(
                            width: 160,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.peach,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                "Conjugator",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            _onCardTapped(0);
                          },
                          child: Container(
                            width: 160,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.peach,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                "Dictionary",
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
            ],
          ),
        ),
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
}
