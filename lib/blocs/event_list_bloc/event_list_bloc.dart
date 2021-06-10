import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/event_list_bloc/events_list_event.dart';
import 'package:sport_infrastructure/blocs/event_list_bloc/events_list_state.dart';
import 'package:sport_infrastructure/models/event.dart';
import 'package:sport_infrastructure/models/place.dart';
import 'package:sport_infrastructure/models/user.dart';
import 'package:sport_infrastructure/resources/event_repository.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';

class EventListBloc extends Bloc<EventsListEvent, EventsListState> {
  EventListBloc() : super(InitialEventsListState());

  EventRepository _repository = EventRepository();
  PlaceRepository _placeRepository = PlaceRepository();

  List<Event> _result = [];
  List<Place> _placeList = [];

  @override
  Stream<EventsListState> mapEventToState(EventsListEvent event) async* {
    if (event is EventsListFetched) {
      yield EventsListLoading();
      try {
        _result = await _repository.getEvents();
        for (var i in _result) {
          var users = await _repository.getUser(i.creatorUID);
          i.creatorUID = users['login'];
          var _place = await _placeRepository.getPlaceByUid(value: i.placeUID);
          var result = Place.fromJson(_place);
          _placeList.add(result);
        }

        yield EventsListLoaded(events: _result, places: _placeList);
      } catch (_) {
        yield EventsListFailure();
      }
    }
  }
}
