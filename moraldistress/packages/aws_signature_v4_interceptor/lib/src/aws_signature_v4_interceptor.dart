import 'dart:convert';

import 'package:aws_common/aws_common.dart';

import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:dio/dio.dart';

class AWSSignatureInterceptor extends Interceptor {
  AWSCredentialsProvider credentialsProvider;
  AWSCredentialScope awsCredentialScope;

  AWSSignatureInterceptor(this.credentialsProvider, this.awsCredentialScope);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var signer = AWSSigV4Signer(credentialsProvider: this.credentialsProvider);

    // NB (nphair): May have to be smarter about the header mapping.
    final request = AWSHttpRequest(
        method: AWSHttpMethod.fromString(options.method),
        uri: options.uri,
        headers: options.headers
            .map((key, dynamic value) => MapEntry(key, '${value}')),
        body: options.data?.toString().codeUnits ?? "".codeUnits);

    final signedRequest = signer.signSync(
      request,
      credentialScope: awsCredentialScope,
    );

    options = options.copyWith(
        headers: signedRequest.headers, data: signedRequest.body);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
