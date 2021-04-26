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
      String limitNumber,
      bool isPrivate,
      String password,
      String placeUid,
      bool isOver) async {
    var params = {
      'name': name,
      'description': description,
      'date': date,
      'time': time,
      'visitorsLimit': limitNumber,
      'isPrivate': isPrivate,
      'password': password,
      'placeUid': placeUid,
      'isOver': isOver,
    };
    Response response = await Dio().post(
      ApiConst.placeURL,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(params),
    );
    SharedPrefs _prefs = SharedPrefs();

    if (response.statusCode == 200) {
      await _prefs.save('place_uid', response.data);
    } else {
      throw Exception('Error fetching places');
    }
  }
}
