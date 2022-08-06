import 'package:aws_signature_v4_interceptor/aws_signature_v4_interceptor.dart';

import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() async {
  // NB (nphair): Skipping until we can mock out the endpoint.
  test('#test interceptor', () async {
    Dio dio = Dio();
    dio.options.baseUrl =
        'https://umd7orqgt1.execute-api.us-east-1.amazonaws.com/v1';

    // Register the interceptor.
    const provider = AWSCredentialsProvider.dartEnvironment();
    const region = 'us-east-1';
    final scope =
        AWSCredentialScope.raw(region: region, service: 'execute-api');
    dio.interceptors..add(AWSSignatureInterceptor(provider, scope));

    Response response = await dio.get<dynamic>('/survey');
    assert(response.data.toString().isNotEmpty);
    assert(response.statusCode == 200);
  }, skip: true);
}
