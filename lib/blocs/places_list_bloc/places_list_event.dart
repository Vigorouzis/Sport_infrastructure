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
