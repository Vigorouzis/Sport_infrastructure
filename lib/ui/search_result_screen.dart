import 'package:flutter/material.dart';
import 'package:sport_infrastructure/models/place.dart';
import 'package:sport_infrastructure/ui/detail_screen.dart';

class SearchResultScreen extends StatefulWidget {
  final List<Place> _places;

  const SearchResultScreen({Key key, List<Place> places})
      : _places = places,
        super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: widget._places.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DetailScreen(
                            place: widget._places[index],
                          ))),
              child: Card(
                child: ListTile(
                  title: Text(widget._places[index].name),
                  subtitle: Text(widget._places[index].address),
                  trailing: Text(widget._places[index].buildingType),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
