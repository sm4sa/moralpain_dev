import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/datetime/datetime.dart';
import 'package:submission_site/home/home.dart';
import 'package:submission_site/score/score.dart';
import 'package:submission_site/selections/selections.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.submissionStatus) {
          case SubmissionStatus.initial:
          case SubmissionStatus.loading:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case SubmissionStatus.success:
            switch (state.surveyStatus) {
              case SurveyStatus.initial:
              case SurveyStatus.loading:
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              case SurveyStatus.success:
                final bloc = BlocProvider.of<HomeBloc>(context);
                final areChanges =
                    state.timestamp != state.submission!.timestamp ||
                        state.score != state.submission!.score ||
                        !_areListsEqual(
                          state.selections!,
                          state.submission!.selections!.toList(),
                        );
                WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _showSubmitStatusDialog(context, state));
                return Scaffold(
                  appBar: AppBar(title: Text('Submission ID ${state.id}')),
                  body: Center(
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FieldDisplay(
                              text:
                                  'Time submitted: ${DateTime.fromMillisecondsSinceEpoch(
                                state.timestamp! * 1000,
                              ).toString()}',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BlocProvider<HomeBloc>.value(
                                      value: bloc,
                                      child: const DatetimeRoute(),
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                            ),
                            FieldDisplay(
                              text: 'Score: ${state.score} out of 10',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BlocProvider<HomeBloc>.value(
                                      value: bloc,
                                      child: const ScoreRoute(),
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                            ),
                            FieldDisplay(
                              text: 'Contributing factors:'
                                  '${_displaySelections(state.selections!, state.survey!)}',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BlocProvider<HomeBloc>.value(
                                      value: bloc,
                                      child: const SelectionsRoute(),
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 50.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: areChanges
                                      ? () {
                                          final alert = AlertDialog(
                                            title: const Text(
                                              'Are you sure you want to revert your changes?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  bloc.add(
                                                    const HomeChangesReverted(),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Yes'),
                                              )
                                            ],
                                          );
                                          showDialog(
                                              context: context,
                                              builder: (_) => alert);
                                        }
                                      : null,
                                  child: const Text('Revert Changes'),
                                ),
                                const SizedBox(width: 30.0),
                                ElevatedButton(
                                  onPressed: areChanges
                                      ? () {
                                          final alert = AlertDialog(
                                            title: const Text(
                                              'Are you sure you want to submit your changes?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  bloc.add(
                                                    const HomeChangesSubmitted(),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Yes'),
                                              )
                                            ],
                                          );
                                          showDialog(
                                              context: context,
                                              builder: (_) => alert);
                                        }
                                      : null,
                                  child: const Text('Submit Changes'),
                                ),
                                const SizedBox(height: 50.0)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              case SurveyStatus.failure:
                return Scaffold(
                  appBar: AppBar(title: Text('Submission ID ${state.id}')),
                  body: const Center(
                    child: Text(
                      'Error fetching information about contributing factors.',
                    ),
                  ),
                );
            }
          case SubmissionStatus.failure:
            return const Scaffold(
              body: Center(child: Text('Error fetching submission.')),
            );
        }
      },
    );
  }

  bool _areListsEqual(List a, List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  String _displaySelections(List<String> selections, Survey survey) {
    if (selections.isEmpty) return ' none';
    String ret = '\n';
    for (String id in selections) {
      ret += '• ${_getSelectionDescription(id, survey)}';
      if (id != selections.last) ret += '\n';
    }
    return ret;
  }

  String _getSelectionDescription(String id, Survey survey) {
    for (SurveySection section in survey.sections!) {
      for (SurveyOption option in section.options!) {
        if (option.id! == id) {
          return option.description!;
        }
      }
    }
    return 'Couldn\'t find description.';
  }

  void _showSubmitStatusDialog(BuildContext context, HomeState state) {
    AlertDialog alert;
    switch (state.submitStatus) {
      case SubmitStatus.none:
        return;
      case SubmitStatus.success:
        alert = AlertDialog(
          title: const Text('Changes sbumitted!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
        break;
      case SubmitStatus.failure:
        alert = AlertDialog(
          title: const Text('Error submitting changes.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
    }
    showDialog(context: context, builder: (_) => alert);
  }
}
