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
          return SurveyOptionListTile(sectionId: sectionId, option: option);
        },
      ).toList(),
    );
  }
}

class SurveyOptionListTile extends StatefulWidget {
  final String sectionId;

  final SurveyOption option;

  const SurveyOptionListTile({
    required this.sectionId,
    required this.option,
    Key? key,
  }) : super(key: key);

  @override
  State<SurveyOptionListTile> createState() => _SurveyOptionListTileState();
}

class _SurveyOptionListTileState extends State<SurveyOptionListTile> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SelectionsBloc>(context);
    _checked = bloc.state.selections.contains(_id);
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(widget.option.description!),
      value: _checked,
      onChanged: (bool? value) {
        setState(() {
          _checked = value!;
        });
        if (value!) {
          bloc.add(SelectionsSelectionAdded(_id));
        } else {
          bloc.add(SelectionsSelectionRemoved(_id));
        }
      },
    );
  }

  String get _id => '${widget.sectionId}_${widget.option.id!}';
}
