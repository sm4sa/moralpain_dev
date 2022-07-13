import 'package:admin/screens/filter_submissions/filter_submissions.dart';
import 'package:admin/screens/submissions/bloc/submissions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterSubmissionsView extends StatelessWidget {
  const FilterSubmissionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              key: const Key('filterSubmissionsView_startTime_textField'),
              onChanged: (starttime) =>
                  BlocProvider.of<FilterSubmissionsBloc>(context).add(
                FilterSubmissionsStartTimeChanged(starttime),
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Start timestamp',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              key: const Key('filterSubmissionsView_endTime_textField'),
              onChanged: (endtime) =>
                  BlocProvider.of<FilterSubmissionsBloc>(context).add(
                FilterSubmissionsEndTimeChanged(endtime),
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'End timestamp',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              key: const Key('filterSubmissionsView_minScore_textField'),
              onChanged: (minscore) =>
                  BlocProvider.of<FilterSubmissionsBloc>(context).add(
                FilterSubmissionsMinScoreChanged(minscore),
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Min score',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              key: const Key('filterSubmissionsView_maxScore_textField'),
              onChanged: (maxscore) =>
                  BlocProvider.of<FilterSubmissionsBloc>(context).add(
                FilterSubmissionsMaxScoreChanged(maxscore),
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Max score',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        ElevatedButton(
          key: const Key('filterSubmissionsView_filter_elevatedButton'),
          onPressed: () {
            FilterSubmissionsState state =
                BlocProvider.of<FilterSubmissionsBloc>(context).state;
            BlocProvider.of<SubmissionsBloc>(context).add(
              SubmissionsLoadEvent(
                starttime: state.starttime != null
                    ? int.tryParse(state.starttime!)
                    : null,
                endtime:
                    state.endtime != null ? int.tryParse(state.endtime!) : null,
                minscore: state.minscore != null
                    ? int.tryParse(state.minscore!)
                    : null,
                maxscore: state.starttime != null
                    ? int.tryParse(state.maxscore!)
                    : null,
              ),
            );
          },
          child: Text('Filter'),
        )
      ],
    );
  }
}
