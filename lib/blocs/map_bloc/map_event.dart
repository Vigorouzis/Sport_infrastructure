import 'package:equatable/equatable.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetMapLocations extends MapEvent {}
