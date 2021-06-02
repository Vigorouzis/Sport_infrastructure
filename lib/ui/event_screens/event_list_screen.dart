import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/event_list_bloc/event_list_bloc.dart';
import 'package:sport_infrastructure/blocs/event_list_bloc/events_list_event.dart';
import 'package:sport_infrastructure/blocs/event_list_bloc/events_list_state.dart';
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

  // List<Event> _events = [
  //   Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
  //   Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
  //   Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
  //   Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
  //   Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
  //   Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
  //   Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
  //   Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
  //   Event(name: 'Баскетбол', time: '16:30', creatorUID: "fdc2f8155f0"),
  // ];

  var isAccessKeysCreated = false;
  SharedPrefs _prefs = SharedPrefs();
  SingInUpApiProvider _singInUpProvider = SingInUpApiProvider();
  EventListBloc _bloc;

  Future<void> isAccessCreated() async {
    isAccessKeysCreated = await _prefs.contains('access_token');
  }

  Future<void> _pullRefresh() async {
    _bloc.add(EventsListFetched());
  }

  @override
  void initState() {
    super.initState();
    isAccessCreated();
    _bloc = EventListBloc();
    _bloc.add(EventsListFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список событий'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => EventListBloc(),
        child: Builder(
          builder: (context) => BlocBuilder<EventListBloc, EventsListState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is EventsListLoading) {
                  return RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: Center(child: CircularProgressIndicator()));
                }
                if (state is EventsListLoaded) {
                  return RefreshIndicator(
                    onRefresh: _pullRefresh,
                    child: ListView.separated(
                        itemBuilder: (context, index) => Container(
                              height: 50.h,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 23.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.events[index].name,
                                      style: AppTypography.font18SF
                                          .copyWith(color: AppColors.black),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Время:  ${state.events[index].time}',
                                          style: AppTypography.font16SF
                                              .copyWith(color: AppColors.black),
                                        ),
                                        Text(
                                          'Создатель: ${state.events[index].creatorUID}',
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
                        itemCount: state.events.length),
                  );
                }
                return RefreshIndicator(
                    onRefresh: _pullRefresh, child: Container());
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await isAccessCreated();
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
