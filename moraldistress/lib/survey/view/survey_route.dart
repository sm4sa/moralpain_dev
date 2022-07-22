import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moraldistress/api_repository.dart';

import '../survey.dart';
import 'survey_view.dart';

class SurveyRoute extends StatelessWidget {
  final ApiRepository repository;
  final int score;

  const SurveyRoute({Key? key, required this.repository, required this.score});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: repository,
        child: BlocProvider(
          create: (_) => SurveyBloc(repository: repository, score: score)
            ..add(SurveyLoadEvent()),
          child: SurveyView(),
        ));
  }
}
