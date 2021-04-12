import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/models/place.dart';

abstract class DetailsScreenState extends Equatable {
  const DetailsScreenState();

  @override
  List<Object> get props => [];
}

class InitialMapState extends DetailsScreenState {}

class DetailsScreenLoading extends DetailsScreenState {}

class DetailsScreenLoaded extends DetailsScreenState {}

class DetailsScreenFailure extends DetailsScreenState {}
