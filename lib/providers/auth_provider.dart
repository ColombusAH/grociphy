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

  UserProvider(this._storageService) {
    _initUser();
  }

  Future<void> _initUser() async {
    final List<String?> userData = await Future.wait([
      _storageService.readSecureData('token'),
      _storageService.readSecureData('userId'),
      _storageService.readSecureData('email'),
    ]).catchError((error) {
      return [null, null, null];
    });

    final String? token = userData[0];
    final String? id = userData[1];
    final String? email = userData[2];
    print('Token: $token, id: $id, email: $email');
    _user = await getCurrentUser();
    if (_user == null && token != null && id != null && email != null) {
      _user = User(
        token: token,
        id: id,
        email: email,
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
      );
      _storageService.writeSecureData('token', _user!.token);
      _storageService.writeSecureData('userId', _user!.id);
      _storageService.writeSecureData('email', _user!.email);
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
      );
      return user;
    } else {
      return null;
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
