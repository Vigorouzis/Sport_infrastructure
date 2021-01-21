import 'package:sport_infrastructure/models/place.dart';
import 'package:sport_infrastructure/resources/place_provider.dart';

class PlaceRepository{
  PlaceProvider _placeProvider = PlaceProvider();
  Future<List<Place>> getAllPlace() => _placeProvider.getPlace();
}