import 'package:equatable/equatable.dart';
import 'package:sport_infrastructure/models/organization.dart';
import 'package:sport_infrastructure/models/place.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class InitialRegistrationState extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailure extends RegistrationState {}
