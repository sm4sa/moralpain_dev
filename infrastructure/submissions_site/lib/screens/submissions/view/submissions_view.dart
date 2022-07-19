import 'package:submissions_site/screens/filter_submissions/filter_submissions.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submissions_site/screens/submissions/submissions.dart';
import 'package:moralpainapi/moralpainapi.dart';

class SubmissionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmissionsBloc, SubmissionsState>(
      builder: (context, state) => handleLoadEvents(context, state),
    );
  }

  Widget handleLoadEvents(BuildContext context, SubmissionsState state) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider<SubmissionsBloc>(
                create: (_) => context.read<SubmissionsBloc>(),
              ),
              BlocProvider<FilterSubmissionsBloc>(
                create: (_) => FilterSubmissionsBloc(),
              )
            ],
            child: const FilterSubmissionsView(),
          ),
          SizedBox(width: 20),
          submissionsFromState(state),
        ],
      ),
    );
  }

  static Widget submissionsFromState(SubmissionsState state) {
    if (state is SubmissionsInitial || state is SubmissionsLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is SubmissionsLoaded) {
      return Center(
        child: messageFromSubmissions(state.submissions),
      );
    } else if (state is SubmissionsLoadFailed) {
      return Center(
        child: Text('Error fetching submissions'),
      );
    } else {
      assert(false);
      return ErrorWidget('Error State');
    }
  }

  static Widget messageFromSubmissions(Submissions submissions) {
    BuiltList<Submission>? list = submissions.list;
    if (list == null) {
      return Text('No list of submissions.');
    }
    if (list.isEmpty) {
      return Text('List of submissions is empty.');
    }
    return SingleChildScrollView(
      child: ListView(
        children: [
          for (final submission in submissions.list!)
            SubmissionListTile(submission),
        ],
        shrinkWrap: true,
      ),
    );
  }
}
