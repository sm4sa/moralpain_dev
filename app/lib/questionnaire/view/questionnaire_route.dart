import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpain/survey_repository.dart';

import '../questionnaire.dart';
import 'questionnaire_view.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [CounterCubit] instance to the [CounterView].
/// {@endtemplate}
class QuestionnaireRoute extends StatelessWidget {
  final SurveyRepository questionnaireRepository;

  const QuestionnaireRoute({Key? key, required this.questionnaireRepository});

  // Make the cubit available to the children.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: questionnaireRepository,
        child: BlocProvider(
          create: (_) => QuestionnaireBloc(repository: questionnaireRepository)
            ..add(QuestionnaireLoadEvent()),
          child: QuestionnaireView(),
        ));
  }
}
