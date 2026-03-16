import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dio;

  static Dio getInstance() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: "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", // TODO: supply real base URL
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 3000),
        ),
      );
    }
    return _dio!;
  }
}