import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/home/home.dart';
import 'package:submission_site/selections/selections.dart';

class SelectionsView extends StatelessWidget {
  const SelectionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final selectionsBloc = BlocProvider.of<SelectionsBloc>(context);
    final survey = homeBloc.state.survey!;
    return Scaffold(
      appBar: AppBar(title: const Text('Change contributing factors?')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: survey.sections!.map((s) => cardForSection(s)).toList(),
            ),
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 30.0),
              ElevatedButton(
                  onPressed: () {
                    homeBloc.add(
                        HomeSelectionsChanged(selectionsBloc.state.selections));
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          )
        ],
      ),
    );
  }

  Widget cardForSection(SurveySection section) {
    return ExpansionTileCard(
      title: Text(section.title!),
      subtitle: Text(section.subtitle!),
      initialElevation: 3,
      elevation: 3,
      initialPadding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      finalPadding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SurveyOptionsWidget(section.sectionId!, section.options!.asList())
          ],
        )
      ],
    );
  }
}
