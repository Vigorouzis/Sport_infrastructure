import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_infrastructure/resources/shared_prefs.dart';
import 'package:sport_infrastructure/utils/constants/api_constants.dart';

class EventApiProvider {
  Future<void> createNewEvent(
      String name,
      String description,
      String date,
      String time,
      int limitNumber,
      bool isPrivate,
      String password,
      String placeUid,
      bool isOver) async {
    var params = {
      'name': name,
      'description': description,
      'dates': date,
      'time': time,
      'visitorsLimit': limitNumber,
      'isPrivate': isPrivate,
      'password': password,
      'placeUid': placeUid,
      'isOver': isOver,
    };

    SharedPrefs _prefs = SharedPrefs();

    var token = await _prefs.read('access_token');

    Response response = await Dio().post(
      ApiConst.createEventUrl,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'Authorization': 'Bearer $token',
      }),
      data: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      print(response.data);
    } else {
      throw Exception('Error fetching places');
    }
  }

  Future<void> getEvents() async {}
}
