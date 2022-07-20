import 'package:analytics_site/api_repository.dart';
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

    AnalyticsResult returnResult = AnalyticsResult();
    Future<Response<AnalyticsResult>> returnResponse = Future.value(
      Response<AnalyticsResult>(
        data: returnResult,
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
      when(() => aapi.getAnalytics(
            operation: any(named: 'operation'),
            starttime: any(named: 'starttime'),
            endtime: any(named: 'endtime'),
          )).thenAnswer((_) => returnResponse);
    });

    group('fetchAnalytics', () {
      String operation = 'minimum';
      int? starttime = 1640995200;
      int? endtime = 1647907200;

      test('calls getAnalytics with correct parameters', () async {
        try {
          await apiRepository.fetchAnalytics(
            operation: operation,
            starttime: starttime,
            endtime: endtime,
          );
        } catch (_) {}
        verify(() => aapi.getAnalytics(
              operation: operation,
              starttime: starttime,
              endtime: endtime,
            )).called(1);
      });

      test('throws when getAnalytics fails', () async {
        when(() => aapi.getAnalytics(
              operation: any(named: 'operation'),
              starttime: any(named: 'starttime'),
              endtime: any(named: 'endtime'),
            )).thenThrow(Exception('oops'));
        expect(
          () async => await apiRepository.fetchAnalytics(
            operation: operation,
            starttime: starttime,
            endtime: endtime,
          ),
          throwsA(isA<AnalyticsFetchFailure>()),
        );
      });

      test('returns correct AnalyticsResult on success', () async {
        expect(
          await apiRepository.fetchAnalytics(
            operation: operation,
            starttime: starttime,
            endtime: endtime,
          ),
          equals(returnResult),
        );
      });
    });
  });
}
