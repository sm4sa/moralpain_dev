//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:moralpainapi/src/api_util.dart';
import 'package:moralpainapi/src/model/analytics_result.dart';
import 'package:moralpainapi/src/model/submissions.dart';

class AdminApi {

  final Dio _dio;

  final Serializers _serializers;

  const AdminApi(this._dio, this._serializers);

  /// Get data analysis
  /// Perform an analysis on the records in the database that match the query paramters. 
  ///
  /// Parameters:
  /// * [operation] - The analytic operation to perform on the data.
  /// * [starttime] - Minimum possible timestamp of a record in UTC seconds since Unix epoch.
  /// * [endtime] - Maximum possible timestamp of a record in UTC seconds since Unix epoch.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [AnalyticsResult] as data
  /// Throws [DioError] if API call or serialization fails
  Future<Response<AnalyticsResult>> getAnalytics({ 
    required String operation,
    int? starttime,
    int? endtime,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/admin/analytics';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (starttime != null) r'starttime': encodeQueryParameter(_serializers, starttime, const FullType(int)),
      if (endtime != null) r'endtime': encodeQueryParameter(_serializers, endtime, const FullType(int)),
      r'operation': encodeQueryParameter(_serializers, operation, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    AnalyticsResult _responseData;

    try {
      const _responseType = FullType(AnalyticsResult);
      _responseData = _serializers.deserialize(
        _response.data!,
        specifiedType: _responseType,
      ) as AnalyticsResult;

    } catch (error, stackTrace) {
      throw DioError(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioErrorType.other,
        error: error,
      )..stackTrace = stackTrace;
    }

    return Response<AnalyticsResult>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Get survey results
  /// Fetch from the database all of the records that match the query parameters. 
  ///
  /// Parameters:
  /// * [starttime] - Minimum possible timestamp of a record in UTC seconds since Unix epoch.
  /// * [endtime] - Maximum possible timestamp of a record in UTC seconds since Unix epoch.
  /// * [minscore] - Minimum possible score of a record.
  /// * [uuid] - If this parameter is set, all other parameters are ignored. This method fetches  only the submission with the given UUID, or an empty list if no such submission  exists. 
  /// * [maxscore] - Maximum possible score of a record.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Submissions] as data
  /// Throws [DioError] if API call or serialization fails
  Future<Response<Submissions>> getSubmissions({ 
    int? starttime,
    int? endtime,
    int? minscore,
    String? uuid,
    int? maxscore,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/admin/submissions';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (starttime != null) r'starttime': encodeQueryParameter(_serializers, starttime, const FullType(int)),
      if (endtime != null) r'endtime': encodeQueryParameter(_serializers, endtime, const FullType(int)),
      if (minscore != null) r'minscore': encodeQueryParameter(_serializers, minscore, const FullType(int)),
      if (uuid != null) r'uuid': encodeQueryParameter(_serializers, uuid, const FullType(String)),
      if (maxscore != null) r'maxscore': encodeQueryParameter(_serializers, maxscore, const FullType(int)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Submissions _responseData;

    try {
      const _responseType = FullType(Submissions);
      _responseData = _serializers.deserialize(
        _response.data!,
        specifiedType: _responseType,
      ) as Submissions;

    } catch (error, stackTrace) {
      throw DioError(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioErrorType.other,
        error: error,
      )..stackTrace = stackTrace;
    }

    return Response<Submissions>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

}
