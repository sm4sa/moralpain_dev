import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/datetime/datetime.dart';

class MonthDropdown extends Dropdown {
  MonthDropdown() : super(key: const Key('datetimeView_monthDropdown'));

  @override
  DropdownButtonFormField<Month> buildFormField(BuildContext context) {
    final DatetimeBloc datetimeBloc = BlocProvider.of(context);
    return DropdownButtonFormField<Month>(
      hint: const Text('Month'),
      items: [
        for (Month month in Month.values)
          DropdownMenuItem<Month>(
            value: month,
            child: Text(month.toString()),
          ),
      ],
      value: datetimeBloc.state.month,
      onChanged: (value) {
        datetimeBloc.add(DatetimeMonthChanged(value!));
      },
    );
  }
}
