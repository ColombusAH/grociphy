import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/user.dart';
import 'package:flutter_first_app/services/storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  final StorageService _storageService;
  final serverAddress = 'http://10.0.2.2:3000/api';
  // final serverAddress = 'http://127.0.0.1:3000/api';
  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  String? get currentToken => _user?.token;

  UserProvider(this._storageService) {
    _initUser();
  }

  Future<void> _initUser() async {
    final List<String?> userData = await Future.wait([
      _storageService.readSecureData('token'),
      _storageService.readSecureData('userId'),
      _storageService.readSecureData('email'),
      _storageService.readSecureData('refreshToken'),
    ]).catchError((error) {
      return [null, null, null,null];
    });

    final String? token = userData[0];
    final String? id = userData[1];
    final String? email = userData[2];
    final String? refreshToken = userData[3];

    print('refreshToken: $refreshToken, id: $id, email: $email');
    _user = await getCurrentUser();
    if (_user == null && token != null && id != null && email != null && refreshToken != null) {
      _user = User(
        token: token,
        id: id,
        email: email,
        refreshToken: refreshToken,
      );

    }
    // Notify listeners if needed, for example, to update UI based on the token availability
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$serverAddress/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _user = User(
        id: responseData['user']['id'],
        email: responseData['user']['email'],
        token: responseData['token'],
        refreshToken: responseData['refreshToken'],
      );
      _storageService.writeSecureData('token', _user!.token);
      _storageService.writeSecureData('userId', _user!.id);
      _storageService.writeSecureData('email', _user!.email);
      _storageService.writeSecureData('refreshToken', _user!.refreshToken);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$serverAddress/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Optionally, automatically log the user in or handle as needed
      return true;
    } else {
      return false;
    }
  }

  Future<User?> getCurrentUser() async {
    final token =
        await _storageService.readSecureData('token').catchError((error) {
      throw Exception('[getCurrentUser]Failed to load token');
    });
    final refreshToken = await _storageService.readSecureData('refreshToken').catchError((error) {
      return null;
    });
    final response = await http.get(
      Uri.parse('$serverAddress/currentUser'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).catchError((error) {
      throw Exception('Failed to load user');
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final user = User(
        id: responseData['user']['id'],
        email: responseData['user']['email'],
        token: token!,
        refreshToken: refreshToken!,
      );
      return user;
    } else {
      return null;
    }
  }

  Future<bool> refreshToken() async {
  final String? refreshToken = await _storageService.readSecureData('refreshToken');
  if (refreshToken == null) {
    print('No refresh token available.');
    return false;
  }

  try {
    final response = await http.post(
      Uri.parse('$serverAddress/refreshToken'), // Adjust the endpoint as necessary
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final String newAccessToken = data['token']; // Adjust key as per your API response

      // Update the user with the new access token
      if (_user != null) {
        _user = User(
          id: _user!.id,
          email: _user!.email,
          token: newAccessToken,
          refreshToken: _user!.refreshToken, // Assuming the refresh token stays the same
        );
      } else {
        // Handle the case where _user is null (not expected if refresh is needed)
        print('User object is null during token refresh.');
        return false;
      }

      // Save the new access token in secure storage
      await _storageService.writeSecureData('token', newAccessToken);
      notifyListeners();
      return true;
    } else {
      // Handle response codes other than 200
      print('Failed to refresh token. Response code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    // Handle any errors that might occur during the refresh process
    print('An error occurred while refreshing the token: $e');
    return false;
  }
}

  void logout() async {
    _user = null;
    await _storageService.deleteSecureData('authToken');
    await _storageService.deleteSecureData('userId');
    await _storageService.deleteSecureData('email');
    notifyListeners();
  }
}
