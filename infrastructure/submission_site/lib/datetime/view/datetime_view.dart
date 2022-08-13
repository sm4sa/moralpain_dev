import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/datetime/datetime.dart';
import 'package:submission_site/home/home.dart';
import 'package:submission_site/responsive.dart';

class DatetimeView extends StatelessWidget {
  const DatetimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatetimeBloc, DatetimeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Change date/time of submission?')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Responsive.isDesktop(context)
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          YearDropdown(),
                          MonthDropdown(),
                          DayDropdown(),
                          HourDropdown(),
                          const Text(':'),
                          MinuteDropdown(),
                          const Text(':'),
                          SecondDropdown()
                        ],
                      )
                    : Wrap(
                        children: [
                          YearDropdown(),
                          MonthDropdown(),
                          DayDropdown(),
                          HourDropdown(),
                          const Center(
                            child: Text(':'),
                          ),
                          MinuteDropdown(),
                          const Center(
                            child: Text(':'),
                          ),
                          SecondDropdown()
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
                              (datetime.millisecondsSinceEpoch / 1000).floor();
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
