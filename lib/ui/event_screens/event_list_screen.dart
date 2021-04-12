import 'package:flutter/material.dart';
import 'package:sport_infrastructure/models/event.dart';
import 'package:sport_infrastructure/utils/utils.dart';
import 'package:sport_infrastructure/widgets/widgets.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Event> _events = [
    Event(
        name: 'Баскетбол',
        time: '16:30',
        creatorUID: "fdc2f8155f0111eb882d0c9d92446328"),
    Event(
        name: 'Баскетбол',
        time: '16:30',
        creatorUID: "fdc2f8155f0111eb882d0c9d92446328"),
    Event(
        name: 'Баскетбол',
        time: '16:30',
        creatorUID: "fdc2f8155f0111eb882d0c9d92446328"),
    Event(
        name: 'Баскетбол',
        time: '16:30',
        creatorUID: "fdc2f8155f0111eb882d0c9d92446328"),
    Event(
        name: 'Баскетбол',
        time: '16:30',
        creatorUID: "fdc2f8155f0111eb882d0c9d92446328"),
    Event(
        name: 'Баскетбол',
        time: '16:30',
        creatorUID: "fdc2f8155f0111eb882d0c9d92446328"),
    Event(
        name: 'Баскетбол',
        time: '16:30',
        creatorUID: "fdc2f8155f0111eb882d0c9d92446328"),
    Event(
        name: 'Баскетбол',
        time: '16:30',
        creatorUID: "fdc2f8155f0111eb882d0c9d92446328"),
    Event(
        name: 'Баскетбол',
        time: '16:30',
        creatorUID: "fdc2f8155f0111eb882d0c9d92446328"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список событий'),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => Container(
                child: Padding(
                  padding: EdgeInsets.only( left: 23.w,),
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
                           'Время:  ${ _events[index].time}',
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
    );
  }
}
