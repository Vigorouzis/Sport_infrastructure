import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sport_infrastructure/resources/shared_prefs.dart';
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
    SharedPrefs _prefs = SharedPrefs();

    if (response.statusCode == 200) {
      print(response.data);
      await _prefs.save('user_uid', response.data);
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
      if (response.data != 'cant select user: sql: no rows in result set' ||
          response.data != 'user already login') {
        SharedPrefs _prefs = SharedPrefs();
        _prefs.save('access_token', response.data['access_token']);
        _prefs.save('refresh_token', response.data['refresh_token']);
      }
    } else {
      throw Exception('Error fetching places');
    }
  }

  Future<void> logout() async {
    SharedPrefs _prefs = SharedPrefs();

    var accessToken = await _prefs.read('access_token');

    Response response = await Dio().post(
      ApiConst.logoutURL,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        contentType: 'application/json',
      ),
    );
    SharedPrefs prefs = SharedPrefs();
    if (response.statusCode == 200) {
      print(response.data);
      prefs.clear();
    }
  }
}
