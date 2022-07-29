import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/datetime/datetime.dart';
import 'package:submission_site/home/home.dart';

class DatetimeView extends StatelessWidget {
  const DatetimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatetimeBloc, DatetimeState>(
      buildWhen: (previous, current) {
        return previous.year != current.year ||
            previous.month != current.month ||
            previous.day != current.day;
      },
      builder: (context, state) {
        final datetimeBloc = BlocProvider.of<DatetimeBloc>(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Change date/time of submission?')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            hint: const Text('Year'),
                            items: [
                              for (int i = 1970;
                                  i <= DateTime.now().year + 1;
                                  i++)
                                DropdownMenuItem<int>(
                                  value: i,
                                  child: Text('$i'),
                                ),
                            ],
                            value: state.year,
                            onChanged: (value) {
                              datetimeBloc.add(DatetimeYearChanged(value!));
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<Month>(
                            hint: const Text('Month'),
                            items: [
                              for (Month month in Month.values)
                                DropdownMenuItem<Month>(
                                  value: month,
                                  child: Text(month.toString()),
                                ),
                            ],
                            value: state.month,
                            onChanged: (value) {
                              datetimeBloc.add(DatetimeMonthChanged(value!));
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            hint: const Text('Day'),
                            items: [
                              for (int i = 1;
                                  i <= state.month.numberOfDays(state.year);
                                  i++)
                                DropdownMenuItem<int>(
                                  value: i,
                                  child: Text('$i'),
                                ),
                            ],
                            value: state.day,
                            onChanged: (value) {
                              datetimeBloc.add(DatetimeDayChanged(value!));
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            hint: const Text('Hour'),
                            items: [
                              for (int i = 0; i <= 23; i++)
                                DropdownMenuItem<int>(
                                  value: i,
                                  child: Text('$i'),
                                ),
                            ],
                            value: state.hour,
                            onChanged: (value) {
                              datetimeBloc.add(DatetimeHourChanged(value!));
                            },
                          ),
                        ),
                      ),
                    ),
                    const Text(':'),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            hint: const Text('Minute'),
                            items: [
                              for (int i = 0; i <= 59; i++)
                                DropdownMenuItem<int>(
                                  value: i,
                                  child: i < 10 ? Text('0$i') : Text('$i'),
                                ),
                            ],
                            value: state.minute,
                            onChanged: (value) {
                              datetimeBloc.add(DatetimeMinuteChanged(value!));
                            },
                          ),
                        ),
                      ),
                    ),
                    const Text(':'),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<int>(
                            hint: const Text('Second'),
                            items: [
                              for (int i = 0; i <= 59; i++)
                                DropdownMenuItem<int>(
                                  value: i,
                                  child: i < 10 ? Text('0$i') : Text('$i'),
                                ),
                            ],
                            value: state.second,
                            onChanged: (value) {
                              datetimeBloc.add(DatetimeSecondChanged(value!));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
                          final datetime = DateTime.utc(
                            state.year,
                            state.month.toInt(),
                            state.day,
                            state.hour,
                            state.minute,
                            state.second,
                          );
                          final int timestamp =
                              (datetime.millisecondsSinceEpoch / 1000) as int;
                          final homeBloc = BlocProvider.of<HomeBloc>(context);
                          homeBloc.add(HomeTimestampChanged(timestamp));
                          Navigator.pop(context);
                        },
                        child: const Text('OK')),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
