import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/Authorization_bloc/Authorization_state.dart';
import 'package:sport_infrastructure/blocs/authorization_bloc/authorization_event.dart';
import 'package:sport_infrastructure/resources/sing_in_up_repository.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final SingInUpRepository singInUpRepository;

  AuthorizationBloc({this.singInUpRepository})
      : super(InitialAuthorizationState());

  @override
  Stream<AuthorizationState> mapEventToState(AuthorizationEvent event) async* {
    if (event is AuthorizationWithLogin) {
      try {
        singInUpRepository.authorization(
          login: event.login,
          password: event.password,
        );
        yield AuthorizationSuccess();
      } catch (_) {
        yield AuthorizationFailure();
      }
    }
  }
}
