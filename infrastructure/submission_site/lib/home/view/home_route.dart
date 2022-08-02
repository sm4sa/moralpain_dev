import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/api_repository.dart';
import 'package:submission_site/home/home.dart';

class HomeRoute extends StatelessWidget {
  final Submission submission;

  const HomeRoute(this.submission, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(
        repository: ApiRepository(),
      )..add(const HomeSubmissionRequested(
          '119ada26-a0ba-4991-82f4-d6aa7c73c503',
        )),
      child: const HomeView(),
    );
  }
}
