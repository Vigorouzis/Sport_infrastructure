import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/event_list_bloc/events_list_event.dart';
import 'package:sport_infrastructure/blocs/event_list_bloc/events_list_state.dart';
import 'package:sport_infrastructure/models/event.dart';
import 'package:sport_infrastructure/models/user.dart';
import 'package:sport_infrastructure/resources/event_repository.dart';

class EventListBloc extends Bloc<EventsListEvent, EventsListState> {
  EventListBloc() : super(InitialEventsListState());

  EventRepository _repository = EventRepository();

  List<Event> result;

  @override
  Stream<EventsListState> mapEventToState(EventsListEvent event) async* {
    if (event is EventsListFetched) {
      yield EventsListLoading();
      try {
        result = await _repository.getEvents();
        for (var i in result) {
          var users = await _repository.getUser(i.creatorUID);
         i.creatorUID = users['login'];
        }
        yield EventsListLoaded(events: result);
      } catch (_) {
        yield EventsListFailure();
      }
    }
  }
}
