import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/datetime/datetime.dart';
import 'package:submission_site/home/home.dart';
import 'package:submission_site/score/score.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<HomeBloc>(context);
        return Scaffold(
          appBar: AppBar(title: Text('Submission ID ${state.id}')),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FieldDisplay(
                  text: 'Time submitted: ${DateTime.fromMillisecondsSinceEpoch(
                    state.timestamp * 1000,
                  ).toString()}',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<HomeBloc>.value(
                          value: bloc,
                          child: const DatetimeRoute(),
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
                FieldDisplay(
                  text: 'Score: ${state.score} out of 10',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<HomeBloc>.value(
                          value: bloc,
                          child: const ScoreRoute(),
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
                FieldDisplay(
                  text: 'Contributing factors: ${state.selections}',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
