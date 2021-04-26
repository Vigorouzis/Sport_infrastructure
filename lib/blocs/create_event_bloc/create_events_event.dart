import 'package:equatable/equatable.dart';

abstract class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override
  List<Object> get props => [];
}

class CreateEventsEvent extends CreateEventEvent {
  final String name;
  final String description;
  final String date;
  final String time;
  final String limitNumber;
  final bool isPrivate;
  final String password;

  const CreateEventsEvent(
      {this.name,
      this.description,
      this.date,
      this.time,
      this.limitNumber,
      this.isPrivate,
      this.password});

  @override
  List<Object> get props =>
      [name, description, date, time, limitNumber, isPrivate, password];
}
