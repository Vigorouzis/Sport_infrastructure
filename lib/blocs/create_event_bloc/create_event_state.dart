import 'package:equatable/equatable.dart';

abstract class CreateEventState extends Equatable {
  const CreateEventState();

  @override
  List<Object> get props => [];
}

class InitialCreateEventState extends CreateEventState {}

class CreateEventLoading extends CreateEventState {}

class CreateEventLoaded extends CreateEventState {}

class CreateEventFailure extends CreateEventState {}
