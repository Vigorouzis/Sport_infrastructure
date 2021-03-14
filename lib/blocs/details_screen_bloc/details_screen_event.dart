import 'package:equatable/equatable.dart';

abstract class DetailsScreenEvent extends Equatable {
  const DetailsScreenEvent();

  @override
  List<Object> get props => [];
}

class GetMapLocations extends DetailsScreenEvent {}
