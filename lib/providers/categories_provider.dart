import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/providers/api_client.dart';

class CategoriesProvider with ChangeNotifier {
  List<dynamic> _categories = [];
  ApiClient _apiClient;

  Timer? _refreshTimer;

  CategoriesProvider(this._apiClient);

  List<dynamic> get categories => _categories;

  Future<void> fetchCategories() async {
    print('going to fetch categories');
    final response = await _apiClient.makeAuthenticatedRequest('/categories', method: 'GET');

    if (response.statusCode == 200) {
      _categories = json.decode(response.body);
      print(categories.map((e) => e['name']).toList());
      notifyListeners();
    } else {
      print('error fetching categories');
      // Handle errors
    }
  }

  void startAutoRefresh() {
    print('startAutoRefresh');
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(Duration(seconds: 5), (timer) {
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
