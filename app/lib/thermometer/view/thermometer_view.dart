import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moralpain/assets/constants.dart' as Constants;
import 'package:moralpain/survey/view/survey_route.dart';
import 'package:moralpain/survey_repository.dart';
import '../thermometer.dart';
import 'themometer_slider.dart';

// TODO (nphair): Handle Rotation Overflow.

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class ThermometerView extends StatelessWidget {
  var x = 0.0;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                  builder: (context) =>
                      SurveyRoute(repository: SurveyRepository())),
            );
          },
          child: const Icon(Icons.navigate_next),
          backgroundColor: const Color(Constants.COLORS_UVA_BLUE)),
    );
  }

  Widget _landscapeMode() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(children: [
              Text(Constants.THERMOMETER_TITLE, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                Constants.THERMOMETER_INSTRUCTIONS,
                textAlign: TextAlign.center,
              )
            ])),
            Expanded(
                child:
                    RotatedBox(quarterTurns: -1, child: ThermometerWidget())),
          ]);

  Widget _potraitMode() => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(Constants.THERMOMETER_TITLE, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(
              Constants.THERMOMETER_INSTRUCTIONS,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Expanded(
                child:
                    RotatedBox(quarterTurns: -1, child: ThermometerWidget())),
          ]);
}
