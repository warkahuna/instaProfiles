import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:http/http.dart' as http;
import 'package:yamuntutest/backEndUrl.dart';

class Api {
  Future<List<dynamic>> fetchProfileData(username) async {
    //print(prefs.getString("user"));
    List<dynamic> data = [];
    final response = await http.get(new Uri.http(
        BackendUrl.url, "/getProfile", {"username": username, "wrap": "0"}));
    print(response.body);
    if (response.statusCode == 200) {
      data.add(jsonDecode(response.body));

      return data;
    } else if (response.statusCode == 404) {
      data.add(jsonDecode(response.body));

      return data;
    } else {
      throw Exception('Failed to load get');
    }
  }
}
