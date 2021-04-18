import 'package:equatable/equatable.dart';
import 'package:sport_infrastructure/models/organization.dart';
import 'package:sport_infrastructure/models/place.dart';

abstract class AuthorizationState extends Equatable {
  const AuthorizationState();

  @override
  List<Object> get props => [];
}

class InitialAuthorizationState extends AuthorizationState {}

class AuthorizationSuccess extends AuthorizationState {}

class AuthorizationFailure extends AuthorizationState {}
