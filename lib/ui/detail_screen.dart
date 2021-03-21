import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/blocs/details_screen_bloc/details_screen.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';
import 'package:sport_infrastructure/widgets/buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  PlaceRepository _placeRepository;
  DetailsScreenBloc _detailsScreenBloc;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _placeRepository = PlaceRepository();
    _tabController = TabController(length: 3, vsync: this);
    _detailsScreenBloc = DetailsScreenBloc(_placeRepository);
    _detailsScreenBloc.add(GetMapLocations());
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Альботрос Юг'),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => DetailsScreenBloc(_placeRepository),
          child: Builder(
            builder: (context) =>
                BlocBuilder<DetailsScreenBloc, DetailsScreenState>(
              bloc: _detailsScreenBloc,
              builder: (context, state) {
                print(state);
                if (state is DetailsScreenLoaded) {
                  return Column(
                    children: [
                      Map(
                        location: state.location,
                      ),
                      TabButtons(
                        controller: _tabController,
                      ),
                      Container(
                        width: double.infinity,
                        height: 468.h,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                             _TabOne(),
                             _TabOne(),
                             _TabOne(),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Container();
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
  GoogleMapController _mapController;

  Map({this.location});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        onMapCreated: (GoogleMapController controller) {
          widget._mapController = controller;
        },
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

