import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/details_screen_bloc/details_screen_event.dart';
import 'package:sport_infrastructure/blocs/details_screen_bloc/details_screen_state.dart';

class DetailsScreenBloc extends Bloc<DetailsScreenEvent, DetailsScreenState> {
  DetailsScreenBloc() : super(InitialMapState());

  @override
  Stream<DetailsScreenState> mapEventToState(DetailsScreenEvent event) async* {}
}
