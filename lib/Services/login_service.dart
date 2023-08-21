import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final String email;

  User(this.name, this.email);
}

class LoginService {
  Future login(String username, String password) async {
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/login");
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {'username': username, 'password': password},
        ),
      );
      var data = jsonDecode(response.body)['data'];
      if (response.statusCode == 200) {
        return data;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
