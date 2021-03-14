import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/blocs/details_screen_bloc/details_screen_event.dart';
import 'package:sport_infrastructure/blocs/details_screen_bloc/details_screen_state.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';

class DetailsScreenBloc extends Bloc<DetailsScreenEvent, DetailsScreenState> {
  final PlaceRepository placeRepository;

  DetailsScreenBloc(this.placeRepository) : super(InitialMapState());

  @override
  Stream<DetailsScreenState> mapEventToState(DetailsScreenEvent event) async* {
    if (event is GetMapLocations) {
      yield DetailsScreenLoading();
      try {
        LatLng currentPosition;
        var position = await GeolocatorPlatform.instance
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

        currentPosition = LatLng(position.latitude, position.longitude);

        yield DetailsScreenLoaded(location: currentPosition);
      } catch (_) {
        yield DetailsScreenFailure();
      }
    }
  }
}
