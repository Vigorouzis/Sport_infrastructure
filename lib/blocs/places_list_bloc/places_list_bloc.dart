import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_event.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_state.dart';
import 'package:sport_infrastructure/models/place.dart';

class PlacesListBloc extends Bloc<PlacesListEvent, PlacesListState> {
  //TODO: Created http controller class
  PlacesListBloc() : super(InitialPlacesListState());

  @override
  Stream<PlacesListState> mapEventToState(PlacesListEvent event) async* {
    if (event is PlacesListFetched) {
      yield PlacesListLoading();
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
        yield PlacesListLoaded(places: places);
      } catch (_) {
        yield PlacesListFailure();
      }
    }
  }
}
