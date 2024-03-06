import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider with ChangeNotifier {
  final serverAddress = 'http://10.0.2.2:3000/api';
  // final serverAddress = 'http://127.0.0.1:3000/api';
  List<dynamic> _categories = [];
  String _token;
  Timer? _refreshTimer;

  CategoriesProvider(this._token);

  List<dynamic> get categories => _categories;

  Future<void> fetchCategories() async {
    print('going to fetch categories');
    final url = Uri.parse('$serverAddress/categories');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    if (response.statusCode == 200) {
      _categories = json.decode(response.body);
      print(categories[0]);
      notifyListeners();
    } else {
      print('error fetching categories');
      // Handle errors
    }
  }

  void startAutoRefresh() {
    print('startAutoRefresh');
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      fetchCategories();
    });
  }

  void stopAutoRefresh() {
    _refreshTimer?.cancel();
    if (_refreshTimer != null) {
      print('Stopping auto refresh');
      _refreshTimer!.cancel();
      _refreshTimer = null; // Clear the timer instance
    }
  }
}
