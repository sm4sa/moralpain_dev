import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/datetime/datetime.dart';

class HourDropdown extends Dropdown {
  HourDropdown() : super(key: const Key('datetimeView_hourDropdown'));

  @override
  DropdownButtonFormField<int> buildFormField(BuildContext context) {
    final DatetimeBloc datetimeBloc = BlocProvider.of(context);
    return DropdownButtonFormField<int>(
      hint: const Text('Hour'),
      items: [
        for (int i = 0; i <= 23; i++)
          DropdownMenuItem<int>(
            value: i,
            child: Text('$i'),
          ),
      ],
      value: datetimeBloc.state.hour,
      onChanged: (value) {
        datetimeBloc.add(DatetimeHourChanged(value!));
      },
    );
  }
}
