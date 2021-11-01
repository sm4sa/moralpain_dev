import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpain/questionnaire/questionnaire.dart';

import 'package:moralpain/assets/constants.dart' as Constants;
import 'package:moralpain/questionnaire_repository.dart';
import '../thermometer.dart';
import 'themometer_slider.dart';


// TODO (nphair): Handle Rotation Overflow.

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class ThermometerView extends StatefulWidget {
  @override
  _ThermometerViewState createState() => _ThermometerViewState();
}

class _ThermometerViewState extends State<ThermometerView> {
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
                  builder: (context) => QuestionnaireRoute(
                      questionnaireRepository: QuestionnaireRepository())),
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
              Text(Constants.THERMOMETER_TITLE,
                  style: TextStyle(
                      fontSize: Constants.THERMOMETER_TITLE_FONT_SIZE)),
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
            Text(Constants.THERMOMETER_TITLE,
                style:
                    TextStyle(fontSize: Constants.THERMOMETER_TITLE_FONT_SIZE)),
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
