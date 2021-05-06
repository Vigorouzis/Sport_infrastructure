import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/models/organization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_infrastructure/models/place.dart';

class DetailScreenForOrganization extends StatefulWidget {
  final Organization _organization;
  final List<Place> _places;
  final LatLng _currentGeoPosition;

  const DetailScreenForOrganization(
      {Organization organization,
      List<Place> places,
      LatLng currentGeoPosition})
      : _organization = organization,
        _places = places,
        _currentGeoPosition = currentGeoPosition;

  @override
  _DetailScreenForOrganizationState createState() =>
      _DetailScreenForOrganizationState();
}

class _DetailScreenForOrganizationState
    extends State<DetailScreenForOrganization>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  LatLng _currentGeo;
  List<LatLng> _locations = [];

  void setLocations() {
    for (var i in widget._places) {
      _locations.add(LatLng(i.longitude, i.latitude));
    }
  }

  @override
  void initState() {
    super.initState();
    setLocations();
    _tabController = TabController(length: 3, vsync: this);
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
        title: Text(widget._organization.name),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Map(
              locations: _locations,
              currentGeo: widget._currentGeoPosition,
            ),
            TabButtons(
              controller: _tabController,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _TabOne(
                      organization: widget._organization,
                    ),
                    _TabTwo(),
                    _TabThree(
                      places: widget._places,
                    ),
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
  final List<LatLng> locations;
  final LatLng currentGeo;

  const Map({this.locations, this.currentGeo});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController _mapController;

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    int index = 0;
    for (var i in widget.locations) {
      if (i != null) {
        index++;
        Marker startMarker = Marker(
          markerId: MarkerId('position $index'),
          position: LatLng(
            i.latitude,
            i.longitude,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );
        _markers.add(startMarker);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.h,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.currentGeo,
          zoom: 10,
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
                  'Места',
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
  final Organization _organization;
  final List<Place> _places;

  const _TabOne({Organization organization, List<Place> places})
      : _organization = organization,
        _places = places;

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
                child: Text(_organization.name),
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
                  children: [],
                )),
              ),
            ],
          ),
        ),
      ],
    );
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
              child: Text(_place.webSite.isNotEmpty
                  ? 'https://www.${_place.webSite}'
                  : 'Не указано'),
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
                        child: Text(_place.instagram.isNotEmpty
                            ? _place.instagram
                            : 'Не указано'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(_place.twitter.isNotEmpty
                            ? _place.twitter
                            : 'Не указано'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(_place.facebook.isNotEmpty
                            ? _place.facebook
                            : 'Не указано'),
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
                  Text(
                      _place.email.isNotEmpty ? _place.facebook : 'Не указано'),
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}

class _TabThree extends StatelessWidget {
  final List<Place> _places;

  const _TabThree({
    List<Place> places,
  }) : _places = places;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _places.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(_places[index].name),
            subtitle: Text(_places[index].address),
            trailing: Text(_places[index].buildingType),
          ),
        );
      },
    );
  }
}
