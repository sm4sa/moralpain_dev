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
        switch (state.surveyStatus) {
          case SurveyStatus.initial:
          case SurveyStatus.loading:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case SurveyStatus.success:
            final bloc = BlocProvider.of<HomeBloc>(context);
            return Scaffold(
              appBar: AppBar(title: Text('Submission ID ${state.id}')),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FieldDisplay(
                      text:
                          'Time submitted: ${DateTime.fromMillisecondsSinceEpoch(
                        state.timestamp * 1000,
                      ).toString()}',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<HomeBloc>.value(
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
                            builder: (context) => BlocProvider<HomeBloc>.value(
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
                          '${_displaySelections(state.selections, state.survey!)}',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<HomeBloc>.value(
                              value: bloc,
                              child: const SelectionsRoute(),
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                    ),
                  ],
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
      },
    );
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
}
