enum QuizQuestionType { multipleChoice, dragAndDrop, pairMatch }

abstract class QuizQuestion {
  QuizQuestionType get type;
  String get prompt;
}

class MultipleChoiceQuestion implements QuizQuestion {
  @override
  final String prompt;
  final List<String> answers;
  final int correctIndex;
  @override
  QuizQuestionType get type => QuizQuestionType.multipleChoice;
  const MultipleChoiceQuestion({
    required this.prompt,
    required this.answers,
    required this.correctIndex,
  });
}

class DragAndDropQuestion implements QuizQuestion {
  @override
  final String prompt;
  final List<String> words;
  final List<String> correctOrder;
  @override
  QuizQuestionType get type => QuizQuestionType.dragAndDrop;
  const DragAndDropQuestion({
    required this.prompt,
    required this.words,
    required this.correctOrder,
  });
}

class PairMatchQuestion implements QuizQuestion {
  @override
  final String prompt;
  // Irish words
  final List<String> ga;
  // English translations aligned with ga indices
  final List<String> en;
  @override
  QuizQuestionType get type => QuizQuestionType.pairMatch;
  const PairMatchQuestion({
    required this.prompt,
    required this.ga,
    required this.en,
  }) : assert(ga.length == en.length, 'ga and en length mismatch');
  int get length => ga.length;
}
