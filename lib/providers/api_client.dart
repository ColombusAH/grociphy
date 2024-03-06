import 'dart:convert';

import 'package:flutter_first_app/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final UserProvider userProvider;
  final serverAddress = 'http://10.0.2.2:3000/api';
  // final serverAddress = 'http://127.0.0.1:3000/api';

  ApiClient({required this.userProvider});

  Future<http.Response> makeAuthenticatedRequest(String path, {String method = 'GET', Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    final String? accessToken = userProvider.currentToken;
    if (accessToken == null) {
      throw Exception('Access token is not available.');
    }
    
    final modifiedHeaders = {
      ...headers ?? {},
      'Authorization': 'Bearer $accessToken',
    };

    Uri url = Uri.parse('$serverAddress$path');
    http.Response response = await _makeRequest(url, method, modifiedHeaders, body, encoding);

    if (response.statusCode == 401) {
      // Token might have expired; try refreshing
      final success = await userProvider.refreshToken();
      if (!success) {
        throw Exception('Token refresh failed');
      }

      // Retry the request with the new token
      final newAccessToken = userProvider.currentToken;
      final newHeaders = {
        ...headers ?? {},
        'Authorization': 'Bearer $newAccessToken',
      };
      response = await _makeRequest(url, method, newHeaders, body, encoding);
    }

    return response;
  }

  Future<http.Response> _makeRequest(Uri url, String method, Map<String, String> headers, dynamic body, Encoding? encoding) async {
  switch (method.toUpperCase()) {
    case 'GET':
      return await http.get(url, headers: headers);
    case 'POST':
      return await http.post(url, headers: headers, body: jsonEncode(body), encoding: encoding);
    case 'PUT':
      return await http.put(url, headers: headers, body: jsonEncode(body), encoding: encoding);
    case 'DELETE':
      return await http.delete(url, headers: headers);
    case 'PATCH':
      return await http.patch(url, headers: headers, body: jsonEncode(body), encoding: encoding);
    default:
      throw Exception('HTTP method $method is not supported');
  }
}
}
