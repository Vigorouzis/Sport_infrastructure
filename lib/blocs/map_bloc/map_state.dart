import 'package:equatable/equatable.dart';
import 'package:sport_infrastructure/models/place.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialMapState extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final List<Place> markers;

  const MapLoaded({this.markers});

  @override
  List<Object> get props => [markers];
}

class MapFailure extends MapState {}
