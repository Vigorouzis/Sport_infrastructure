import 'package:sport_infrastructure/models/organization.dart';
import 'package:sport_infrastructure/models/place.dart';
import 'package:sport_infrastructure/resources/place_api_provider.dart';

class PlaceRepository {
  PlaceApiProvider _placeProvider = PlaceApiProvider();

  Future<List<Place>> getPlaceByName({String value}) =>
      _placeProvider.getPlaceByName(value);

  Future<List<Organization>> getOrganizationByName({String value}) =>
      _placeProvider.getOrganizationByName(value);
}
