import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_bloc.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_event.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_state.dart';
import 'package:sport_infrastructure/models/organization.dart';
import 'package:sport_infrastructure/models/place.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';
import 'package:sport_infrastructure/ui/detail_screen.dart';
import 'package:sport_infrastructure/ui/details_screen_for_organization.dart';

class SearchResultScreen extends StatefulWidget {
  final bool _isPlace;
  final bool _isOrganization;
  final String _requestText;

  const SearchResultScreen(
      {bool isPlace = false, bool isOrganization = false, String requestText})
      : _isPlace = isPlace,
        _isOrganization = isOrganization,
        _requestText = requestText;

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  PlaceRepository _placeRepository;
  PlacesListBloc _placesListBloc;

  @override
  void initState() {
    super.initState();
    _placeRepository = PlaceRepository();
    _placesListBloc = PlacesListBloc(_placeRepository);
    if (widget._isPlace == true) {
      _placesListBloc.add(PlacesListFetched(placeSearch: widget._requestText));
    }
    if (widget._isOrganization == true) {
      _placesListBloc.add(
          OrganizationListFetched(organizationSearch: widget._requestText));
    }
  }

  @override
  void dispose() {
    _placesListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты поиска'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: BlocProvider(
        create: (_) => PlacesListBloc(_placeRepository),
        child: Builder(
          builder: (context) => BlocBuilder<PlacesListBloc, PlacesListState>(
            bloc: _placesListBloc,
            builder: (context, state) {
              if (state is PlacesListLoaded) {
                return widget._isPlace
                    ? PlaceListView(
                        places: state.places,
                      )
                    : OrganizationListView(
                        organization: state.organization,
                        places: state.places,
                        currentGeoPosition: state.currentPosition,
                      );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      )),
    );
  }
}

class PlaceListView extends StatelessWidget {
  final List<Place> _places;

  const PlaceListView({List<Place> places}) : _places = places;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _places.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DetailScreen(
                        place: _places[index],
                      ))),
          child: Card(
            child: ListTile(
              title: Text(_places[index].name),
              subtitle: Text(_places[index].address),
            ),
          ),
        );
      },
    );
  }
}

class OrganizationListView extends StatelessWidget {
  final List<Organization> _organization;
  final List<Place> _places;
  final LatLng _currentGeoPosition;

  const OrganizationListView(
      {List<Organization> organization,
      List<Place> places,
      LatLng currentGeoPosition})
      : _organization = organization,
        _places = places,
        _currentGeoPosition = currentGeoPosition;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _organization.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreenForOrganization(
                organization: _organization[index],
                places: _places,
                currentGeoPosition: _currentGeoPosition,
              ),
            ),
          ),
          child: Card(
            child: ListTile(
              title: Text(_organization[index].name),
              subtitle: Text(_organization[index].description),
              trailing: Text('Организация'),
            ),
          ),
        );
      },
    );
  }
}
