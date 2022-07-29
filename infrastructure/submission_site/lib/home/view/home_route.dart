import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/home/home.dart';

class HomeRoute extends StatelessWidget {
  final Submission submission;

  const HomeRoute(this.submission, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(submission),
      child: const HomeView(),
    );
  }
}
