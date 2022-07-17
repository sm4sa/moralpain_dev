import 'package:submissions_site/api_repository.dart';
import 'package:submissions_site/screens/analytics0/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpainapi/moralpainapi.dart';

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
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      builder: (context, state) => _handleLoadEvents(context, state),
    );
  }

  Widget _handleLoadEvents(BuildContext context, AnalyticsState state) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Center(child: analyticsFromState(state)),
    );
  }

  static Widget analyticsFromState(AnalyticsState state) {
    if (state is AnalyticsInitial) {
      return Text('No analytics yet.');
    } else if (state is AnalyticsInProgress) {
      return CircularProgressIndicator();
    } else if (state is AnalyticsFailure) {
      return Text('Error fetching analytics.');
    } else if (state is AnalyticsSuccess) {
      if (state.result.error != null && !state.result.error!) {
        return Text(messageFromResult(
          operation: state.result.operation!,
          result: state.result.result!,
        ));
      } else {
        return Text('Error fetching analytics: ${state.result.errormsg}');
      }
    } else {
      assert(false);
      return ErrorWidget('Error State');
    }
  }

  static String messageFromResult({
    required AnalyticsResultOperationEnum operation,
    required num result,
  }) {
    switch (operation) {
      case AnalyticsResultOperationEnum.count:
        return 'The number of submissions is $result.';
      default:
        return 'The $operation score is $result.';
    }
  }
}
