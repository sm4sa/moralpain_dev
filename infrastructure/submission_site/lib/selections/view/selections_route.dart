import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/home/home.dart';
import 'package:submission_site/selections/selections.dart';

class SelectionsRoute extends StatelessWidget {
  const SelectionsRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocProvider<SelectionsBloc>(
      create: (_) => SelectionsBloc(homeBloc.state.selections),
      child: const SelectionsView(),
    );
  }
}
