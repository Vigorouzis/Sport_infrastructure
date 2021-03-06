import 'package:sport_infrastructure/models/event.dart';
import 'package:sport_infrastructure/models/user.dart';
import 'package:sport_infrastructure/resources/event_api_provider.dart';

class EventRepository {
  EventApiProvider _eventProvider = EventApiProvider();

  Future<void> createNewEvent(
          {String name,
          String description,
          String date,
          String time,
          int limitNumber,
          bool isPrivate,
          String password,
          String placeUid,
          bool isOver}) =>
      _eventProvider.createNewEvent(name, description, date, time, limitNumber,
          isPrivate, password, placeUid, isOver);

  Future<List<Event>> getEvents() => _eventProvider.getEvents();

  Future<Map<String, dynamic>> getUser(String uid) => _eventProvider.getUser(uid: uid);
}
