import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpain/assets/constants.dart' as Constants;
import 'package:expandable_text/expandable_text.dart';
import 'package:moralpainapi/src/model/survey_section.dart';
import 'package:moralpainapi/src/model/survey_option.dart';

import '../survey.dart';

class SurveyView extends StatefulWidget {
  @override
  SurveyViewState createState() => SurveyViewState();
}

class SurveyViewState extends State<SurveyView> {
  final controller = ScrollController();
  bool _show = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollHandler);
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    super.dispose();
  }

  void showFloationButton() {
    setState(() {
      _show = true;
    });
  }

  void hideFloationButton() {
    setState(() {
      _show = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(Constants.COLORS_UVA_BLUE),
        title: const Text(Constants.APPBAR_TEXT),
      ),
      body: Padding(
          padding: EdgeInsets.all(Constants.PADDING),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Constants.SURVEY_TITLE,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                ExpandableText(
                  Constants.SURVEY_INSTRUCTIONS,
                  expandText: Constants.SURVEY_EXPAND_TEXT,
                  collapseText: Constants.SURVEY_COLLAPSE_TEXT,
                  maxLines: 1,
                  linkEllipsis: false,
                  linkColor: Colors.blue,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<SurveyBloc, SurveyState>(builder: (context, state) {
                  if (state is SurveyLoading) {
                    return CircularProgressIndicator();
                  } else if (state is SurveyLoaded) {
                    return Expanded(
                        child: ListView(
                            controller: controller,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: state.survey.sections!
                                .map((q) => cardForSection(q))
                                .toList()));
                  } else {
                    return ErrorWidget(
                        "ERROR"); // probably bad, questcomplete will trigger.
                  }
                })
              ])),
      floatingActionButton: Visibility(
        visible: _show,
        child: FloatingActionButton(
            onPressed: () {
              // TODO (nphair): Really should be going through the bloc.
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  Constants.SURVEY_TOASTER_MESSAGE,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: Constants.SURVEY_TOASTER_FONT_SIZE),
                ),
                duration: Duration(seconds: Constants.SURVEY_TOASTER_DURATION),
              ));

              Future.delayed(
                  const Duration(seconds: Constants.SURVEY_TOASTER_DURATION),
                  () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
            },
            child: Icon(Icons.send),
            backgroundColor: const Color(Constants.COLORS_UVA_BLUE)),
      ),
    );
  }

  void scrollHandler() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      showFloationButton();
    } else {
      hideFloationButton();
    }
  }

  Card cardForSection(SurveySection section) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title!,
                  ),
                  Text(section.subtitle!),
                ],
              )),
          SurveyOptionsWidget(section.options!.asList())
        ],
      ),
    );
  }
}

class SurveyOptionsWidget extends StatefulWidget {
  final List<SurveyOption> options;

  SurveyOptionsWidget(this.options);

  @override
  SurveyOptionsWidgetState createState() =>
      new SurveyOptionsWidgetState(options);
}

class SurveyOptionsWidgetState extends State<SurveyOptionsWidget> {
  final List<SurveyOption> options;
  final Map<String, bool> chosen;

  SurveyOptionsWidgetState(this.options)
      : this.chosen =
            Map.fromIterable(options, key: (o) => o.id, value: (_) => false);

  @override
  Widget build(BuildContext context) {
    return new Column(
        children: this
            .options
            .map((option) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Color(Constants.COLORS_UVA_BLUE),
                  title: Text(option.description!),
                  value: this.chosen[option.id],
                  onChanged: (bool? value) {
                    setState(() {
                      // TODO (nphair): Update the bloc too
                      this.chosen[option.id!] = value!;
                    });
                  },
                ))
            .toList());
  }
}
