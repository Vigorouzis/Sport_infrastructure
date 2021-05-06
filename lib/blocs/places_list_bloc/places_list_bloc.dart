import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_event.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_state.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';

class PlacesListBloc extends Bloc<PlacesListEvent, PlacesListState> {
  final PlaceRepository _placeRepository;

  PlacesListBloc(this._placeRepository) : super(InitialPlacesListState());

  @override
  Stream<PlacesListState> mapEventToState(PlacesListEvent event) async* {
    if (event is PlacesListFetched) {
      yield PlacesListLoading();
      try {
        var places =
            await _placeRepository.getPlaceByName(value: event.placeSearch);
        yield PlacesListLoaded(places: places);
      } catch (_) {
        yield PlacesListFailure();
      }
    }

    if (event is OrganizationListFetched) {
      yield PlacesListLoading();
      try {
        var places = await _placeRepository.getPlaceByName(
            value: event.organizationSearch);
        var organization = await _placeRepository.getOrganizationByName(
            value: event.organizationSearch);

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        var currentPosition = LatLng(position.latitude, position.longitude);
        yield PlacesListLoaded(
            organization: organization,
            places: places,
            currentPosition: currentPosition);
      } catch (_) {
        yield PlacesListFailure();
      }
    }
  }
}
