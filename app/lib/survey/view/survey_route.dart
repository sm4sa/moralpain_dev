import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpain/survey_repository.dart';

import '../survey.dart';
import 'survey_view.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [CounterCubit] instance to the [CounterView].
/// {@endtemplate}
class SurveyRoute extends StatelessWidget {
  final SurveyRepository repository;

  const SurveyRoute({Key? key, required this.repository});

  // Make the cubit available to the children.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: repository,
        child: BlocProvider(
          create: (_) =>
              SurveyBloc(repository: repository)..add(SurveyLoadEvent()),
          child: SurveyView(),
        ));
  }
}
