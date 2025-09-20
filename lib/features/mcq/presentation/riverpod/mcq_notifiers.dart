import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/mcq/domain/entity/question_entity.dart';
import 'package:medquest/features/mcq/presentation/riverpod/mcq_providers.dart';
import 'package:medquest/features/mcq/presentation/riverpod/mcq_state.dart';

class McqNotifiers extends AsyncNotifier<McqState> {
  @override
  FutureOr<McqState> build() async {
    return McqState.initial();
  }

  Future<void> getMcq(
    List<int> years,
    Set<QuestionType> questionType,
    String courseName,
  ) async {
    state = const AsyncLoading();
    try {
      final usecase = ref.read(mcqUsecaseProvider);

      final questions =
          await usecase.getQuestions(questionType, courseName, years);

      state = AsyncData(McqState(questions: questions));
    } catch (e, st) {
      state = AsyncError(e.toString(), st);
    }
  }
}
