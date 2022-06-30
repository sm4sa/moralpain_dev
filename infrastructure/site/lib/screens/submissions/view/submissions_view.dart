import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpainapi/moralpainapi.dart';

import '../submissions.dart';

class SubmissionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmissionsBloc, SubmissionsState>(
      buildWhen: (previous, current) =>
          current is SubmissionsLoading || current is SubmissionsLoaded,
      builder: (context, state) => handleLoadEvents(context, state),
    );
  }

  Widget handleLoadEvents(BuildContext context, SubmissionsState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Submissions'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [submissionsFromState(state)],
        ),
      ),
    );
  }

  Widget submissionsFromState(SubmissionsState state) {
    if (state is SubmissionsLoading) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    } else if (state is SubmissionsLoaded) {
      return Expanded(
        child: Center(
          child: Text(
            messageFromList(state.submissions.list),
          ),
        ),
      );
    } else {
      assert(false);
      return ErrorWidget('Error State');
    }
  }

  String messageFromList(BuiltList<Submission>? list) {
    if (list == null) {
      return 'No list of submissions.';
    }
    if (list.isEmpty) {
      return 'List of submissions is empty.';
    }
    return list.toString();
  }
}
