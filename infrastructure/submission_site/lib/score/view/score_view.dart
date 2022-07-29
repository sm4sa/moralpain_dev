import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/home/home.dart';
import 'package:submission_site/score/score.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ScoreCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Change score?')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                hint: const Text('Score'),
                items: [
                  for (int i = 0; i <= 10; i++)
                    DropdownMenuItem<int>(
                      value: i,
                      child: Text('$i'),
                    ),
                ],
                value: cubit.state,
                onChanged: (value) {
                  cubit.set(value as int);
                },
              ),
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
                      final bloc = BlocProvider.of<HomeBloc>(context);
                      bloc.add(HomeScoreSet(cubit.state));
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
