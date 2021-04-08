import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sport_infrastructure/models/organization.dart';
import 'package:sport_infrastructure/models/place.dart';

class PlaceApiProvider {
  static const String placesUrl = 'https://sport-kld.herokuapp.com/';

  Future<List<Place>> getPlaceByName(String value) async {
    Response response = await Dio()
        .get('${placesUrl}places_by_fields?search=$value&fields=name');

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);
      List<dynamic> placeJson = map["places"];
      var result = placeJson.map((json) => Place.fromJson(json)).toList();
      return result;
    } else {
      throw Exception('Error fetching places');
    }
  }

  Future<List<Organization>> getOrganizationByName(String value) async {
    Response response = await Dio()
        .get('${placesUrl}organizations_by_fields?search=$value&fields=name');

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);
      List<dynamic> organizationJson = map["organizations"];
      var result =
          organizationJson.map((json) => Organization.fromJson(json)).toList();
      return result;
    } else {
      throw Exception('Error fetching places');
    }
  }
}
