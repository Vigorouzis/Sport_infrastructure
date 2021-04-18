import 'package:flutter/material.dart';
import 'package:sport_infrastructure/widgets/widgets.dart';
import 'package:sport_infrastructure/utils/utils.dart';

class EventDetailScreen extends StatefulWidget {
  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Событие'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text('Событие', style: AppTypography.font20SF,),

              GestureDetector(
                child: Container(child: Icon(Icons.add)),
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.only(top:13.h),
            child: Container(
              height: 100.h,
              child: Text('Описание: ...'),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top:13.h),
            child: Container(
              height: 100.h,
              child: Text('Организатор: ...'),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top:13.h),
            child: Container(
              height: 100.h,
              child: Text('Время: ...'),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top:13.h),
            child: Container(
              height: 100.h,
              child: Text('Место: ...'),
            ),
          ),
          //TODO: Добавить карту на с меткой на экран
        ],
      ),
    );
  }
}
