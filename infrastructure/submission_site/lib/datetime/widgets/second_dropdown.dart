import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/datetime/datetime.dart';

class SecondDropdown extends Dropdown {
  SecondDropdown() : super(key: const Key('datetimeView_secondDropdown'));

  @override
  DropdownButtonFormField<int> buildFormField(BuildContext context) {
    final DatetimeBloc datetimeBloc = BlocProvider.of(context);
    return DropdownButtonFormField<int>(
      hint: const Text('Second'),
      items: [
        for (int i = 0; i <= 59; i++)
          DropdownMenuItem<int>(
            value: i,
            child: i < 10 ? Text('0$i') : Text('$i'),
          ),
      ],
      value: datetimeBloc.state.second,
      onChanged: (value) {
        datetimeBloc.add(DatetimeSecondChanged(value!));
      },
    );
  }
}
