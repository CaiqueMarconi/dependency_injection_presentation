import 'package:dependency_injection_presentation/service/i_http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpService implements IHttpService {
  final Dio http;

  HttpService(this.http);
  @override
  Future<void> getHtpp() async {
    try {
      var response = await http.get('http://www.google.com');
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
