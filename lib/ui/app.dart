import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_infrastructure/blocs/places_list_bloc/places_list_bloc.dart';
import 'package:sport_infrastructure/resources/place_repository.dart';
import 'package:sport_infrastructure/ui/place_screen.dart';
import 'package:sport_infrastructure/ui/widgets/map_screen.dart';

class App extends StatelessWidget {
  final _placeRepository = PlaceRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlacesListBloc(_placeRepository),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        initialRoute: '/',
        routes:{
      '/': (context) => PlaceScreen(),
      '/map_screen': (context) => MapScreen(),
      },
      ),
    );
  }
}
