import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/blocs/details_screen_bloc/details_screen.dart';
import 'package:sport_infrastructure/models/place.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';
import 'package:sport_infrastructure/widgets/buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  final Place _place;

  DetailScreen({Place place}) : _place = place;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  DetailsScreenBloc _detailsScreenBloc;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _detailsScreenBloc = DetailsScreenBloc();
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    _detailsScreenBloc.close();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget._place.name),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => DetailsScreenBloc(),
          child: Builder(
            builder: (context) =>
                BlocConsumer<DetailsScreenBloc, DetailsScreenState>(
              bloc: _detailsScreenBloc,
              listener: (context, state) {},
              builder: (context, state) {
                print(state);

                return Column(
                  children: [
                    Map(
                      location: LatLng(widget._place.latitude,
                          widget._place.longitude),
                    ),
                    TabButtons(
                      controller: _tabController,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _TabOne(),
                            _TabOne(),
                            _TabOne(),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Map extends StatefulWidget {
  final LatLng location;

  Map({this.location});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.h,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.location,
          zoom: 18,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        // onMapCreated: (GoogleMapController controller) {
        //   widget._mapController = controller;
        // },
      ),
    );
  }
}

class TabButtons extends StatefulWidget {
  final TabController _tabController;

  const TabButtons({TabController controller}) : _tabController = controller;

  @override
  _TabButtonsState createState() => _TabButtonsState();
}

class _TabButtonsState extends State<TabButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: TabBar(
        controller: widget._tabController,
        indicatorColor: Colors.transparent,
        tabs: [
          Tab(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: widget._tabController.index == 0
                  ? Colors.blue
                  : ThemeData().scaffoldBackgroundColor,
              child: Center(
                child: Text(
                  'Информация',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: widget._tabController.index == 1
                  ? Colors.blue
                  : ThemeData().scaffoldBackgroundColor,
              child: Center(
                child: Text(
                  'Контакты',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: widget._tabController.index == 2
                  ? Colors.blue
                  : ThemeData().scaffoldBackgroundColor,
              child: Center(
                child: Text(
                  'Отзывы',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 130.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 3.w,
                ),
                child: Text('Местоположение'),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 5.h),
                child: Text('Калининград, Товарный переулок'),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 5.h),
                child: Text('Почтовый индекс 236044'),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 5.h),
                child: Text('Название строения'),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 5.h),
                child: Text('Тип сооружения'),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 130.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 3.w,
                ),
                child: Text('Описание'),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 5.h),
                  child: Flexible(
                    child: Text(
                        'бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла '),
                  )),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 130.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 3.w,
                ),
                child: Text('Описание'),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 5.h),
                  child: Flexible(
                    child: Text(
                        'бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла '),
                  )),
            ],
          ),
        ),
        DefaultButton(
          onTap: () => print('hello'),
          width: double.infinity,
          height: 50.h,
          color: Colors.blue,
          label: 'Перейти на страницу организации',
          haveShadow: true,
        ),
      ],
    );
  }
}
