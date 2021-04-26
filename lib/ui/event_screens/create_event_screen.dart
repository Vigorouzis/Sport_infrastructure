import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:sport_infrastructure/utils/utils.dart';
import 'package:sport_infrastructure/widgets/buttons.dart';

class CreateEventScreen extends StatefulWidget {
  CreateEventScreen({Key key}) : super(key: key);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  var _timeController = MaskedTextController(mask: '00:00');
  var _dateController = MaskedTextController(mask: '00/00/0000');
  bool rememberMe = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание события'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Column(
          children: [
            Text('Введите данные в соответствующие поля'),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Введите название события',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Введите описание события',
                      ),
                    ),
                    TextField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelText: 'Введите дату проведения',
                      ),
                    ),
                    TextField(
                      controller: _timeController,
                      decoration: InputDecoration(
                        labelText: 'Введите время: например 12:00',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Введите допустимое количество участников',
                      ),
                    ),
                    //TODO: Список выбора места для события
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = !rememberMe;
                            });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: Text('приватное'),
                        )
                      ],
                    ),
                    Visibility(
                      visible: rememberMe ? true : false,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Введите пароль',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DefaultButton(
              onTap: null,
              haveShadow: true,
              color: Colors.blue,
              textColor: Colors.white,
              height: 40.h,
              width: 328.w,
              label: 'Создать',
            ),
          ],
        ),
      ),
    );
  }
}
