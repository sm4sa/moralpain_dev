import 'package:admin/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';
/*import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';*/
import 'package:moralpainapi/moralpainapi.dart';

class MockApiRepository extends Mock implements ApiRepository {}

class MockMoralpainapi extends Mock implements Moralpainapi {}

class MockAdminApi extends Mock implements AdminApi {}

class MockLogger extends Mock implements Logger {}

//@GenerateMocks([MockApiRepository])
void main() {
  group('ApiRepository', () {
    late ApiRepository apiRepository;
    late Moralpainapi mapi;
    late AdminApi aapi;

    setUp(() {
      apiRepository = MockApiRepository();
      mapi = MockMoralpainapi();
      aapi = MockAdminApi();

      when(() => apiRepository.mapi).thenReturn(mapi);
      when(() => mapi.getAdminApi()).thenReturn(aapi);
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
        when(() => aapi.getSubmissions()).thenThrow(Exception('oops'));
        expect(
          await apiRepository.fetchSubmissions(),
          throwsA(SubmissionsFetchFailure),
        );
      });
    });

    test('returns correct Submissions list on success', () async {
      when(() async => await aapi.getSubmissions())
          .thenAnswer((_) => Future.value(
                Response<Submissions>(
                  data: Submissions(),
                  requestOptions: RequestOptions(path: ''),
                ),
              ));

      expect(
        await apiRepository.fetchSubmissions(),
        equals(Submissions()),
      );
    });
  });
}
