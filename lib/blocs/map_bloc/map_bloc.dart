import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/map_bloc/map_event.dart';
import 'package:sport_infrastructure/blocs/map_bloc/map_state.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_event.dart';

import 'package:sport_infrastructure/models/place.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final PlaceRepository placeRepository;

  MapBloc(this.placeRepository) : super(InitialMapState());

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is GetMapLocations) {
      yield MapLoading();
      try {
        //TODO: Get data from server
        var places = [
          Place(
              id: '1',
              name: 'Nikita',
              description: 'Kanunov',
              isFreeVisit: true,
              abonements: null,
              basedOrganizations: null,
              holderOrganization: null,
              location: null,
              categoriesIDs: null,
              tagsUIDs: null)
        ];
        Future.delayed(const Duration(milliseconds: 500));
        yield MapLoaded(markers: places);
      } catch (_) {
        yield MapFailure();
      }
    }
  }
}
