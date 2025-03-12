import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logistx/router/service/user_storage.dart';

final class ClientService {
  static const ClientService _service = ClientService._internal();

  const ClientService._internal();

  factory ClientService() => _service;

  static const String baseUrl = 'api.yodimdasiz.uz';
  static const String _version = '/api';

  static const String register = '$_version/auth/sign-up';
  static const String code = '$_version/auth/verify-account';
  static const String login = '$_version/auth/sign-in';
  static const String resendCode = '$_version/auth/resend-code';
  static const String forgetPassword = '$_version/auth/forgot-password';
  static const String checkForgetPassword =
      '$_version/auth/check-forgot-password';
  static const String findPost = '$_version/posts/find/';
  static const String getAllPost = '$_version/posts/all';
  static const String userMe = '$_version/users/me';
  static const String comments = '$_version/comments/all/';
  static const String myPosts = '$_version/posts/my';

  static Future<String?> get({
    required String api,
    bool isAuthHeaderNeeded = false,
    Map<String, dynamic>? param,
  }) async {
    final httpClient = HttpClient();

    // Load tokens
    final String? token =
        isAuthHeaderNeeded
            ? await UserStorage.load(key: StorageKey.token)
            : null;

    try {
      // Build the request URL
      final url = Uri.https(baseUrl, api, param);
      debugPrint("Request URL: $url>>>>>>");

      // Create the request
      final request = await httpClient.getUrl(url);
      request.headers.set('Content-Type', 'application/json');
      if (isAuthHeaderNeeded && token != null) {
        request.headers.set('Authorization', 'Bearer $token');
      }

      // Send the request
      final response = await request.close();
      debugPrint(">>> Response Status Code: ${response.statusCode}>>>>>>");

      // Handle success rpplication/jsonesponses
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = await response.transform(utf8.decoder).join();
        return responseBody;
      }
      // Handle other status codes
      debugPrint(">>> Unhandled Status Code: ${response.statusCode}>>>>>>");
      return null;
    } catch (e) {
      debugPrint(">>> Error: $e");
      return null;
    } finally {
      httpClient.close();
    }
  }

  static Future<String?> post({
    required String api,
    Map<String, Object?>? data,
    bool isAuthHeaderNeeded = false,
    bool isFormData = false,
    Map<String, dynamic>? param,
  }) async {
    final httpClient = HttpClient();

    // Load tokens
    final String? token =
        isAuthHeaderNeeded
            ? await UserStorage.load(key: StorageKey.token)
            : null;

    try {
      // Build the request URL
      final url = Uri.https(baseUrl, api, param);
      debugPrint(">>> Request URL: $url>>>>>");

      // Create the request
      final request = await httpClient.postUrl(url);

      // Set headers
      if (isAuthHeaderNeeded && token != null) {
        request.headers.set('Authorization', 'Bearer $token');
      }
      if (isFormData) {
        const boundary = '----dart_http_boundary';
        request.headers.set(
          'Content-Type',
          'multipart/form-data; boundary=$boundary',
        );
        final body = _encodeFormData(data, boundary);
        request.contentLength = utf8.encode(body).length;
        request.write(body);
      } else {
        request.headers.set('Content-Type', 'application/json');
        if (data != null) {
          final jsonData = jsonEncode(data);
          request.add(utf8.encode(jsonData));
        }
      }

      // Send the request
      final response = await request.close();
      debugPrint(">>>Response Status Code: ${response.statusCode}>>>>>>");

      // Handle success responses
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        final responseBody = await response.transform(utf8.decoder).join();
        debugPrint(">>>Response Body: $responseBody>>>>>>");
        return responseBody;
      } else {
        final responseBody = await response.transform(utf8.decoder).join();
        debugPrint(">>>Response Body: $responseBody>>>>>>");
      }

      debugPrint(">>> Unhandled Status Code: ${response.statusCode}>>>>>");
      return null;
    } catch (e) {
      debugPrint(">>> Error: $e");
      return null;
    } finally {
      httpClient.close();
    }
  }

  static String _encodeFormData(Map<String, Object?>? data, String boundary) {
    final buffer = StringBuffer();
    data?.forEach((key, value) {
      if (value is List<Object?>) {
        for (var item in value) {
          buffer.write('--$boundary\r\n');
          buffer.write('Content-Disposition: form-data; name="$key"\r\n\r\n');
          buffer.write('$item\r\n');
        }
      } else {
        buffer.write('--$boundary\r\n');
        buffer.write('Content-Disposition: form-data; name="$key"\r\n\r\n');
        buffer.write('$value\r\n');
      }
    });
    buffer.write('--$boundary--\r\n');
    return buffer.toString();
  }

  static Future<String?> put({
    required String api,
    Map<String, Object?>? data,
    bool isAuthHeaderNeeded = false,
    Map<String, dynamic>? param,
  }) async {
    final token =
        isAuthHeaderNeeded
            ? await UserStorage.load(key: StorageKey.token)
            : isAuthHeaderNeeded;
    final httpClient = HttpClient();
    try {
      final url = Uri.https(baseUrl, api, param);
      final request = await httpClient.putUrl(url);
      request.headers.set('Content-Type', 'application/json');
      if (isAuthHeaderNeeded) {
        request.headers.set('Authorization', 'Bearer $token');
      }
      if (isAuthHeaderNeeded) {
        request.headers.set('Accept', 'application/x-www-form-urlencoded');
      }
      request.add(utf8.encode(jsonEncode(data)));
      final response = await request.close();
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        final responseBody = await response.transform(utf8.decoder).join();
        return responseBody;
      } else {
        return null;
      }
    } finally {
      httpClient.close();
    }
  }

  Future<String?> delete({
    required String api,
    bool isAuthHeaderNeeded = false,
  }) async {
    final token =
        isAuthHeaderNeeded
            ? await UserStorage.load(key: StorageKey.token)
            : null;
    final httpClient = HttpClient();
    try {
      final url = Uri.https(baseUrl, api);
      final request = await httpClient.deleteUrl(url);
      if (isAuthHeaderNeeded) {
        request.headers.set('Authorization', 'Bearer $token');
      }
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode == HttpStatus.noContent ||
          response.statusCode == HttpStatus.ok) {
        return responseBody;
      } else {
        return null;
      }
    } finally {
      httpClient.close();
    }
  }

  static Map<String, dynamic> paramEmpty() => const <String, dynamic>{};
  static Map<String, dynamic> paramGetBookings({required String type}) =>
      <String, dynamic>{'type': type};

  static Map<String, dynamic> paramGetMastersFreeTime({
    required String date,
    required String duration,
  }) => <String, dynamic>{'date': date, 'duration': duration};
}
