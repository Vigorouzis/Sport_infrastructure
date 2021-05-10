import 'package:sport_infrastructure/resources/sing_in_up_api_provider.dart';

class SingInUpRepository {
  SingInUpApiProvider _singInUpProvider = SingInUpApiProvider();

  Future<String> registrationNewUser(
          {String name, String login, String email, int age, String password}) =>
      _singInUpProvider.registrationNewUser(name, login, email, age, password);

  Future<String> authorization({String login, String password}) =>
      _singInUpProvider.authorization(login, password);

  Future<String> logout() =>
      _singInUpProvider.logout();
}
