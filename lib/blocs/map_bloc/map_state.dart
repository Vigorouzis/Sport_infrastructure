import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/models/place.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class InitialMapState extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final LatLng location;

  const MapLoaded({this.location});

  @override
  List<Object> get props => [location];
}

class MapFailure extends MapState {}
