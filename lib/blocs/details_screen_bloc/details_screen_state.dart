import 'package:equatable/equatable.dart';

abstract class DetailsScreenState extends Equatable {
  const DetailsScreenState();

  @override
  List<Object> get props => [];
}

class InitialMapState extends DetailsScreenState {}

class DetailsScreenLoading extends DetailsScreenState {}

class DetailsScreenLoaded extends DetailsScreenState {}

class DetailsScreenFailure extends DetailsScreenState {}
