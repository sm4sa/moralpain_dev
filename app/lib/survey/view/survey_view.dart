import 'package:flutter/foundation.dart';
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
    return BlocConsumer<SurveyBloc, SurveyState>(
        listenWhen: (previous, current) =>
            current is SurveyComplete || current is SurveySubmitting,
        listener: (context, state) => handleSubmitEvents(context, state),
        buildWhen: (previous, current) =>
            current is SurveyLoading || current is SurveyLoaded,
        builder: (context, state) => handleLoadEvents(context, state));
  }

  /**
   * Invoked by the BlocListener when a survey is submitted. 
   * Returns to the home screen.
   */
  void handleSubmitEvents(BuildContext context, SurveyState state) {
    if (state is SurveySubmitting) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: submittingScreenBuilder);
    } else if (state is SurveyComplete) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      assert(false);
    }
  }

  /**
   * A builder function that returns an overlay with a loading bar.
   */
  Widget submittingScreenBuilder(BuildContext context) => AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: UVALinearProgressIndicator()));

  Widget handleLoadEvents(BuildContext context, SurveyState state) {
    final title = Text(
      Constants.SURVEY_TITLE,
      style: TextStyle(fontSize: 16),
    );

    final spacer = SizedBox(
      height: 10,
    );

    final instructions = ExpandableText(
      Constants.SURVEY_INSTRUCTIONS,
      expandText: Constants.SURVEY_EXPAND_TEXT,
      collapseText: Constants.SURVEY_COLLAPSE_TEXT,
      maxLines: 1,
      linkEllipsis: false,
      linkColor: Colors.blue,
      textAlign: TextAlign.center,
    );

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
                title,
                spacer,
                instructions,
                spacer,
                surveyFromState(state)
              ])),
      floatingActionButton: Visibility(
        visible: _show,
        child: FloatingActionButton(
            onPressed: () {
              context.read<SurveyBloc>().add(SurveySubmitEvent());
            },
            child: Icon(Icons.send),
            backgroundColor: const Color(Constants.COLORS_UVA_BLUE)),
      ),
    );
  }

  /**
   * Returns a view of the survey depending on the current state.
   * 
   * Only invoked on SurveyLoaded and SurveyLoading states.
   */
  Widget surveyFromState(SurveyState state) {
    if (state is SurveyLoading) {
      return Expanded(child: Center(child: UVACircularProgressIndicator()));
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
      assert(false);
      return ErrorWidget("Error State");
    }
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
          SurveyOptionsWidget(section.sectionId!, section.options!.asList())
        ],
      ),
    );
  }
}

class SurveyOptionsWidget extends StatefulWidget {
  final List<SurveyOption> options;
  final String sectionId;

  SurveyOptionsWidget(this.sectionId, this.options);

  @override
  SurveyOptionsWidgetState createState() =>
      new SurveyOptionsWidgetState(sectionId, options);
}

class SurveyOptionsWidgetState extends State<SurveyOptionsWidget> {
  final List<SurveyOption> options;
  final String sectionId;

  SurveyOptionsWidgetState(this.sectionId, this.options);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SurveyBloc, SurveyState, bool>(
        selector: (state) => state is SurveyUpdated,
        builder: (ctx, state) {
          final bloc = context.read<SurveyBloc>();

          return new Column(
              children: this.options.map((option) {
            // Prepend section id to try and establish unique option ids.
            final optionId = '${this.sectionId}_${option.id}';
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Color(Constants.COLORS_UVA_BLUE),
              title: Text(option.description!),
              value: bloc.options.putIfAbsent(optionId, () => false),
              onChanged: (bool? value) {
                setState(() {
                  bloc.add(SurveyUpdateEvent(optionId, value!));
                });
              },
            );
          }).toList());
        });
  }
}

class UVACircularProgressIndicator extends CircularProgressIndicator {
  @override
  Color? get backgroundColor => Color(Constants.COLORS_UVA_BLUE);

  @override
  Animation<Color?>? get valueColor =>
      AlwaysStoppedAnimation(Color(Constants.COLORS_UVA_ORANGE));
}

class UVALinearProgressIndicator extends LinearProgressIndicator {
  @override
  double? get minHeight => 10;

  @override
  Color? get backgroundColor => Color(Constants.COLORS_UVA_BLUE);

  @override
  Animation<Color?>? get valueColor =>
      AlwaysStoppedAnimation(Color(Constants.COLORS_UVA_ORANGE));
}
