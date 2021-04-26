import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_infrastructure/blocs/registration_bloc/registration_bloc.dart';
import 'package:sport_infrastructure/blocs/registration_bloc/registration_state.dart';
import 'package:sport_infrastructure/blocs/registration_bloc/regitration_event.dart';
import 'package:sport_infrastructure/resources/sing_in_up_repository.dart';
import 'package:sport_infrastructure/ui/sing_in_up_screens/sing_in_screen.dart';
import 'package:sport_infrastructure/utils/utils.dart';
import 'package:sport_infrastructure/widgets/widgets.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController _login;
  TextEditingController _email;
  TextEditingController _name;
  TextEditingController _password;
  TextEditingController _age;
  RegistrationBloc _registrationBloc;
  SingInUpRepository _singInUpRepository;

  @override
  void initState() {
    super.initState();
    _login = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _age = TextEditingController();
    _name = TextEditingController();
    _singInUpRepository = new SingInUpRepository();
    _registrationBloc =
        RegistrationBloc(singInUpRepository: _singInUpRepository);
  }

  @override
  void dispose() {
    _email.dispose();
    _name.dispose();
    _password.dispose();
    _login.dispose();
    _age.dispose();
    _registrationBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) =>
              RegistrationBloc(singInUpRepository: _singInUpRepository),
          child: Builder(
            builder: (context) =>
                BlocConsumer<RegistrationBloc, RegistrationState>(
              bloc: _registrationBloc,
              listener: (context, state) {},
              builder: (context, state) => SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 50.h, left: 30.w, right: 30.w),
                      child: Text(
                        "Для регистрации введите логин,\n E-mail и пароль",
                        style: AppTypography.font18SF,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 54.h, left: 23.w, right: 24.w),
                            child: DefaultTextField(
                              controller: _name,
                              hintText: 'Имя',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 34.h, left: 23.w, right: 24.w),
                            child: DefaultTextField(
                              controller: _login,
                              hintText: 'Логин',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 34.h, left: 23.w, right: 24.w),
                            child: DefaultTextField(
                              controller: _email,
                              hintText: 'E-mail',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 34.h, left: 23.w, right: 24.w),
                            child: DefaultTextField(
                              controller: _age,
                              hintText: 'Возраст',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 34.h, left: 23.w, right: 24.w),
                            child: DefaultTextField(
                              controller: _password,
                              hintText: 'Пароль',
                              suffixIcon: null,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 30.h, left: 23.w, right: 24.w),
                              child: DefaultButton(
                                onTap: () {
                                  _registrationBloc.add(
                                    RegistrationNewUser(
                                        name: _name.text,
                                        login: _login.text,
                                        password: _password.text,
                                        age: int.parse(_age.text),
                                        email: _email.text),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SingInScreen(),
                                    ),
                                  );
                                },
                                textColor: AppColors.greyD9D9D9,
                                color: AppColors.primary,
                                label: 'Продолжить',
                                height: 40.h,
                                width: 328.w,
                                haveShadow: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));
}
