import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/models/event.dart';
import 'package:sport_infrastructure/models/place.dart';
import 'package:sport_infrastructure/widgets/widgets.dart';
import 'package:sport_infrastructure/utils/utils.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;
  final Place place;

  const EventDetailScreen({Key key, this.event, this.place}) : super(key: key);

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
      body: SafeArea(
        child: Column(
          children: [
            Map(
              location: LatLng(widget.place.longitude, widget.place.latitude),
            ),
            _TabOne(
              place: widget.place,
              event: widget.event,
            ),
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

class _TabOne extends StatelessWidget {
  final Place _place;
  final Event _event;

  const _TabOne({Key key, Place place, Event event})
      : _place = place,
        _event = event,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 130.h,
          child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    'Название',
                    style: AppTypography.font18SF,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 5.h),
                  child: Flexible(
                    child: Text(
                      _event.name,
                      style: AppTypography.font18SF,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Text(
                    'Описание',
                    style: AppTypography.font18SF,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 5.h),
                  child: Flexible(
                    child: Text(
                      _event.description,
                      style: AppTypography.font18SF,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.grey[300],
          width: double.infinity,
          height: 130.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.w),
                child: Text(
                  'Дата и время проведения',
                  style: AppTypography.font18SF,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Flexible(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          _event.dates,
                          style: AppTypography.font18SF,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          _event.time,
                          style: AppTypography.font18SF,
                        ),
                      ),
                    ],
                  ),
                ),
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
                padding: EdgeInsets.only(top: 10.h, left: 10.w),
                child: Row(
                  children: [
                    Text(
                      'Максимальное число участников:',
                      style: AppTypography.font18SF,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Text(
                        "${_event.visitorLimit}",
                        style: AppTypography.font18SF,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: _event.isPrivate ? Text('Приватное') : null
              ),
            ],
          ),
        ),
        DefaultButton(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Вы присоединились к событию'),
            ),
          ),
          textColor: AppColors.white,
          color: AppColors.blue007AFF,
          label: 'Присоединиться',
          height: 40.h,
          width: 328.w,
          haveShadow: true,
        ),
      ],
    );
  }
}
