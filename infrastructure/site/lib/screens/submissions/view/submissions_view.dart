import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpainapi/moralpainapi.dart';

import '../submissions.dart';

class SubmissionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmissionsBloc, SubmissionsState>(
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

  static Widget submissionsFromState(SubmissionsState state) {
    if (state is SubmissionsInitial || state is SubmissionsLoading) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    } else if (state is SubmissionsLoaded) {
      return Expanded(
        child: Center(
          child: Text(
            messageFromSubmissions(state.submissions),
          ),
        ),
      );
    } else if (state is SubmissionsLoadFailed) {
      return Expanded(
        child: Center(
          child: Text('Error fetching submissions'),
        ),
      );
    } else {
      assert(false);
      return ErrorWidget('Error State');
    }
  }

  static String messageFromSubmissions(Submissions submissions) {
    BuiltList<Submission>? list = submissions.list;
    if (list == null) {
      return 'No list of submissions.';
    }
    if (list.isEmpty) {
      return 'List of submissions is empty.';
    }
    return list.toString();
  }
}
