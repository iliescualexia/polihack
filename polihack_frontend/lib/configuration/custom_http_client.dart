import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomHttpClient {
  static const String _baseURL = 'https://3750-5-2-197-133.ngrok.io/api';
  // static const String _baseURL = 'http://10.0.2.2:8080/api';
  Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };
  //valuez650
  //1557
  //Private constructor
  CustomHttpClient._internal();
  String get baseUrl => _baseURL;
  static final CustomHttpClient _singleton = CustomHttpClient._internal();

  // Factory constructor to return the same instance
  factory CustomHttpClient() => _singleton;

  Future<http.Response> get(
      {required String path, Map<String, String>? headers}) async {
    final combinedHeaders = {
      ...defaultHeaders,
      ...?headers,
    };
    return http.get(Uri.parse('$_baseURL$path'), headers: combinedHeaders);
  }

  Future<http.Response> post(
      {required String path,
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding}) async {
    final combinedHeaders = {
      ...defaultHeaders,
      ...?headers,
    };
    return http.post(Uri.parse('$_baseURL$path'),
        headers: combinedHeaders, body: body, encoding: encoding);
  }

  Future<http.Response> put({
    required String path,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final combinedHeaders = {
      ...defaultHeaders,
      ...?headers,
    };
    return http.put(Uri.parse('$_baseURL$path'),
        headers: combinedHeaders, body: body, encoding: encoding);
  }


  void updateHeader(String key, String value) {
    defaultHeaders[key] = value;
  }

  void resetHeaders() {
    defaultHeaders = {
      'Content-Type': 'application/json',
    };
  }
}
