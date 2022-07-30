import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/datetime/datetime.dart';
import 'package:submission_site/home/home.dart';

class DatetimeRoute extends StatelessWidget {
  const DatetimeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return BlocProvider<DatetimeBloc>(
      create: (_) => DatetimeBloc(bloc.state.timestamp!),
      child: const DatetimeView(),
    );
  }
}
