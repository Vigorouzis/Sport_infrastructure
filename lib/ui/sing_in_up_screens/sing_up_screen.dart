import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_infrastructure/utils/utils.dart';
import 'package:sport_infrastructure/widgets/widgets.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController _login;
  TextEditingController _email;
  TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _login = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    // _authEmailBloc = AuthEmailBloc();
    // _email.addListener(() {
    //   _authEmailBloc.setEmail(value: _email.text);
    // });
    // _password.addListener(() {
    //   _authEmailBloc.setPassword(value: _password.text);
    // });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    // _authEmailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50.h, left: 30.w, right: 30.w),
                child: Text(
                  "Для регистрации введите логин, E-mail и пароль",
                  style: AppTypography.font18SF,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Column(
                  children: [
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
                          EdgeInsets.only(top: 34.h, left: 23.w, right: 24.w),
                      child: DefaultTextField(
                        controller: _email,
                        hintText: 'E-mail',
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 34.h, left: 23.w, right: 24.w),
                      child: DefaultTextField(
                        controller: _password,
                        hintText: 'Пароль',
                        suffixIcon: null,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 30.h, left: 23.w, right: 24.w),
                        child: DefaultButton(
                          onTap: () => print('hello'),
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
      ));
}
  