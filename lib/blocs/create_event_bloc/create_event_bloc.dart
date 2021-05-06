import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/create_event_bloc/create_event_state.dart';
import 'package:sport_infrastructure/blocs/create_event_bloc/create_events_event.dart';
import 'package:sport_infrastructure/resources/event_repository.dart';

import '../../resources/place_repository.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final EventRepository _eventRepository;

  CreateEventBloc(this._eventRepository) : super(InitialCreateEventState());

  @override
  Stream<CreateEventState> mapEventToState(CreateEventEvent event) async* {
    if (event is CreateEventsEvent) {
      yield CreateEventLoading();
      try {
        _eventRepository.createNewEvent(
          name: event.name,
          description: event.description,
          date: event.date,
          time: event.time,
          password: event.password,
          isPrivate: event.isPrivate,
          limitNumber: event.limitNumber,
          placeUid: event.placeUid,
          isOver: false,
        );

        yield CreateEventLoaded();
      } catch (_) {
        yield CreateEventFailure();
      }
    }
  }
}
