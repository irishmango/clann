class DictionaryEntry {
  final String irish;
  final String english;
  final String partOfSpeech; // simple metadata field

  const DictionaryEntry({
    required this.irish,
    required this.english,
    this.partOfSpeech = '',
  });
}

// Small dummy dataset for testing search functionality.
const List<DictionaryEntry> dummyDictionary = [
  DictionaryEntry(irish: 'teach', english: 'house', partOfSpeech: 'noun'),
  DictionaryEntry(irish: 'madra', english: 'dog', partOfSpeech: 'noun'),
  DictionaryEntry(irish: 'cat', english: 'cat', partOfSpeech: 'noun'),
  DictionaryEntry(irish: 'ith', english: 'eat', partOfSpeech: 'verb'),
  DictionaryEntry(irish: 'ól', english: 'drink', partOfSpeech: 'verb'),
  DictionaryEntry(irish: 'fear', english: 'man', partOfSpeech: 'noun'),
  DictionaryEntry(irish: 'bean', english: 'woman', partOfSpeech: 'noun'),
  DictionaryEntry(irish: 'leanbh', english: 'child', partOfSpeech: 'noun'),
  DictionaryEntry(irish: 'múinteoir', english: 'teacher', partOfSpeech: 'noun'),
  DictionaryEntry(irish: 'scoil', english: 'school', partOfSpeech: 'noun'),
  DictionaryEntry(irish: 'rith', english: 'run', partOfSpeech: 'verb'),
];
