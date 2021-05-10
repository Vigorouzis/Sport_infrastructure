import 'package:flutter/material.dart';
import 'package:sport_infrastructure/models/event.dart';
import 'package:sport_infrastructure/resources/event_repository.dart';
import 'package:sport_infrastructure/resources/shared_prefs.dart';
import 'package:sport_infrastructure/resources/sing_in_up_api_provider.dart';
import 'package:sport_infrastructure/ui/event_screens/create_event_screen.dart';
import 'package:sport_infrastructure/ui/sing_in_up_screens/sing_in_screen.dart';
import 'package:sport_infrastructure/utils/utils.dart';
import 'package:sport_infrastructure/widgets/widgets.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  EventRepository _repository;
  String result;

  List<Event> _events = [
    Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
    Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
    Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
    Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
    Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
    Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
    Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
    Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
    Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
  ];

  var isAccessKeysCreated = false;
  SharedPrefs _prefs = SharedPrefs();
  SingInUpApiProvider _singInUpProvider = SingInUpApiProvider();

  Future<void> isAccessCreated() async {
    isAccessKeysCreated = await _prefs.contains('access_token');
    print(await _prefs.contains('access_token'));
  }

  @override
  void initState() {
    super.initState();
    isAccessCreated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список событий'),
        centerTitle: true,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                   result = await _singInUpProvider.logout();
                  print(result);
                  if (result == 'OK' ) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Вы успешно вышли из аккаунта'),
                      ),
                    );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Что-то пошло не так'),
                      ),
                    );
                  }
                },
                child: Icon(Icons.more_vert),
              )),
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => Container(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 23.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _events[index].name,
                        style: AppTypography.font18SF
                            .copyWith(color: AppColors.black),
                      ),
                      Column(
                        children: [
                          Text(
                            'Время:  ${_events[index].time}',
                            style: AppTypography.font16SF
                                .copyWith(color: AppColors.black),
                          ),
                          Text(
                            'Создатель: ${_events[index].creatorUID}',
                            style: AppTypography.font16SF
                                .copyWith(color: AppColors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          separatorBuilder: (context, index) => CustomDivider(),
          itemCount: _events.length),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            isAccessCreated();
            if (isAccessKeysCreated == false) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingInScreen(),
                ),
              );
            } else {
              print(_prefs.contains('access_token'));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateEventScreen(),
                ),
              );
            }
          }),
    );
  }
}
