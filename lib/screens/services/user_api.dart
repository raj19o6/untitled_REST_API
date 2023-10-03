import 'dart:convert';

import 'package:untitled/screens/model/user.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<User>> fetchUsers() async {
    // print("Fetch User called");
    const url = "https://randomuser.me/api/?results=200";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    final results = json['results'] as List<dynamic>;

    final users = results.map((e) {
      return User.fromMap(e);
    }).toList();
    // users = transformed;
    return users;
  }
}
