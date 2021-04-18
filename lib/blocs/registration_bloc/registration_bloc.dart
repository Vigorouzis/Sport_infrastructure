import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/registration_bloc/registration_state.dart';
import 'package:sport_infrastructure/blocs/registration_bloc/regitration_event.dart';
import 'package:sport_infrastructure/resources/sing_in_up_repository.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final SingInUpRepository singInUpRepository;

  RegistrationBloc({this.singInUpRepository})
      :
        super(InitialRegistrationState());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationNewUser) {
      try {
        singInUpRepository.registrationNewUser(
           name: event.name,
            login: event.login,
            password: event.password,
            age: event.age,
            email: event.email);
        yield RegistrationSuccess();
      } catch (_) {
        yield RegistrationFailure();
      }
    }
  }
}
