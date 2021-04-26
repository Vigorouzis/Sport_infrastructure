import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/models/organization.dart';
import 'package:sport_infrastructure/models/place.dart';

abstract class PlacesListState extends Equatable {
  const PlacesListState();

  @override
  List<Object> get props => [];
}

class InitialPlacesListState extends PlacesListState {}

class PlacesListLoading extends PlacesListState {}

class PlacesListLoaded extends PlacesListState {
  final List<Place> places;
  final List<Organization> organization;
  final LatLng currentPosition;

  const PlacesListLoaded(
      {this.places, this.organization, this.currentPosition});

  @override
  List<Object> get props => [places, organization];
}

class PlacesListFailure extends PlacesListState {}
