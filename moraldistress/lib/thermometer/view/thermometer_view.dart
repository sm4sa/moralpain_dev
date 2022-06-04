import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moraldistress/assets/constants.dart' as Constants;
import 'package:moraldistress/survey/view/survey_route.dart';
import 'package:moraldistress/api_repository.dart';
import '../thermometer.dart';
import 'themometer_slider.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class ThermometerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(Constants.COLORS_UVA_BLUE),
        title: const Text(Constants.APPBAR_TEXT),
      ),
      body: Padding(
          padding: EdgeInsets.all(Constants.PADDING),
          child: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return _potraitMode();
            } else {
              return _landscapeMode();
            }
          })),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => SurveyRoute(
                      repository: ApiRepository(),
                      // NB (nphair): Not sure if it is best practive to reach into
                      // the bloc for the state like this.
                      score: context.read<ThermometerCubit>().state.toInt())),
            );
          },
          child: const Icon(Icons.navigate_next),
          backgroundColor: const Color(Constants.COLORS_UVA_BLUE)),
    );
  }

  Widget _landscapeMode() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  thermometerLandscapeText(),
                  _thermometerLabel()
                ])),
            Expanded(
                child:
                    RotatedBox(quarterTurns: -1, child: ThermometerWidget())),
          ]);

  Widget thermometerLandscapeText() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(Constants.THERMOMETER_TITLE,
            style: TextStyle(fontSize: Constants.THERMOMETER_TITLE_FONT_SIZE)),
        SizedBox(height: 10),
        Text(
          Constants.THERMOMETER_INSTRUCTIONS,
        ),
      ]);

  Widget _potraitMode() => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Constants.THERMOMETER_TITLE,
                style:
                    TextStyle(fontSize: Constants.THERMOMETER_TITLE_FONT_SIZE)),
            SizedBox(height: 10),
            Text(
              Constants.THERMOMETER_INSTRUCTIONS,
            ),
            SizedBox(height: 10),
            Expanded(
                child:
                    RotatedBox(quarterTurns: -1, child: ThermometerWidget())),
            _thermometerLabel()
          ]);

  Widget _thermometerLabel() =>
      BlocBuilder<ThermometerCubit, double>(builder: (context, state) {
        return Center(
            child: Text(
          _scoreToText(state),
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        ));
      });

  String _scoreToText(score) {
    if (score == 0) {
      return "None";
    } else if (score <= 3) {
      return "Mild";
    } else if (score <= 5) {
      return "Distressing";
    } else if (score <= 7) {
      return "Uncomfortable";
    } else if (score <= 9) {
      return "Intense";
    } else if (score <= 10) {
      return "Worst Possible";
    } else {
      assert(false);
      return "";
    }
  }
}
