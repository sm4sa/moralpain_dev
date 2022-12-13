//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

// ignore: unused_import
import 'dart:convert';
import 'package:moralpainapi/src/deserialize.dart';
import 'package:dio/dio.dart';

import 'package:moralpainapi/src/model/analytics_result.dart';
import 'package:moralpainapi/src/model/submissions.dart';

class AdminApi {

  final Dio _dio;

  const AdminApi(this._dio);

  /// Get survey results
  /// Fetch from the database all of the records that match the query parameters. 
  ///
  /// Parameters:
  /// * [starttime] - Minimum possible timestamp of a record in UTC seconds since Unix epoch.
  /// * [endtime] - Maximum possible timestamp of a record in UTC seconds since Unix epoch.
  /// * [minscore] - Minimum possible score of a record.
  /// * [maxscore] - Maximum possible score of a record.
  /// * [uuid] - If this parameter is specified, all other parameters are ignored and only the submission with the given UUID is fetched. If no such submission exists, an empty list is fetched. 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Submissions] as data
  /// Throws [DioError] if API call or serialization fails
  Future<Response<Submissions>> getAdminSubmissions({ 
    int? starttime,
    int? endtime,
    int? minscore,
    int? maxscore,
    String? uuid,
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
      if (starttime != null) r'starttime': starttime,
      if (endtime != null) r'endtime': endtime,
      if (minscore != null) r'minscore': minscore,
      if (maxscore != null) r'maxscore': maxscore,
      if (uuid != null) r'uuid': uuid,
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
_responseData = deserialize<Submissions, Submissions>(_response.data!, 'Submissions', growable: true);
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
      if (starttime != null) r'starttime': starttime,
      if (endtime != null) r'endtime': endtime,
      r'operation': operation,
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
_responseData = deserialize<AnalyticsResult, AnalyticsResult>(_response.data!, 'AnalyticsResult', growable: true);
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

}
