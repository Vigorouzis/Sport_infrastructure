import 'package:flutter/material.dart';
import 'package:sport_infrastructure/models/place.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';
import 'package:sport_infrastructure/ui/widgets/place_list.dart';

class PlaceScreen extends StatelessWidget {
  final _placeRepository = PlaceRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PlaceList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.map),
          onPressed: () {
            Navigator.pushNamed(context, '/map_screen');
          },
        ),
      ),
    );
  }
}
