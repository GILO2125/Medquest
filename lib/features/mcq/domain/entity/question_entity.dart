class QuestionEntity {
  final String id;
  final String questionText;
  final String? context;
  final QuestionType questiontype;
  final int year;
  final String rotation;
  final int questionNumber;
  final Map<String, bool> propostions;
  QuestionEntity(
      {required this.propostions,
      required this.id,
      required this.questionText,
      required this.questiontype,
      required this.year,
      required this.rotation,
      required this.questionNumber,
      this.context});
}

enum QuestionType { clinical, theoretical }
