
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_bloc.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_event.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_state.dart';



class PlaceList extends StatefulWidget {
  @override
  _PlaceListState createState() => _PlaceListState();
}



class _PlaceListState extends State<PlaceList> {
  PlacesListBloc _placesListBloc;

  @override
  void initState() {
    super.initState();
    _placesListBloc = BlocProvider.of<PlacesListBloc>(context);
    _placesListBloc.add(PlacesListFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesListBloc, PlacesListState>(
        builder: (context, state) {
          if (state is PlacesListLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PlacesListFailure) {
            return Center(
              child: Text('failed to fetch place'),
            );
          }
          if (state is PlacesListLoaded) {
            return ListView.builder(
                itemCount: state.places.length,
                itemBuilder: (context, index) => Container(
                  child: ListTile(
                    leading: Text('$index'),
                    title: Column(
                      children: [
                        Text('${state.places[index].name}'),
                      ],
                    ),
                  ),
                ));
          }
          return null;
        });
  }

  @override
  void dispose() {
    super.dispose();
    _placesListBloc.drain();
  }
}

