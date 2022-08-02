import 'package:cognito_authentication_repository/cognito_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moraldistress/api_repository.dart';

import '../submitted.dart';
import '../../auth/auth_cubit.dart';
import 'submitted_view.dart';

class SubmittedRoute extends StatelessWidget {
  final ApiRepository repository;
  final CognitoAuthenticationRepository authRepository;

  const SubmittedRoute(
      {Key? key, required this.repository, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResourcesBloc(
        repository: repository,
        authRepository: authRepository,
      )..add(ResourcesLoadEvent()),
      child: SubmittedView(),
    );
  }
}
