import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:sport_infrastructure/blocs/create_event_bloc/create_event_bloc.dart';
import 'package:sport_infrastructure/blocs/create_event_bloc/create_event_state.dart';
import 'package:sport_infrastructure/blocs/create_event_bloc/create_events_event.dart';
import 'package:sport_infrastructure/resources/event_repository.dart';
import 'package:sport_infrastructure/ui/event_screens/search_place_for_event_screen.dart';
import 'package:sport_infrastructure/utils/utils.dart';
import 'package:sport_infrastructure/widgets/buttons.dart';

import '../../models/place.dart';
import '../../utils/fonts.dart';

class CreateEventScreen extends StatefulWidget {
  CreateEventScreen({Key key}) : super(key: key);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  MaskedTextController _timeController;
  MaskedTextController _dateController;
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _limitController;
  TextEditingController _passwordController;

  bool _isPrivate = false;
  Place _selectPlace;
  EventRepository _eventRepository = EventRepository();
  CreateEventBloc _bloc;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _limitController = TextEditingController();
    _passwordController = TextEditingController();
    _timeController = MaskedTextController(mask: '00:00');
    _dateController = MaskedTextController(mask: '00.00.0000');
    _bloc = CreateEventBloc(_eventRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание события'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => CreateEventBloc(_eventRepository),
        child: Builder(
          builder: (context) => BlocBuilder<CreateEventBloc, CreateEventState>(
            bloc: _bloc,
            builder: (context, state) => Padding(
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
                            controller: _titleController,
                            decoration: InputDecoration(
                              labelText: 'Введите название события',
                            ),
                          ),
                          TextField(
                            controller: _descriptionController,
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
                            controller: _limitController,
                            decoration: InputDecoration(
                              labelText:
                                  'Введите допустимое количество участников',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Row(
                              children: [
                                if (_selectPlace == null)
                                  Container(
                                    height: 40.h,
                                    width: 200.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border:
                                            Border.all(color: AppColors.black)),
                                    child: Text(''),
                                  ),
                                if (_selectPlace != null)
                                  Container(
                                    height: 40.h,
                                    width: 200.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      _selectPlace.name,
                                      style: AppTypography.font24SF,
                                    )),
                                  ),
                                DefaultButton(
                                  onTap: () async {
                                    _selectPlace = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SearchPlaceForEventScreen(),
                                      ),
                                    );
                                    print(_selectPlace);
                                    setState(() {});
                                  },
                                  haveShadow: true,
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  height: 40.h,
                                  width: 128.w,
                                  label: 'Выбрать место',
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _isPrivate,
                                onChanged: (value) {
                                  setState(() {
                                    _isPrivate = !_isPrivate;
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
                            visible: _isPrivate ? true : false,
                            child: TextField(
                              controller: _passwordController,
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
                    onTap: () async {
                      if (_titleController.text.isNotEmpty &&
                          _descriptionController.text.isNotEmpty &&
                          _timeController.text.isNotEmpty &&
                          _dateController.text.isNotEmpty &&
                          _selectPlace.uid.isNotEmpty &&
                          _limitController.text.isNotEmpty) {
                        _bloc.add(
                          CreateEventsEvent(
                            name: _titleController.text,
                            description: _descriptionController.text,
                            time: _timeController.text,
                            date: _dateController.text,
                            placeUid: _selectPlace.uid,
                            limitNumber: int.parse(_limitController.text),
                            isPrivate: _isPrivate,
                            password: _passwordController.text,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Событие успешно создано'),
                          ),
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil('/event_list', ModalRoute.withName('/'));


                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Заполните все поля')),
                        );
                      }
                    },
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
          ),
        ),
      ),
    );
  }
}
