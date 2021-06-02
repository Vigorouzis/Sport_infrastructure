import 'package:equatable/equatable.dart';

abstract class EventsListEvent extends Equatable {
  const EventsListEvent();

  @override
  List<Object> get props => [];
}

class EventsListFetched extends EventsListEvent {
  const EventsListFetched();
}
