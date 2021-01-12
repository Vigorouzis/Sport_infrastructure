import 'package:sport_infrastructure/models/place.dart';

import 'abonement.dart';

class Organization {
  String id;
  String name;
  String mainAddress;
  List<Abonement> abonements;
  List<Place> places;
  List<String> categoriesIDs;
  List<String> tagsUIDs;

  Organization(this.id, this.name, this.mainAddress, this.abonements,
      this.places, this.categoriesIDs, this.tagsUIDs);
}
