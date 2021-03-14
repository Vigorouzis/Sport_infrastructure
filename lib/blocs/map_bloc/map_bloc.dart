import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/blocs/map_bloc/map_event.dart';
import 'package:sport_infrastructure/blocs/map_bloc/map_state.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final PlaceRepository placeRepository;

  MapBloc(this.placeRepository) : super(InitialMapState());

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is GetMapLocations) {
      yield MapLoading();
      try {
        LatLng currentPosition;
        var position = await GeolocatorPlatform.instance
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

        currentPosition = LatLng(position.latitude, position.longitude);

        yield MapLoaded(location: currentPosition);
      } catch (_) {
        yield MapFailure();
      }
    }
  }
}
