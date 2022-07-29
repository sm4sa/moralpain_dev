import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/home/home.dart';
import 'package:submission_site/score/score.dart';

class ScoreRoute extends StatelessWidget {
  const ScoreRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return BlocProvider<ScoreCubit>(
      create: (_) => ScoreCubit(bloc.state.score),
      child: const ScoreView(),
    );
  }
}
