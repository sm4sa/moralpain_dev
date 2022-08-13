import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/datetime/datetime.dart';

class DayDropdown extends Dropdown {
  DayDropdown() : super(key: const Key('datetimeView_dayDropdown'));

  @override
  DropdownButtonFormField<int> buildFormField(BuildContext context) {
    final DatetimeBloc datetimeBloc = BlocProvider.of(context);
    return DropdownButtonFormField<int>(
      hint: const Text('Day'),
      items: [
        for (int i = 1;
            i <= datetimeBloc.state.month.numberOfDays(datetimeBloc.state.year);
            i++)
          DropdownMenuItem<int>(
            value: i,
            child: Text('$i'),
          ),
      ],
      value: datetimeBloc.state.day,
      onChanged: (value) {
        datetimeBloc.add(DatetimeDayChanged(value!));
      },
    );
  }
}
