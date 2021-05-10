import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_infrastructure/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:sport_infrastructure/blocs/authorization_bloc/authorization_event.dart';
import 'package:sport_infrastructure/blocs/authorization_bloc/authorization_state.dart';
import 'package:sport_infrastructure/resources/sing_in_up_repository.dart';
import 'package:sport_infrastructure/ui/event_screens/create_event_screen.dart';
import 'package:sport_infrastructure/ui/sing_in_up_screens/sing_up_screen.dart';
import 'package:sport_infrastructure/utils/utils.dart';
import 'package:sport_infrastructure/widgets/widgets.dart';

class SingInScreen extends StatefulWidget {
  @override
  _SingInScreenState createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  TextEditingController _login;
  TextEditingController _password;
  AuthorizationBloc _authorizationBloc;
  SingInUpRepository _singInUpRepository;

  @override
  void initState() {
    super.initState();
    _login = TextEditingController();
    _password = TextEditingController();
    _singInUpRepository = new SingInUpRepository();
    _authorizationBloc =
        AuthorizationBloc(singInUpRepository: _singInUpRepository);
  }

  @override
  void dispose() {
    _login.dispose();
    _password.dispose();
    _authorizationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) =>
            AuthorizationBloc(singInUpRepository: _singInUpRepository),
        child: Builder(
          builder: (context) =>
              BlocConsumer<AuthorizationBloc, AuthorizationState>(
            bloc: _authorizationBloc,
            listener: (context, state) {
              if (state is AuthorizationSuccess) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateEventScreen(),
                  ),
                );
              }
              if (state is AuthorizationFailure) {
                if (state.error ==
                    'cant select user: sql: no rows in result set') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Пользователь не найден'),
                    ),
                  );
                }
                if (state.error == 'user already login') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Пользователь уже залогинен'),
                    ),
                  );
                }
              }
            },
            builder: (context, state) => Scaffold(
              appBar: AppBar(
                title: Text('Вход'),
                centerTitle: true,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 50.h, left: 30.w, right: 30.w),
                        child: Text(
                          "Для авторизации введите E-mail и пароль",
                          style: AppTypography.font18SF,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 31.h, left: 24.w, right: 23.w),
                        child: Opacity(
                          opacity: 0,
                          child: Text(
                            'Неверный E-mail или пароль',
                            style: AppTypography.font12SF
                                .copyWith(color: AppColors.redEB5757),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 54.h, left: 23.w, right: 24.w),
                        child: DefaultTextField(
                          controller: _login,
                          hintText: 'Логин',
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 14.h, left: 23.w, right: 24.w),
                        child: DefaultTextField(
                          controller: _password,
                          hintText: 'Пароль',
                          suffixIcon: null,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 30.h, left: 23.w, right: 24.w),
                        child: DefaultButton(
                          onTap: () {
                            if (_login.text.isNotEmpty &&
                                _password.text.isNotEmpty) {
                              _authorizationBloc.add(
                                AuthorizationWithLogin(
                                    login: _login.text,
                                    password: _password.text),
                              );
                            }
                          },
                          textColor: AppColors.greyD9D9D9,
                          color: AppColors.primary,
                          label: 'Продолжить',
                          height: 40.h,
                          width: 328.w,
                          haveShadow: true,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 36.h),
                            child: GestureDetector(
                              onTap: () => null,
                              child: Text(
                                'Забыли пароль?',
                                style: AppTypography.font12SF.copyWith(
                                    color: AppColors.grey808088,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 36.h),
                            child: Text(
                              'или',
                              style: AppTypography.font12SF.copyWith(
                                  color: AppColors.grey808088,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 36.h),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingUpScreen(),
                                ),
                              ),
                              child: Text(
                                'Зарегистрироваться',
                                style: AppTypography.font12SF.copyWith(
                                    color: AppColors.grey808088,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
