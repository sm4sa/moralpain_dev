import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/datetime/datetime.dart';

class YearDropdown extends Dropdown {
  YearDropdown() : super(key: const Key('datetimeView_yearDropdown'));

  @override
  DropdownButtonFormField<int> buildFormField(BuildContext context) {
    final DatetimeBloc datetimeBloc = BlocProvider.of(context);
    return DropdownButtonFormField<int>(
      hint: const Text('Year'),
      items: [
        for (int i = 1970; i <= DateTime.now().year + 1; i++)
          DropdownMenuItem<int>(
            value: i,
            child: Text('$i'),
          ),
      ],
      value: datetimeBloc.state.year,
      onChanged: (value) {
        datetimeBloc.add(DatetimeYearChanged(value!));
      },
    );
  }
}
