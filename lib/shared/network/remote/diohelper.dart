import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        connectTimeout: 50000,
        receiveTimeout: 50000,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> getData({
    @required var url,
    @required Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
      'lang': 'ar',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': token ?? '',
        'Content-Type': 'application/json',
        'lang': 'ar',
      };
      return await dio.post(
        url,
        data: data,
      );
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(error.message);
    }
  }
}
