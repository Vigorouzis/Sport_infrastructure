import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_bloc.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_event.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_state.dart';
import 'package:sport_infrastructure/models/place.dart';
import 'package:sport_infrastructure/ui/widgets/place_list.dart';

class PlaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PlacesListBloc(),
        child: HomePage(),
      ),
    );
  }
}

@immutable
class HomePage extends StatelessWidget {

  var places = [
    Place(
        id: '1',
        name: 'Nikita',
        description: 'Kanunov',
        isFreeVisit: true,
        abonements: null,
        basedOrganizations: null,
        holderOrganization: null,
        location: null,
        categoriesIDs: null,
        tagsUIDs: null)
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlacesListBloc(),
      child: Scaffold(
        body: PlaceList(),
      ),
    );
  }
}
