enum QuizQuestionType { multipleChoice, dragAndDrop }

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
