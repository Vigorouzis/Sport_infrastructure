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

class _DetailScreenState extends State<DetailScreen> {
  PlaceRepository _placeRepository;
  DetailsScreenBloc _detailsScreenBloc;

  @override
  void initState() {
    super.initState();
    _placeRepository = PlaceRepository();
    _detailsScreenBloc = DetailsScreenBloc(_placeRepository);
    _detailsScreenBloc.add(GetMapLocations());
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
                    cubit: _detailsScreenBloc,
                      builder: (context, state) {
                        print(state);
                        if (state is DetailsScreenLoaded) {
                          return Column(
                            children: [
                              Map(location: state.location,),
                              ButtonBar(
                                children: [
                                  DefaultButton(
                                    onTap: () => print('hello'),
                                    label: 'Места',
                                    height: 50,
                                    width: 100,
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    haveShadow: true,
                                  ),
                                  DefaultButton(
                                    onTap: () => print('hello'),
                                    label: 'Места',
                                    height: 50,
                                    width: 100,
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    haveShadow: true,
                                  ),
                                  DefaultButton(
                                    onTap: () => print('hello'),
                                    label: 'Места',
                                    height: 50,
                                    width: 100,
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    haveShadow: true,
                                  )
                                ],
                              )
                            ],
                          );
                        }
                        return Container();
                      }
                  ),
            ),
          ),
        ));
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
