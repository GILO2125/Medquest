import 'package:medquest/features/mcq/domain/entity/question_entity.dart';

class McqState {
  final List<QuestionEntity> questions;
  

  McqState({
    required this.questions,
 
  });

  factory McqState.initial() => McqState(
    questions: [],
  
  );
}
