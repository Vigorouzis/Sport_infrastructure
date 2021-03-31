import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/blocs/details_screen_bloc/details_screen.dart';
import 'package:sport_infrastructure/models/place.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';
import 'package:sport_infrastructure/widgets/buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final Place _place;

  DetailScreen({Place place}) : _place = place;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _hours;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _hours = widget._place.openingHours.split(RegExp('\n'));
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        child: Column(
          children: [
            Map(
              location: LatLng(widget._place.longitude, widget._place.latitude),
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
                    _TabOne(
                      place: widget._place,
                      hours: _hours,
                    ),
                    _TabTwo(
                      place: widget._place,
                    ),
                    _TabOne(),
                  ],
                ),
              ),
            )
          ],
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
  GoogleMapController _mapController;

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    Marker startMarker = Marker(
      markerId: MarkerId('position'),
      position: LatLng(
        widget.location.latitude,
        widget.location.longitude,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    _markers.add(startMarker);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.h,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.location,
          zoom: 12,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
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
  final Place _place;
  final List<String> _hours;

  const _TabOne({Place place, List<String> hours})
      : _place = place,
        _hours = hours;

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
                child: Text(_place.address),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 5.h),
                child: Text(_place.postIndex),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 5.h),
                child: Text(_place.name),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 5.h),
                child: Text(_place.buildingType),
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
                    child: Text(_place.description),
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
                child: Text('Часы работы'),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 5.h),
                child: Flexible(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(_hours[0]),
                        Text(_hours[1]),
                        Text(_hours[2]),
                        Text(''),
                      ],
                    ),
                    Column(
                      children: [
                        Text(_hours[3]),
                        Text(_hours[4]),
                        Text(_hours[5]),
                        Text(_hours[6]),
                      ],
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
        DefaultButton(
          onTap: () => _launchInBrowser('https://www.${_place.webSite}'),
          width: double.infinity,
          height: 50.h,
          color: Colors.blue,
          label: 'Перейти на страницу организации',
          haveShadow: true,
        ),
      ],
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}

class _TabTwo extends StatelessWidget {
  final Place _place;

  const _TabTwo({
    Place place,
  }) : _place = place;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: Colors.grey[300],
        width: MediaQuery.of(context).size.width,
        height: 80.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 3.w,
              ),
              child: Text('Сайт'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 5.h),
              child: Text(_place.webSite.isNotEmpty? 'https://www.${_place.webSite}': 'Не указано'),
            )
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 100.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 3.w,
              ),
              child: Text('Телефоны'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 5.h),
              child: Column(
                children: [
                  Text(_place.phone ?? 'Не указано'),
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        color: Colors.grey[300],
        width: MediaQuery.of(context).size.width,
        height: 150.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 3.w,
              ),
              child: Text('Социальные сети'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('ВК'),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text('Instagram'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text('Twitter'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text('Facebook'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(_place.vk.isNotEmpty ? _place.vk : 'Не указано'),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(_place.instagram.isNotEmpty ? _place.instagram : 'Не указано'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(_place.twitter.isNotEmpty ? _place.twitter : 'Не указано'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(_place.facebook.isNotEmpty ? _place.facebook : 'Не указано'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),

      Container(
        width: MediaQuery.of(context).size.width,
        height: 50.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 3.w,
              ),
              child: Text('Почта'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 5.h),
              child: Column(
                children: [
                  Text(_place.email.isNotEmpty ? _place.facebook : 'Не указано'),
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
