import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/create_event_bloc/create_events_event.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final PlaceRepository _placeRepository;

  CreateEventBloc(this._placeRepository) : super(InitialCreateEventState());

  @override
  Stream<CreateEventState> mapEventToState(CreateEventEvent event) async* {
    if (event is CreateEventFetched) {
      yield CreateEventLoading();
      try {
        var places =
            await _placeRepository.getPlaceByName(value: event.placeSearch);
        yield CreateEventLoaded(places: places);
      } catch (_) {
        yield CreateEventFailure();
      }
    }

    if (event is OrganizationListFetched) {
      yield CreateEventLoading();
      try {
        var places = await _placeRepository.getPlaceByName(
            value: event.organizationSearch);
        var organization = await _placeRepository.getOrganizationByName(
            value: event.organizationSearch);

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        var currentPosition = LatLng(position.latitude, position.longitude);
        yield CreateEventLoaded(
            organization: organization,
            places: places,
            currentPosition: currentPosition);
      } catch (_) {
        yield CreateEventFailure();
      }
    }
  }
}
