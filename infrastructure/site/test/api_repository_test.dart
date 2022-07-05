import 'package:admin/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moralpainapi/moralpainapi.dart';

class MockMoralpainapi extends Mock implements Moralpainapi {}

class MockAdminApi extends Mock implements AdminApi {}

extension AddApi on ApiRepository {
  void setApi(Moralpainapi mapi) {
    this.mapi = mapi;
  }
}

void main() {
  group('ApiRepository', () {
    late ApiRepository apiRepository;
    late Moralpainapi mapi;
    late AdminApi aapi;

    Submissions returnSubmissions = Submissions();
    Future<Response<Submissions>> returnResponse = Future.value(
      Response<Submissions>(
        data: returnSubmissions,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    setUpAll(() {
      int? fallback = 0;
      registerFallbackValue(fallback);
    });

    setUp(() {
      apiRepository = ApiRepository();
      mapi = MockMoralpainapi();
      aapi = MockAdminApi();

      apiRepository.setApi(mapi);
      when(() => mapi.getAdminApi()).thenReturn(aapi);
      when(() => aapi.getSubmissions(
            starttime: any(named: 'starttime'),
            endtime: any(named: 'endtime'),
            minscore: any(named: 'minscore'),
            maxscore: any(named: 'maxscore'),
          )).thenAnswer((_) => returnResponse);
    });

    group('fetchSubmissions', () {
      int? starttime = 1640995200;
      int? endtime = 1647907200;
      int? minscore = 0;
      int? maxscore = 10;

      test('calls getSubmissions with correct parameters', () async {
        try {
          await apiRepository.fetchSubmissions(
            starttime: starttime,
            endtime: endtime,
            minscore: minscore,
            maxscore: maxscore,
          );
        } catch (_) {}
        verify(() => aapi.getSubmissions(
              starttime: starttime,
              endtime: endtime,
              minscore: minscore,
              maxscore: maxscore,
            )).called(1);
      });

      test('throws when getSubmissions fails', () async {
        when(() => aapi.getSubmissions(
              starttime: any(named: 'starttime'),
              endtime: any(named: 'endtime'),
              minscore: any(named: 'minscore'),
              maxscore: any(named: 'maxscore'),
            )).thenThrow(Exception('oops'));
        expect(
          () async => await apiRepository.fetchSubmissions(
            starttime: starttime,
            endtime: endtime,
            minscore: minscore,
            maxscore: maxscore,
          ),
          throwsA(isA<SubmissionsFetchFailure>()),
        );
      });

      test('returns correct Submissions list on success', () async {
        expect(
          await apiRepository.fetchSubmissions(
            starttime: starttime,
            endtime: endtime,
            minscore: minscore,
            maxscore: maxscore,
          ),
          equals(returnSubmissions),
        );
      });
    });
  });
}
