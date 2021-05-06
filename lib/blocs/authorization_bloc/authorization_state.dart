import 'package:equatable/equatable.dart';

abstract class AuthorizationState extends Equatable {
  const AuthorizationState();

  @override
  List<Object> get props => [];
}

class InitialAuthorizationState extends AuthorizationState {}

class AuthorizationSuccess extends AuthorizationState {}

class AuthorizationFailure extends AuthorizationState {}
