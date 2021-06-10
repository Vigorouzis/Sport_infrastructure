import 'package:equatable/equatable.dart';
import 'package:sport_infrastructure/models/event.dart';
import 'package:sport_infrastructure/models/place.dart';

abstract class EventsListState extends Equatable {
  const EventsListState();

  @override
  List<Object> get props => [];
}

class InitialEventsListState extends EventsListState {}

class EventsListLoading extends EventsListState {}

class EventsListLoaded extends EventsListState {
  final List<Event> events;
  final List<Place> places;

  const EventsListLoaded({this.places, this.events});

  @override
  List<Object> get props => [events];
}

class EventsListFailure extends EventsListState {}
