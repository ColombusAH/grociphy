import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_first_app/providers/api_client.dart';

class GroupsProvider with ChangeNotifier {
  final _groups = <dynamic>[];
  ApiClient _apiClient;

  GroupsProvider(this._apiClient);

  List<dynamic> get groups => _groups;

  Future<void> addGroup(dynamic group) async {
   final createdGroup = await _apiClient.makeAuthenticatedRequest('/groups', method: 'POST', body: group);
    _groups.add(createdGroup);
    notifyListeners();
  }

  Future<void> fetchGroups() async {
    final response = await _apiClient.makeAuthenticatedRequest('/groups', method: 'GET');
    if (response.statusCode == 200) {
      _groups.clear();
      _groups.addAll(json.decode(response.body));
      notifyListeners();
    } else {
      // Handle errors
      print('error fetching groups');
    }
  }
}