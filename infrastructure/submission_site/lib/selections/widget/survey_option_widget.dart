import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/selections/selections.dart';

class SurveyOptionsWidget extends StatelessWidget {
  final List<SurveyOption> options;
  final String sectionId;

  const SurveyOptionsWidget(this.sectionId, this.options, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map(
        (option) {
          return SurveyOptionListTile(option);
        },
      ).toList(),
    );
  }
}

class SurveyOptionListTile extends StatefulWidget {
  final SurveyOption option;

  const SurveyOptionListTile(this.option, {Key? key}) : super(key: key);

  @override
  State<SurveyOptionListTile> createState() => _SurveyOptionListTileState();
}

class _SurveyOptionListTileState extends State<SurveyOptionListTile> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SelectionsBloc>(context);
    _checked = bloc.state.selections.contains(widget.option.id!);
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(widget.option.description!),
      value: _checked,
      onChanged: (bool? value) {
        setState(() {
          _checked = value!;
        });
        if (value!) {
          bloc.add(SelectionsSelectionAdded(widget.option.id!));
        } else {
          bloc.add(SelectionsSelectionRemoved(widget.option.id!));
        }
      },
    );
  }
}
