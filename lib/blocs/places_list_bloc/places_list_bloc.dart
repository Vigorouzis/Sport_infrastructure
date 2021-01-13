import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_event.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_state.dart';

class PlacesListBloc extends Bloc<PlacesListEvent, PlacesListState>{
  //TODO: Created http controller class
  PlacesListBloc(PlacesListState initialState) : super(InitialPlacesListState());



  @override
  Stream<PlacesListState> mapEventToState(PlacesListEvent event) async* {
   if(event is PlacesListFetched) {
     try {
       yield PlacesListLoading();
       //TODO: Get data from server
       yield PlacesListLoaded();
     }
     catch (_){
       yield PlacesListFailure();
     }
   }
  }

}