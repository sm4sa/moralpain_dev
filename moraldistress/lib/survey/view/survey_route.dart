import 'package:cognito_authentication_repository/cognito_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moraldistress/api_repository.dart';

import '../../auth/auth_cubit.dart';
import '../survey.dart';
import 'survey_view.dart';

class SurveyRoute extends StatelessWidget {
  final int score;

  const SurveyRoute({Key? key, required this.score});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SurveyBloc(
          repository: RepositoryProvider.of<ApiRepository>(context),
          authRepository:
              RepositoryProvider.of<CognitoAuthenticationRepository>(context),
          score: score)
        ..add(SurveyLoadEvent()),
      child: SurveyView(),
    );
  }
}
