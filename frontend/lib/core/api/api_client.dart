import 'package:dio/dio.dart';
import 'package:plotvote/core/api/api_config.dart';
import 'package:plotvote/core/api/interceptors/token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  Dio getDio({bool tokenInterceptor = false}) {
    // 1) Configure real timeouts here:
    final dio = Dio(BaseOptions(
      baseUrl: ApiConfig.BASE_URL_FOR_DIO,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ));

    if (tokenInterceptor) {
      dio.interceptors.add(TokenInterceptor(dio: dio));
    }

    dio.interceptors.add(PrettyDioLogger(
      responseHeader: true,
      responseBody: true,
      requestHeader: true,
      requestBody: true,
      request: true,
      compact: false,
    ));

    return dio;
  }
}
