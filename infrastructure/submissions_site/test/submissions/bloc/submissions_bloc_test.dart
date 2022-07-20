import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submissions_site/api_repository.dart';
import 'package:submissions_site/submissions/submissions.dart';

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  final mockSubmissionList = <Submission>[];
  late Submissions mockSubmissions;

  group('SubmissionsBloc', () {
    late ApiRepository apiRepository;

    setUp(() {
      apiRepository = MockApiRepository();
      when(
        () => apiRepository.fetchCollection(any()),
      ).thenAnswer((_) => Future.value(mockSubmissionList));

      final builder = SubmissionsBuilder();
      builder.list = ListBuilder(mockSubmissionList);
      mockSubmissions = builder.build();
    });

    SubmissionsBloc buildBloc() {
      return SubmissionsBloc(repository: apiRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(SubmissionsInitial()),
        );
      });
    });

    group('SubmissionsLoad', () {
      final int? starttime = 1640995200;
      final int? endtime = 1647907200;
      final int? minscore = 0;
      final int? maxscore = 10;

      SubmissionsEvent buildEvent() {
        return SubmissionsLoadEvent(
          starttime: starttime,
          endtime: endtime,
          minscore: minscore,
          maxscore: maxscore,
        );
      }

      blocTest<SubmissionsBloc, SubmissionsState>(
        'fetches list of submissions from repository',
        build: buildBloc,
        act: (bloc) => bloc.add(buildEvent()),
        verify: (_) {
          verify(() => apiRepository.fetchCollection({
                'starttime': starttime,
                'endtime': endtime,
                'minscore': minscore,
                'maxscore': maxscore,
              })).called(1);
        },
      );

      blocTest<SubmissionsBloc, SubmissionsState>(
        'emits state with list of submissions '
        'when fetchSubmissions completes properly',
        build: buildBloc,
        act: (bloc) => bloc.add(buildEvent()),
        expect: () => [
          SubmissionsLoading(),
          SubmissionsLoaded(mockSubmissions),
        ],
      );

      blocTest<SubmissionsBloc, SubmissionsState>(
        'emits failure state '
        'when fetchSubmissions fails',
        setUp: () {
          when(() => apiRepository.fetchCollection({
                'starttime': starttime,
                'endtime': endtime,
                'minscore': minscore,
                'maxscore': maxscore,
              })).thenThrow(Exception('oops'));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(buildEvent()),
        expect: () => [
          SubmissionsLoading(),
          SubmissionsLoadFailed(),
        ],
      );
    });
  });
}
