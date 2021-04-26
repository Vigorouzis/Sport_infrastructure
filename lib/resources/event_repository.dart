import 'package:sport_infrastructure/resources/event_api_provider.dart';

class EventRepository {
  EventApiProvider _eventProvider = EventApiProvider();

  Future<void> createNewEvent(
          {String name,
          String description,
          String date,
          String time,
          String limitNumber,
          bool isPrivate,
          String password,
          String placeUid,
          bool isOver}) =>
      _eventProvider.createNewEvent(name, description, date, time, limitNumber,
          isPrivate, password, placeUid, isOver);
}
