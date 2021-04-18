import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_infrastructure/utils/constants/api_constants.dart';

class SingInUpApiProvider {
  Future<void> registrationNewUser(
      String name, String login, String email, int age, String password) async {
    var params = {
      'name': name,
      'login': login,
      'password': password,
      'age': age,
      'email': email,
    };
    Response response = await Dio().post(
      ApiConst.registrationURL,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(params),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response.statusCode == 200) {
      print(response.data);
      await prefs.setString('user_uid', response.data);
    } else {
      throw Exception('Error fetching places');
    }
  }

  Future<void> authorization(String login, String password) async {
    var params = {
      'login': login,
      'password': password,
    };
    Response response = await Dio().post(
      ApiConst.loginURL,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      print(response.data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
    } else {
      throw Exception('Error fetching places');
    }
  }
}
