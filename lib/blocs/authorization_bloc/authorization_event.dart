import 'package:equatable/equatable.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object> get props => [];
}

class AuthorizationWithLogin extends AuthorizationEvent {
  final String login;

  final String password;

  const AuthorizationWithLogin({this.login, this.password});

  @override
  List<Object> get props => [login, password];
}
