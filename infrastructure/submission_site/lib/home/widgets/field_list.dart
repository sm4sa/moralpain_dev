import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/datetime/datetime.dart';
import 'package:submission_site/home/home.dart';
import 'package:submission_site/score/score.dart';
import 'package:submission_site/selections/selections.dart';

class FieldList extends StatelessWidget {
  FieldList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = BlocProvider.of<HomeBloc>(context);
    return Column(
      children: [
        FieldDisplay(
          text: 'Time submitted: ${displayTimestamp(bloc.state.timestamp!)}',
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
          text: 'Score: ${bloc.state.score} out of 10',
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
          text: 'Contributing factors: '
              '${displaySelections(
            bloc.state.selections!,
            bloc.state.survey!,
          )}',
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
    );
  }

  @visibleForTesting
  static String displayTimestamp(int timestamp) {
    final datetime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toUtc();
    String datetimeString = datetime.toString();
    datetimeString = datetimeString.substring(0, datetimeString.length - 5);
    datetimeString += ' (UTC)';
    return datetimeString;
  }

  @visibleForTesting
  static String displaySelections(List<String> selections, Survey survey) {
    if (selections.isEmpty) return ' none';
    String ret = '\n';
    for (String id in selections) {
      ret += '• ${getSelectionDescription(id, survey)}';
      if (id != selections.last) ret += '\n';
    }
    return ret;
  }

  @visibleForTesting
  static String getSelectionDescription(String id, Survey survey) {
    List<String> ids = id.split('_');
    for (SurveySection section in survey.sections!) {
      if (section.sectionId! == ids[0]) {
        for (SurveyOption option in section.options!) {
          if (option.id! == ids[1]) {
            return option.description!;
          }
        }
      }
    }
    return 'Couldn\'t find description.';
  }
}
