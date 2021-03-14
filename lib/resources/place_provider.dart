import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sport_infrastructure/models/place.dart';

class PlaceProvider{
  static const String BASE_URL = '';

  Future<List<Place>> getPlace() async{

      Response response = await Dio().get(BASE_URL);

      if(response.statusCode == 200){
        final List<dynamic> placeJson = json.decode(response.data);
        return placeJson.map((json) => Place.fromJson(json)).toList();
      }else{
        throw Exception('Error fetching places');
      }

  }

}