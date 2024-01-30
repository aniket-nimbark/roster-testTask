import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod/riverpod.dart';
import 'package:roster/user_model.dart';

import 'homeScreen.dart';

class UserListNotifier extends StateNotifier<List<User>> {
  UserListNotifier() : super([]);

  int _currentPage = 1;
  bool _hasMoreData = true;

  Future<void> fetchUsers() async {
    if (_hasMoreData) {
      final apiUrl = 'https://api.konquer.club/api/v2/users'; // Replace with your API endpoint
      final response = await Dio().get(apiUrl);

      if (response.statusCode == 200) {
        var getdata = json.decode(response.toString());
        final List<dynamic> data = getdata["results"];
        final List<User> users = data.map((json) => User.fromJson(json)).toList();

        if (users.isNotEmpty) {
          if (_currentPage == 1) {
            state = users;
          } else {
            state.addAll(users);
          }
          _currentPage++;
        } else {
          // No more data available
          _hasMoreData = false;
        }
      } else {
        // Handle error
        throw Exception('Failed to load users');
      }
    }
  }
}

// Create a Riverpod provider for the user list
final userListProvider = Provider((ref) => UserListNotifier());

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Infinite Scroll Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProviderScope(child: MyHomePage()),
    );
  }
}
