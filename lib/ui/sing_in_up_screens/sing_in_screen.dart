import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_infrastructure/utils/utils.dart';
import 'package:sport_infrastructure/widgets/widgets.dart';

class SingInScreen extends StatefulWidget {
  @override
  _SingInScreenState createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  TextEditingController _email;
  TextEditingController _password;

  @override
  void initState() {
    super.initState();
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
        title: Text('Вход'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50.h, left: 30.w, right: 30.w),
                child: Text(
                  "Для авторизации введите E-mail и пароль",
                  style: AppTypography.font18SF,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 31.h, left: 24.w, right: 23.w),
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
                padding: EdgeInsets.only(top: 54.h, left: 23.w, right: 24.w),
                child: DefaultTextField(
                  controller: _email,
                  hintText: 'E-mail',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 14.h, left: 23.w, right: 24.w),
                child: DefaultTextField(
                  controller: _password,
                  hintText: 'Пароль',
                  suffixIcon: null,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h, left: 23.w, right: 24.w),
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
                    child: GestureDetector(
                      onTap: () => null,
                      child: Text(
                        'или?',
                        style: AppTypography.font12SF.copyWith(
                            color: AppColors.grey808088,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 36.h),
                    child: GestureDetector(
                      onTap: () => null,
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
      ));
}
