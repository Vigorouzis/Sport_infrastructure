import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationNewUser extends RegistrationEvent {
  final String name;
  final String login;
  final String email;
  final int age;
  final String password;

  const RegistrationNewUser(
      {this.name, this.login, this.email, this.age, this.password});

  @override
  List<Object> get props => [name, login, email, age, password];
}
