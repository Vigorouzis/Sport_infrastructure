import 'package:equatable/equatable.dart';

abstract class PlacesListEvent extends Equatable {
  const PlacesListEvent();

  @override
  List<Object> get props => [];
}

class PlacesListFetched extends PlacesListEvent {
  final String placeSearch;

  const PlacesListFetched({this.placeSearch});
}

class OrganizationListFetched extends PlacesListEvent {
  final String organizationSearch;

  const OrganizationListFetched({this.organizationSearch});
}

