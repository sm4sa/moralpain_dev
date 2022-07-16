import 'package:admin/screens/filter_submissions/filter_submissions.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FilterSubmissionsBloc', () {
    test('initial state is FilterSubmissionsState', () {
      expect(FilterSubmissionsBloc().state, equals(FilterSubmissionsState()));
    });

    group('StartTimeChanged', () {
      final starttime = '0';

      blocTest<FilterSubmissionsBloc, FilterSubmissionsState>(
        'emits new FilterSubmissionsState with updated start time',
        build: () => FilterSubmissionsBloc(),
        act: (bloc) => bloc.add(FilterSubmissionsStartTimeChanged(starttime)),
        expect: () => [FilterSubmissionsState(starttime: starttime)],
      );
    });

    group('EndTimeChanged', () {
      final endtime = '9999';

      blocTest<FilterSubmissionsBloc, FilterSubmissionsState>(
        'emits new FilterSubmissionsState with updated end time',
        build: () => FilterSubmissionsBloc(),
        act: (bloc) => bloc.add(FilterSubmissionsEndTimeChanged(endtime)),
        expect: () => [FilterSubmissionsState(endtime: endtime)],
      );
    });

    group('MinScoreChanged', () {
      final minscore = '4';

      blocTest<FilterSubmissionsBloc, FilterSubmissionsState>(
        'emits new FilterSubmissionsState with updated minimum score',
        build: () => FilterSubmissionsBloc(),
        act: (bloc) => bloc.add(FilterSubmissionsMinScoreChanged(minscore)),
        expect: () => [FilterSubmissionsState(minscore: minscore)],
      );
    });

    group('MaxScoreChanged', () {
      final maxscore = '4';

      blocTest<FilterSubmissionsBloc, FilterSubmissionsState>(
        'emits new FilterSubmissionsState with updated maximum score',
        build: () => FilterSubmissionsBloc(),
        act: (bloc) => bloc.add(FilterSubmissionsMaxScoreChanged(maxscore)),
        expect: () => [FilterSubmissionsState(maxscore: maxscore)],
      );
    });
  });
}
