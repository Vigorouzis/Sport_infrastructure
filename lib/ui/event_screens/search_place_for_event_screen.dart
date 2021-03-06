import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/widgets/widgets.dart';

import '../../blocs/places_list_bloc/places_list_bloc.dart';
import '../../blocs/places_list_bloc/places_list_event.dart';
import '../../blocs/places_list_bloc/places_list_state.dart';
import '../../models/place.dart';
import '../../resources/place_repository.dart';
import '../../widgets/text_fields.dart';
import 'package:sport_infrastructure/utils/utils.dart';

class SearchPlaceForEventScreen extends StatefulWidget {
  const SearchPlaceForEventScreen({Key key}) : super(key: key);

  @override
  _SearchPlaceForEventScreenState createState() =>
      _SearchPlaceForEventScreenState();
}

class _SearchPlaceForEventScreenState extends State<SearchPlaceForEventScreen> {
  TextEditingController _searchController;
  PlacesListBloc _bloc;
  PlaceRepository _placeRepository = PlaceRepository();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _bloc = PlacesListBloc(_placeRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Место'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => PlacesListBloc(_placeRepository),
        child: Builder(
          builder: (context) => BlocBuilder<PlacesListBloc, PlacesListState>(
            bloc: _bloc,
            builder: (context, state) => Column(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: SearchTextField(
                          controller: _searchController,
                          hintText: 'Введите место',
                          leading: Icon(Icons.search),
                        ),
                      ),
                      DefaultButton(
                        onTap: () => _bloc.add(
                          PlacesListFetched(placeSearch: _searchController.text),
                        ),
                        height: 50.h,
                        width: 100.w,
                        color: Colors.blue,
                        haveShadow: true,
                        label: 'Найти',
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                if (state is PlacesListLoaded)
                  PlaceListView(
                    places: state.places,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlaceListView extends StatelessWidget {
  final List<Place> _places;

  const PlaceListView({List<Place> places}) : _places = places;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: ListView.builder(
        itemCount: _places.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(_places[index]),
            child: Card(
              child: ListTile(
                title: Text(_places[index].name),
                subtitle: Text(_places[index].address),
                trailing: Text(_places[index].buildingType),
              ),
            ),
          );
        },
      ),
    );
  }
}
