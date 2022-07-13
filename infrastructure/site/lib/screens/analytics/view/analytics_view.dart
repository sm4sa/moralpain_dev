import 'package:admin/api_repository.dart';
import 'package:admin/screens/analytics/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalyticsRoute extends StatelessWidget {
  const AnalyticsRoute({Key? key, required this.repository}) : super(key: key);

  final ApiRepository repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => AnalyticsBloc(repository: repository)
          ..add(const AnalyticsStarted(operation: 'count')),
        child: const AnalyticsView(),
      ),
    );
  }
}

class AnalyticsView extends StatelessWidget {
  const AnalyticsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('AnalyticsView displaying within AnalyticsRoute');
  }
}
