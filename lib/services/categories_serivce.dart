import 'dart:convert';
import 'package:flutter_first_app/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  final serverAddress = 'http://10.0.2.2:3000/api';
  // final serverAddress = 'http://127.0.0.1:3000/api';
  final UserProvider authService;

  CategoryService(this.authService);
  
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final url = Uri.parse('$serverAddress/categories');
    final response = await http.get(url);
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
