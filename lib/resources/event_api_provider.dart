import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_infrastructure/models/event.dart';
import 'package:sport_infrastructure/models/user.dart';
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

  Future<List<Event>> getEvents() async {
    Response response = await Dio().get(
      ApiConst.allEventUrl,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);
      List<dynamic> organizationJson = map["events"];
      var result =
          organizationJson.map((json) => Event.fromJson(json)).toList();
      return result;
    } else {
      throw Exception('Error fetching events');
    }
  }

  Future<Map<String, dynamic>> getUser({String uid}) async {
    Response response = await Dio().get(
      '${ApiConst.getUserUrl}?uid=$uid',
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.data);


      // var result = data.map((json) => User.fromJson(json));
      return data;
    } else {
      throw Exception('Error fetching user');
    }
  }
}
